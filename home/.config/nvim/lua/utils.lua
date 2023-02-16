local open = io.open

Utils = {}

function Utils:read_file(path)
  local file = open(path, "rb")
  if not file then
    return nil
  end
  local content = file:read("*a")
  file:close()
  return content
end
