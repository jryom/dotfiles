vim.opt.tabline = "%!v:lua.Tabline()"

local function predicate(buffer)
  return vim.bo[buffer].buftype ~= "nofile"
end

function Tabline()
  local tabline = ""

  for tab_nr = 1, vim.fn.tabpagenr("$") do
    if tab_nr == vim.fn.tabpagenr() then
      tabline = tabline .. "%#TabLineSel#"
    else
      tabline = tabline .. "%#TabLine#"
    end

    tabline = tabline .. "   "
    tabline = tabline .. "%" .. tab_nr .. "T"
    tabline = tabline .. tab_nr .. ". "

    local tabname = ""

    local valid_buffers = {}

    for _, buf_nr in ipairs(vim.fn.tabpagebuflist(tab_nr)) do
      if predicate(buf_nr) then
        table.insert(valid_buffers, buf_nr)
      end
    end

    for idx, buf_nr in ipairs(valid_buffers) do
      local buffername = vim.api.nvim_buf_get_name(buf_nr)
      local buftype = vim.bo[buf_nr].buftype

      if buftype == "help" then
        buffername = vim.fn.fnamemodify(buffername, ":t:s/.txt$/ /") .. "[H]"
      elseif buftype == "quickfix" then
        buffername = buffername .. "[Q]"
      elseif buffername == "" then
        buffername = "[No Name]"
      else
        buffername = vim.fn.fnamemodify(buffername, ":t")
      end

      if vim.bo[buf_nr].modified then
        buffername = buffername .. " +"
      end

      if idx < table.getn(valid_buffers) then
        buffername = buffername .. " | "
      end

      tabname = tabname .. buffername
    end

    tabline = tabline .. tabname .. "  ▕"
  end

  return tabline .. "%#TabLineFill#%T"
end
