-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}


function open_bb_customer_url()
  local filepath = vim.fn.expand("%:p")
  local lines = vim.fn.readfile(filepath)
  local vcs_repo, vcs_project

  for _, line in ipairs(lines) do
    local repo = line:match("^%s*vcs_repo:%s*(%S+)")
    local project = line:match("^%s*vcs_project:%s*(%S+)")
    if repo then vcs_repo = repo end
    if project then vcs_project = project end
  end

  if vcs_repo and vcs_project then
    local stash = vim.fn.system({ "security", "find-generic-password", "-a", os.getenv("USER"), "-s", "STASH_URL", "-w" }):gsub("%s+$", "")
    local url = string.format("https://%s/projects/%s/repos/%s", stash, string.gsub(vcs_project, '"(%d+)"', "%1"), string.gsub(vcs_repo, '"(%d+)"', "%1"))
    vim.fn.jobstart({ "open", url }, { detach = true })
    vim.notify("Opening: " .. url, vim.log.levels.INFO)
    vim.notify("Opening stash: " .. stash, vim.log.levels.INFO)
  else
    vim.notify("Missing 'vcs_repo' or 'vcs_project' in the YAML file.", vim.log.levels.ERROR)
  end
end

function open_gcp_project_url()
  local filepath = vim.fn.expand("%:p")
  local project = filepath:match("^.+/(.+)%.yaml$")
  local url = string.format("https://console.cloud.google.com/welcome?inv=1&invt=AbqGpQ&project=%s&authuser=3", project)

  vim.fn.jobstart({ "open", url }, { detach = true })
  vim.notify("Opening: " .. url, vim.log.levels.INFO)
end

function open_tfe_workspace_url()
  local filepath = vim.fn.expand("%:p")
  local project = filepath:match("^.+/(.+)%.yaml$")
  local terraform = vim.fn.system({ "security", "find-generic-password", "-a", os.getenv("USER"), "-s", "TERRAFORM_URL", "-w" }):gsub("%s+$", "")
  local url = string.format("https://%s/app/gcp-eg/workspaces/solution-%s", terraform, project)

  vim.fn.jobstart({ "open", url }, { detach = true })
  vim.notify("Opening: " .. url, vim.log.levels.INFO)
end
-- 🚀 Optional: Keybinding

-- vim.cmd("colorscheme catppuccin")
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Left>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<Leader>/", "<cmd>Telescope live_grep<CR>", { desc = "live_grep" })

vim.keymap.set("n", "<leader>ge",open_bb_customer_url, { desc = "Open Repo URL" })
vim.keymap.set("n", "<leader>ga",open_gcp_project_url, { desc = "Open GCP project URL" })
vim.keymap.set("n", "<leader>gw",open_tfe_workspace_url, { desc = "Open TFE workspace URL" })

vim.g.VM_maps = {
  ["Find Under"]         = "<C-n>",     -- Default multi-cursor selection
  ["Find Subword Under"] = "<C-n>",     -- Select subwords too
  ["Select All"]         = "<C-S-n>",   -- Select all occurrences
  ["Cursor Down"]        = "<M-Down>",  -- Move selection down
  ["Cursor Up"]          = "<M-Up>",    -- Move selection up
}

-- print("✅ polish.lua loaded successfully")

