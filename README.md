# smart-visual.yazi

This is a Yazi plugin that implements a visual mode switch similar to Vim.

<!--toc:start-->
- [smart-visual.yazi](#smart-visualyazi)
  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [License](#license)
<!--toc:end-->

## Features

- **select/unset**: Provides a Vim-like visual mode toggle.
- **escape**: Cancels the current selection and exits visual mode without clearing previously selected content.

## Installation

```sh
ya pack -a MaJinjie/smart-visual
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

``` toml
[manager]
prepend_keymap = [
  { on = "<Esc>", run = "plugin smart-visual escape", desc = "Exit visual mode, clear selected, or cancel search" },
  { on = "v", run = "plugin smart-visual select", desc = "Enter visual mode (selection mode)" },
  { on = "V", run = "plugin smart-visual unset", desc = "Enter visual mode (unset mode)" },
]
```

**Usage Example**:

First, press v to enter select mode.

Then:

- Press v to save the selection and exit the mode.
- Press V to save the selection (if persist_on_toggle is enabled) and enter unset mode.
- Press `<Esc>` to discard the current selection and return to normal mode.

## Configuration

To customize the behavior of the plugin, you can configure the persist_on_toggle option in the plugin setup. For example:

```lua
require("smart_visual").setup({
  --Optional. Retain selection when toggling between modes
  persist_on_toggle = true, 
})
```

## License

This plugin is MIT-licensed. For more information check the [LICENSE](https://github.com/MaJinjie/smart-visual.yazi/blob/main/LICENSE) file.
