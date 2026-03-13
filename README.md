# [WezTerm](https://wezterm.org/) Configuration

## Structure

| File | Purpose |
|---|---|
| [wezterm.lua](wezterm.lua) | Loads plugins, wires up modules, sets appearance options |
| [keybindings.lua](keybindings.lua) | All keyboard shortcuts. Registers everything with cmdpicker. |
| [mousebindings.lua](mousebindings.lua) | Mouse bindings |
| [events.lua](events.lua) | WezTerm event handlers |
| [helpers.lua](helpers.lua) | Utility functions |
| [tabline.lua](tabline.lua) | Tabline plugin configuration |
| [session.lua](session.lua) | Workspace switcher + resurrect plugin setup |
| [ai_commander.lua](ai_commander.lua) | AI Commander plugin setup |
| [quota.lua](quota.lua) | Quota limit plugin setup |
| [constants.example.lua](constants.example.lua) | API keys and URLs. Copy `constants.example.lua` to `constants.lua`. |

## Plugins

Managed via `wezterm.plugin.require`.

| Plugin | Source |
|---|---|
| [cmdpicker](https://github.com/abidibo/wezterm-cmdpicker) | Command palette with searchable keybinding descriptions |
| [smart_ssh](https://github.com/DavidRR-F/smart_ssh.wezterm) | Fuzzy SSH host selector |
| [wez-tmux](https://github.com/sei40kr/wez-tmux) | Tmux-style keybindings |
| [tabline.wez](https://github.com/michaelbrusegard/tabline.wez) | Status bar |
| [smart_workspace_switcher](https://github.com/MLFlexer/smart_workspace_switcher.wezterm) | Fuzzy workspace switching |
| [resurrect](https://github.com/MLFlexer/resurrect.wezterm) | Save/restore workspace, window, and tab state |
| [presentation.wez](https://gitlab.com/xarvex/presentation.wez) | Presentation mode |

## Setup

1. Copy `constants.example.lua` to `constants.lua` and fill in API keys if using AI Commander.
2. [resurrect](https://github.com/MLFlexer/resurrect.wezterm) saved state encryption requires an [age](https://github.com/FiloSottile/age) key at `.age/key.txt`.
    - `mkdir .age && age-keygen -o .age/key.txt`

## Leader Key

`Ctrl-Space`. Most bindings are prefixed with the leader key. See [keybindings.lua](keybindings.lua) for the full list, or press `Leader` then `r` to open the command picker.
