return {
  "MeanderingProgrammer/dashboard.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "MaximilianLloyd/ascii.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
  },
  config = function()
    require("dashboard").setup {
      header = require("ascii").get_random("misc", "skulls"),
      date_format = "%Y-%m-%d %H:%M:%S",
      directories = {
        "~/.config/nvim/",
        "~/dev/education/",
        "~/dev/personal/",
        "~/dev/work/",
        "~/dev/hh/",
      },
    }
  end,
}
