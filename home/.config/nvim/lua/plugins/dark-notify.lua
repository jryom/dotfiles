return {
  "cormacrelf/dark-notify",
  event = "CursorHold",
  config = function()
    require("dark_notify").run()
  end,
}
