# Kitten to print the current list of keyboard shortcuts
#
# Place this in ~/.config/kitty/keymap.py then
# Add "map kitty_mod+/ kitty keymap.py" to your kitty.conf
from kitty import fast_data_types

def main(args):
    return ''

def handle_result(args, answer, target_window_id, boss):
    opts = fast_data_types.get_options()
    keymap = opts.keymap

    output = ["Kitty keyboard mappings", "=" * 23, ""]

    for key, action in keymap.items():
        output.append(f'{key.human_repr} → {action}')
    boss.display_scrollback(boss.active_window, "\n".join(output),
            title="Kitty keyboard mappings", report_cursor=False)
