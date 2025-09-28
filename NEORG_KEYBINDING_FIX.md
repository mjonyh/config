# Neorg Keybinding Conflict Resolution

## Problem
The Neorg plugin was using default keybindings that potentially conflicted with existing custom keybindings, causing issues in Neovim.

## Solution
Updated the Neorg configuration to prevent keybinding conflicts by:

### 1. Disabled Default Keybindings
- Set `default_keybinds = false` in the Neorg keybinds configuration
- This prevents Neorg from automatically mapping potentially conflicting keys

### 2. Custom Neorg Keybinding Prefix
- All Neorg-specific keybindings now use `<leader>n` prefix
- This ensures no conflicts with existing mappings that use other prefixes

### 3. Neorg-Specific Keybindings
All keybindings are only active when editing `.norg` files:

**Workspace Management:**
- `<leader>nw` - Open notes workspace
- `<leader>nr` - Return from Neorg
- `<leader>nc` - Toggle concealer

**Task Management:**
- `<leader>nt` - Cycle task status
- `<leader>nd` - Mark task done
- `<leader>nu` - Mark task undone
- `<leader>np` - Mark task pending
- `<leader>nh` - Mark task on hold
- `<leader>nx` - Cancel task
- `<leader>ni` - Mark task important

**Link Management:**
- `<leader>nl` - Follow link
- `<leader>nL` - Follow link (vertical split)

**List Management:**
- `<leader>nlt` - Promote list item
- `<leader>nld` - Demote list item

**Insert Mode Navigation:**
- `<C-l>` - Promote (only in .norg files)
- `<C-h>` - Demote (only in .norg files)

### 4. Enhanced Configuration
- Added concealer with basic icon preset
- Added completion engine integration with nvim-cmp
- Set default workspace to "notes"

### 5. Which-Key Integration
- Added descriptions for all Neorg keybindings in which-key
- Organized under `<leader>n` group for easy discovery

## Files Modified
- `nvim/lua/plugins/neorg.lua` - Updated with conflict-free configuration
- `nvim/lua/plugins/which-key.lua` - Added Neorg keybinding descriptions
- `nvim/lua/config/maps.lua` - Added documentation about Neorg prefix

## Benefits
1. **No Conflicts** - Neorg keybindings are isolated with `<leader>n` prefix
2. **Context-Aware** - Neorg mappings only active in `.norg` files
3. **Discoverable** - All keybindings documented in which-key
4. **Consistent** - Follows existing keybinding patterns in the configuration
5. **Enhanced Features** - Better concealer and completion integration

## Usage
1. Open Neorg files with `.norg` extension
2. Use `<leader>nw` to access your notes workspace
3. Use `<leader>?` to see all available keybindings via which-key
4. All task and formatting operations now use the `<leader>n` prefix

This solution ensures Neorg works seamlessly without interfering with your existing Neovim workflow.