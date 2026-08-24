#!/usr/bin/env bash

set -o nounset
set -o pipefail

NOTIFICATIONS_URL="https://github.com/notifications"
SCRIPT_PATH="${SWIFTBAR_PLUGIN_PATH:-$0}"
PLUGIN_ID=$(basename "${SWIFTBAR_PLUGIN_PATH:-$0}")
CACHE_DIR="${SWIFTBAR_PLUGIN_CACHE_PATH:-${XDG_CACHE_HOME:-$HOME/.cache}/swiftbar/$PLUGIN_ID}"
REVIEWS_STATE_FILE="$CACHE_DIR/requested-prs"
NOTIFICATIONS_STATE_FILE="$CACHE_DIR/inbox-notifications"
GITHUB_ICON=$(/usr/bin/base64 <"$(dirname "$SCRIPT_PATH")/../assets/github.svg" | /usr/bin/tr -d '\n')

for candidate in "$(command -v gh 2>/dev/null || true)" /opt/homebrew/bin/gh /usr/local/bin/gh /usr/bin/gh; do
  if [[ -x "$candidate" ]]; then
    GH="$candidate"
    break
  fi
done

for candidate in "$(command -v jq 2>/dev/null || true)" /opt/homebrew/bin/jq /usr/local/bin/jq /usr/bin/jq; do
  if [[ -x "$candidate" ]]; then
    JQ="$candidate"
    break
  fi
done

for candidate in "$(command -v terminal-notifier 2>/dev/null || true)" /opt/homebrew/bin/terminal-notifier /usr/local/bin/terminal-notifier; do
  if [[ -x "$candidate" ]]; then
    NOTIFIER="$candidate"
    break
  fi
done

fail() {
  printf '? | color=red templateImage=%s href=%s\n---\n%s\n' "$GITHUB_ICON" "$NOTIFICATIONS_URL" "$1"
  exit 0
}

[[ -n "${GH:-}" ]] || fail 'GitHub CLI is not installed.'
[[ -n "${JQ:-}" ]] || fail 'jq is not installed.'
[[ -n "${NOTIFIER:-}" ]] || fail 'terminal-notifier is not installed.'

open_urls() {
  while IFS= read -r url; do
    [[ -n "$url" ]] && open -g "$url"
  done
}

case "${1:-}" in
open-reviews)
  "$GH" search prs --review-requested=@me --state=open --archived=false --limit=1000 --json url --jq '.[].url' |
    open_urls
  exit 0
  ;;
open-notifications)
  "$GH" api --paginate --slurp 'notifications?all=false&participating=false&per_page=100' |
    "$JQ" -r '
				def web_url:
					if .subject.type == "PullRequest" then
						.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/") | sub("/pulls/"; "/pull/")
					elif .subject.type == "Issue" or .subject.type == "Discussion" then
						.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/")
					elif .subject.type == "Commit" then
						.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/") | sub("/commits/"; "/commit/")
					elif .subject.type == "Release" then
						.repository.html_url + "/releases"
					else
						"https://github.com/notifications"
					end;
				.[][] | select(.reason != "review_requested") | web_url
			' |
    open_urls
  exit 0
  ;;
esac

reviews=$("$GH" search prs --review-requested=@me --state=open --archived=false --limit=1000 --json number,repository,title,url 2>/dev/null) ||
  fail 'Could not retrieve pull requests.'
review_count=$("$JQ" -r 'length' <<<"$reviews") || fail 'Could not parse pull requests.'
[[ "$review_count" =~ ^[0-9]+$ ]] || fail 'GitHub returned an invalid pull request count.'
notifications_pages=$("$GH" api --paginate --slurp 'notifications?all=false&participating=false&per_page=100' 2>/dev/null) ||
  fail 'Could not retrieve GitHub notifications.'
notifications=$("$JQ" -c '[.[][] | select(.reason != "review_requested")]' <<<"$notifications_pages" 2>/dev/null) ||
  fail 'Could not parse GitHub notifications.'
notification_count=$("$JQ" -r 'length' <<<"$notifications")
[[ "$notification_count" =~ ^[0-9]+$ ]] || fail 'GitHub returned an invalid notification count.'
total_count=$((review_count + notification_count))

mkdir -p "$CACHE_DIR" || fail 'Could not create the plugin cache.'
current_reviews_state=$(mktemp "$CACHE_DIR/requested-prs.XXXXXX") || fail 'Could not create plugin state.'
current_notification_state=$(mktemp "$CACHE_DIR/notifications.XXXXXX") || fail 'Could not create plugin state.'
trap 'rm -f "$current_reviews_state" "$current_notification_state"' EXIT
"$JQ" -r '.[].url' <<<"$reviews" >"$current_reviews_state" || fail 'Could not prepare review state.'
"$JQ" -r '.[] | "\(.id):\(.updated_at)"' <<<"$notifications" >"$current_notification_state" ||
  fail 'Could not prepare notification state.'

