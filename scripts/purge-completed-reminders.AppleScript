set weekAgo to (current date) - (7 * days)

tell application "Reminders"
  with timeout of 360 seconds
    delete (every reminder whose completion date is less than weekAgo)
  end timeout
  quit
end tell
