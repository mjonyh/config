# Keybindings for Tmux

Your prefix is `Ctrl-a`.

## 1. Vim Tmux Navigator (`christoomey/vim-tmux-navigator`)

This plugin creates seamless navigation between Vim splits and tmux panes.

*   `Ctrl + h` → Move to the pane on the left.
*   `Ctrl + j` → Move to the pane below.
*   `Ctrl + k` → Move to the pane above.
*   `Ctrl + l` → Move to the pane on the right.

*(Note: These do not use the tmux prefix. You press the Ctrl key and the navigation key directly.)*

## 2. Tmux Yank (`tmux-plugins/tmux-yank`)

This enhances yanking text from tmux to your system clipboard. These keys work when you are in tmux's **copy-mode** (`Prefix` + `[`).

*   `y` → Copies the selected text to the system clipboard.
*   `Y` (Shift + y) → Copies the entire current line to the system clipboard.

## 3. Tmux Resurrect (`tmux-plugins/tmux-resurrect`)

This plugin saves and restores your tmux sessions.

*   `Prefix` + `Ctrl-s` → **S**aves your current tmux environment (sessions, windows, panes).
*   `Prefix` + `Ctrl-r` → **R**estores the last saved environment.

## 4. Tmux Continuum (`tmux-plugins/tmux-continuum`)

*   **No keybindings.** This is an automatic plugin. It will save your session every 15 minutes in the background and automatically restore it when you start tmux. You enabled this with the `@continuum-restore 'on'` setting.

## 5. Tmux FZF (`sainnhe/tmux-fzf`)

This provides a fuzzy finder for navigating your sessions and windows.

*   `Prefix` + `F` (Shift + f) → Opens the main **F**ZF popup, allowing you to fuzzy search and switch between sessions, windows, panes, keybindings, and more.
