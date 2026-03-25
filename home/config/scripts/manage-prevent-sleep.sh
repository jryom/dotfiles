#!/usr/bin/env bash
STATE_FILE="/tmp/prevent-sleep.state"
INVALID_INPUT_MSG="Invalid input. Enter HH:MM or minutes."

notify() { osascript -e "display notification \"$1\" with title \"Prevent Sleep\"" 2>/dev/null || true; }
now_ts() { date +%s; }
read_end() { cat "$STATE_FILE" 2>/dev/null; }
write_end() { echo "$1" >"$STATE_FILE"; }
stop_caffeinate() { pkill -f "caffeinate -i" >/dev/null 2>&1 || true; }
start_caffeinate_for() {
	local secs="$1"
	[ "$secs" -gt 0 ] && caffeinate -i -d -t "$secs" &
}
remaining_seconds() {
	local end="$1"
	echo $((end - $(now_ts)))
}
ensure_swiftbar() {
	if ! pgrep -x SwiftBar >/dev/null 2>&1; then
		open -ga SwiftBar >/dev/null 2>&1 || true
		sleep 1
	fi
	osascript -e 'tell application "SwiftBar" to refresh all' >/dev/null 2>&1 || true
}

status_output() {
	local end rem
	end=$(read_end)
	[[ "$end" =~ ^[0-9]+$ ]] || {
		echo disabled
		return 1
	}
	rem=$(remaining_seconds "$end")
	[ "$rem" -le 0 ] && {
		echo disabled
		return 1
	}
	echo "remaining=$rem end=$end"
}

disable() {
	stop_caffeinate
	rm -f "$STATE_FILE"
	notify "Disabled"
	exit 0
}

parse_input_to_epoch() {
	local input="$1" now epoch
	if [[ "$input" =~ ^[0-9]+$ ]] && [ "$input" -gt 0 ]; then
		now=$(now_ts)
		epoch=$((now + input * 60))
	elif [[ "$input" =~ ^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ ]]; then
		epoch=$(date -j -f "%Y-%m-%d %H:%M" "$(date +%F) $input" +%s 2>/dev/null) || {
			notify "$INVALID_INPUT_MSG"
			return 1
		}
		now=$(now_ts)
		[ "$epoch" -le "$now" ] && epoch=$(date -j -f "%Y-%m-%d %H:%M" "$(date -v+1d +%F) $input" +%s)
	else
		notify "$INVALID_INPUT_MSG"
		return 1
	fi
	echo "$epoch"
}

start_until_epoch() {
	local epoch="$1"
	local now
	now="$(now_ts)"
	[ "$epoch" -gt "$now" ] || {
		notify "Time already passed."
		return 1
	}
	stop_caffeinate
	start_caffeinate_for "$((epoch - now))"
	write_end "$epoch"
	ensure_swiftbar
	notify "Enabled until $(date -r "$epoch" +%H:%M)"
}

if [ "$1" = "status" ]; then
	status_output
	exit $?
fi

if [ -n "$1" ] && [ "$1" != "toggle" ]; then
	[ "$1" = "disable" ] && disable
	epoch=$(parse_input_to_epoch "$1") || exit 1
	start_until_epoch "$epoch" || exit 1
	exit 0
fi

if [ "$1" = "toggle" ]; then
	t=$(osascript -e 'display dialog "Enter time (HH:MM or minutes; empty disables):" default answer ""' -e 'text returned of result' 2>/dev/null) || disable
	[ -z "$t" ] && disable
	epoch=$(parse_input_to_epoch "$t") || disable
	start_until_epoch "$epoch" || disable
	exit 0
fi

end=$(read_end)
[[ "$end" =~ ^[0-9]+$ ]] || exit 0
[ "$(now_ts)" -gt "$end" ] && disable
