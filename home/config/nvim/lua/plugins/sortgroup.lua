---@type LazySpec
return {
  "https://gist.github.com/PeterRincker/582ea9be24a69e6dd8e237eb877b8978",
  name = "sort-group",
  build = function(plugin)
    os.execute(string.format(
      [[
        path=%s
        mkdir -p $path/plugin
        cp $path/*.vim $path/plugin/
      ]],
      plugin.dir
    ))
  end,
}
