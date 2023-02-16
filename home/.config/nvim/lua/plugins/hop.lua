return {
  "phaazon/hop.nvim",
  cmd = { "HopWord", "HopChar1" },
  config = function()
    require("hop").setup()
  end,
}
