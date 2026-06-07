return {
  "joryeugene/dadbod-grip.nvim",
  url = "https://github.com/Kimilhee/dadbod-grip.nvim",
  branch = "main",
  keys = {
    { "<leader>db", "<cmd>GripConnect<cr>", desc = "DB connect" },
    { "<leader>dg", "<cmd>Grip<cr>", desc = "DB grid" },
    { "<leader>dt", "<cmd>GripTables<cr>", desc = "DB tables" },
    { "<leader>dq", "<cmd>GripQuery<cr>", desc = "DB query pad" },
    { "<leader>ds", "<cmd>GripSchema<cr>", desc = "DB schema" },
    { "<leader>dh", "<cmd>GripHistory<cr>", desc = "DB history" },
    { "<leader>dd", "<cmd>GripStart<cr>", desc = "DB demo" },
  },
  opts = {
    picket = "snacks",
    -- ai = {
    --   provider = nil, -- nil = auto-detect, or "anthropic"/"openai"/"gemini"/"ollama"
    --   model = nil, -- nil = provider default
    --   api_key = nil, -- nil = env var, "env:VAR", "cmd:op read ...", or direct string
    --   base_url = nil, -- override for ollama or proxy
    -- },
  },
}
