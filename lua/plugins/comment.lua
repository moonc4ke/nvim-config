return {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup({
        -- This will ensure we always use single-line comments, not block comments
        pre_hook = function(ctx)
          -- Only calculate commentstring for languages that might have block comments
          local U = require('Comment.utils')

          -- Always force line comment style (single-line comments)
          -- ctx.ctype = U.ctype.line
          return require('Comment.ft').calculate(ctx, { ctype = U.ctype.line }) or vim.bo.commentstring
        end,
      })
    end,
  }
}
