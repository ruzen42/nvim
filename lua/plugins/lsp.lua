return {
  -- LSP серверы
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Утилита для установки LSP-серверов
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },
      -- Полезные статус-обновления для LSP
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- Настройка LSP серверов
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Список серверов для установки
      local servers = { "pyright", "ts_ls", "lua_ls", "rust_analyzer", "hls", "bashls" } -- Добавьте нужные серверы
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      -- Настройка каждого сервера
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          -- Пример: специфичные настройки для lua_ls
          settings = lsp == "lua_ls" and {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          } or {},
        })
      end
    end,
  },

  -- Автодополнение
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Источник автодополнения для LSP
      "hrsh7th/cmp-buffer", -- Источник для текста в буфере
      "hrsh7th/cmp-path", -- Источник для путей файлов
      "L3MON4D3/LuaSnip", -- Движок для сниппетов
      "saadparwaiz1/cmp_luasnip", -- Интеграция LuaSnip с cmp
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Подтверждение выбора
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
