return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20, -- Высота терминала (для горизонтального сплита)
        open_mapping = [[<C-\>]], -- Открыть/закрыть терминал
        hide_numbers = true, -- Скрыть номера строк в терминале
        shade_terminals = true, -- Затемнение фона терминала
        start_in_insert = true, -- Начать в режиме вставки
        insert_mappings = true, -- Применять клавиши в режиме вставки
        direction = "horizontal", -- "horizontal", "vertical", "float"
        close_on_exit = true, -- Закрыть терминал, если команда завершилась
        shell = vim.o.shell, -- Использовать системную оболочку
      })

     -- Привязка для запуска файла
      vim.keymap.set("n", "<leader>r", function()
        local filetype = vim.bo.filetype
        local file = vim.fn.expand("%")
        local cmd
        if filetype == "haskell" then
          cmd = "runghc " .. file 
        elseif filetype == "python" then
          cmd = "python3 " .. file
        elseif filetype == "cpp" then
          cmd = "g++" .. file .. "&& ./a.out"
        else
          print("No runner for filetype: " .. filetype)
          return
        end
        vim.cmd("ToggleTerm")
        vim.api.nvim_feedkeys(cmd .. "\n", "n", false)
      end, { desc = "Run current file in ToggleTerm" })
    end,
  },
}
