--- Aliases
local lsp = require 'lspconfig'

-- rust
lsp.rls.setup {
  settings = {
    rust = {
      racer_completion = false,
      wait_to_build = 200,
    }
  }
}

-- html
lsp.html.setup {}

-- json
lsp.json.setup {}
