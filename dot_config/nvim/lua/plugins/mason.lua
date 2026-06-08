return {
  "williamboman/mason.nvim",
  dependencies = {
    "Zeioth/mason-extra-cmds",
    opts = {},
  },
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUpdate",
    "MasonUpdateAll", -- Added by the extra-cmds plugin
  },
}
