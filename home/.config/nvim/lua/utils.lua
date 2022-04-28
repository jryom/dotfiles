-- retrieve stdout from cmd
function os.capture(cmd)
  local prog = io.popen(cmd, "r")
  local output = prog:read("*a")

  prog:close()

  return output:gsub("^%s*(.-)%s*$", "%1")
end
