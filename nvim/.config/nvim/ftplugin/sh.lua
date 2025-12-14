-- this does not work
local dap = require("dap")
dap.adapters.bashdb = {
  type = 'executable',
  command = "bashdb",
  name = 'bashdb',
}

dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = '/usr/share/bashdb',
    pathBashdbLib = '/usr/share/bashdb/lib',
    -- trace = true,
    file = "/home/rens/dotfiles/nvim/.config/test.sh",
    program = "/home/rens/dotfiles/nvim/.config/test.sh",
    -- cwd = '${workspaceFolder}',
    pathCat = "cat",
    pathBash = "/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {"-c"},
    argsString = '',
    env = {},
    terminalKind = "integrated",
  }
}

