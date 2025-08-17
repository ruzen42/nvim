return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20, 
        open_mapping = [[<C-\>]], 
        hide_numbers = true, 
        shade_terminals = true, 
        start_in_insert = true,
        insert_mappings = true, 
        direction = "horizontal", 
        close_on_exit = true, 
        shell = vim.o.shell, 
      })

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
          cmd = "true"
          return
        end
        vim.cmd("ToggleTerm")
        vim.api.nvim_feedkeys(cmd .. "\n", "n", false)
      end, { desc = "Run current file in ToggleTerm" })
    end,
  },
}