if [[ -f "$REVIEWS_STATE_FILE" ]]; then
  while IFS=$'\t' read -r url repository title; do
    if ! grep -Fqx -- "$url" "$REVIEWS_STATE_FILE"; then
      "$NOTIFIER" \
        -title 'Review requested' \
        -subtitle "$repository" \
        -message "$title" \
        -open "$url" \
        -sound default \
        -group "github-review-$url" >/dev/null 2>&1 || true
    fi
  done < <(
    "$JQ" -r '
			.[] |
			[
				.url,
				.repository.nameWithOwner,
				("#" + (.number | tostring) + " " + (.title | gsub("[|\\r\\n\\t]"; " ")))
			] | @tsv
		' <<<"$reviews"
  )
fi

if [[ -f "$NOTIFICATIONS_STATE_FILE" ]]; then
  while IFS=$'\t' read -r key id repository reason title url; do
    if ! grep -Fqx -- "$key" "$NOTIFICATIONS_STATE_FILE"; then
      "$NOTIFIER" \
        -title "GitHub: ${reason//_/ }" \
        -subtitle "$repository" \
        -message "$title" \
        -open "$url" \
        -sound default \
        -group "github-notification-$id" >/dev/null 2>&1 || true
    fi
  done < <(
    "$JQ" -r '
			def web_url:
				if .subject.type == "PullRequest" then
					.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/") | sub("/pulls/"; "/pull/")
				elif .subject.type == "Issue" or .subject.type == "Discussion" then
					.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/")
				elif .subject.type == "Commit" then
					.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/") | sub("/commits/"; "/commit/")
				elif .subject.type == "Release" then
					.repository.html_url + "/releases"
				else
					"https://github.com/notifications"
				end;
			.[] |
			[
				("\(.id):\(.updated_at)"),
				.id,
				.repository.full_name,
				.reason,
				(.subject.title | gsub("[|\\r\\n\\t]"; " ")),
				web_url
			] | @tsv
		' <<<"$notifications"
  )
fi

mv "$current_reviews_state" "$REVIEWS_STATE_FILE" || fail 'Could not save review state.'
mv "$current_notification_state" "$NOTIFICATIONS_STATE_FILE" || fail 'Could not save notification state.'
trap - EXIT

if ((total_count == 0)); then
  exit 0
fi

printf '%s | templateImage=%s\n---\n' "$total_count" "$GITHUB_ICON"
printf 'Review requests (%s) | color=gray\n' "$review_count"
if ((review_count == 0)); then
  printf 'No reviews requested | color=gray\n'
else
  while IFS=$'\t' read -r repository number title url; do
    printf '%s #%s: %s | href=%s\n' "$repository" "$number" "$title" "$url"
  done < <(
    "$JQ" -r '
			.[] |
			[
				.repository.nameWithOwner,
				.number,
				(.title | gsub("[|\\r\\n\\t]"; " ")),
				.url
			] | @tsv
		' <<<"$reviews"
  )
  printf 'Open all review requests | bash=%s param1=open-reviews terminal=false\n' "$SCRIPT_PATH"
fi
printf '%s\n' '---'
printf 'Notifications (%s) | color=gray\n' "$notification_count"
if ((notification_count == 0)); then
  printf 'No unread notifications | color=gray\n'
else
  while IFS=$'\t' read -r repository reason title url; do
    printf '%s [%s]: %s | href=%s\n' "$repository" "${reason//_/ }" "$title" "$url"
  done < <(
    "$JQ" -r '
			def web_url:
				if .subject.type == "PullRequest" then
					.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/") | sub("/pulls/"; "/pull/")
				elif .subject.type == "Issue" or .subject.type == "Discussion" then
					.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/")
				elif .subject.type == "Commit" then
					.subject.url | sub("^https://api.github.com/repos/"; "https://github.com/") | sub("/commits/"; "/commit/")
				elif .subject.type == "Release" then
					.repository.html_url + "/releases"
				else
					"https://github.com/notifications"
				end;
			.[] |
			[
				.repository.full_name,
				.reason,
				(.subject.title | gsub("[|\\r\\n\\t]"; " ")),
				web_url
			] | @tsv
		' <<<"$notifications"
  )
  printf 'Open all notifications | bash=%s param1=open-notifications terminal=false\n' "$SCRIPT_PATH"
fi
