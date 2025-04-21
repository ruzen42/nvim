return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Иконки для VimTree
    },
    lazy = false, -- Загружать сразу, чтобы избежать задержек при вызове
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30, -- Ширина панели
          side = "right", -- Панель слева
        },
        renderer = {
          group_empty = true, -- Группировать пустые папки
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false, -- Показывать скрытые файлы (можно включить с <leader>h)
        },
        git = {
          enable = true, -- Интеграция с Git
          ignore = false,
        },
      })

      -- Привязки клавиш для VimTree
      vim.keymap.set("n", "<C-l>", ":NvimTreeToggle<CR>", { desc = "Toggle VimTree" })
      vim.keymap.set("n", "<C-n", ":NvimTreeFocus<CR>", { desc = "Focus VimTree" })
    end,
  },
}
