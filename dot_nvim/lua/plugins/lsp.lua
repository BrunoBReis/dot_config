return {
  -- plugin de comunicacao do protocolo lsp 
  "neovim/nvim-lspconfig",

  dependencies = {
    -- gerenciador automatico dos servidores LSP 
    "williamboman/mason.nvim",
    -- ponte de conexao entre o mason.nvim e lspconfig
    "williamboman/mason-lspconfig.nvim",
  },

  -- funcao eh executada apos o lazy.vim carregar os plugins 
  config = function()
    -- inicializa o mason
    require("mason").setup()

    -- inicializa o mason-lspconfig
    require("mason-lspconfig").setup({
      -- ensure_installed = { "pyright", "clangd", "lua_ls" },
      ensure_installed = { "clangd", "lua_ls" },
    })

    -- prepara os futuros plugins de autocompletar 
    -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- definicao dos atalhos
    -- bufnr eh o numero do buffer ao qual o LSP se conectou
    local on_attach = function(client, bufnr)
      local function bufmap(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end
      
      -- atalhos
      bufmap("gd", vim.lsp.buf.definition, "Go to definition")
      bufmap("gD", vim.lsp.buf.declaration, "Go to declaration")
      bufmap("gi", vim.lsp.buf.implementation, "Go to implementation")
      bufmap("gr", vim.lsp.buf.references, "Go to references")

      -- informacao e documentacao
      bufmap("K", vim.lsp.buf.hover, "Show docs (Hover)")
      bufmap("sh", vim.lsp.buf.signature_help, "Show signature help")

      -- acoes e refatoracao
      bufmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
      bufmap("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    end

    -- loop configuracao automatica
    local servers = require("mason-lspconfig").get_installed_servers()

    for _, server_name in ipairs(servers) do
      require("lspconfig")[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
  end,
}
