Run `./tests/check-theme-runtime` to exercise the installed Omarchy theme APIs
with Exposé's actual settings view, window card, and shared control components.
Pass an output directory to save two rendered PNGs. The test uses an offscreen
Quickshell process with a mock application controller; theme changes affect that
process only. Live window capture is unavailable offscreen, so Quickshell reports
expected Wayland/buffer-backend warnings.

Coverage includes state-specific zero borders, asymmetric widths, side overrides,
gradients, alpha, control fill, radius, typography, spacing, and live theme changes.
After switching to the borderless theme it checks every instantiated border
surface, including inactive settings categories.

The theme audit used Omarchy source at `31bd80daa4613ffdee995ac27467fce5a2990806`:

- [Border.qml](https://github.com/omacom/omarchy/blob/31bd80daa4613ffdee995ac27467fce5a2990806/shell/Commons/Border.qml)
  owns control and surface colors, alpha, gradients, and per-side width resolution.
- [BorderSurface.qml](https://github.com/omacom/omarchy/blob/31bd80daa4613ffdee995ac27467fce5a2990806/shell/Ui/BorderSurface.qml)
  selects the native border or Shape renderer without flattening the theme spec.
- [Style.qml](https://github.com/omacom/omarchy/blob/31bd80daa4613ffdee995ac27467fce5a2990806/shell/Commons/Style.qml)
  defines control states, fills, typography, spacing, and corner geometry.
- [Color.qml](https://github.com/omacom/omarchy/blob/31bd80daa4613ffdee995ac27467fce5a2990806/shell/Commons/Color.qml)
  layers user theme overrides and provides menu background/text/scrim roles.

Window-card mouse and keyboard cursors use hover-cursor state; the active window
uses selected state. Settings controls use focus, hover, selected, and normal
states. Dialog/search surfaces use menu border specs. No state forces a border
when its theme width or alpha is zero. Slider tracks and handles remain value
geometry rather than borrowing border widths for their dimensions.

The audit preserves Exposé's blur/dim behavior and animation controls. Other
remaining numeric opacity values express secondary text, disabled controls, or
Quick Look transitions; there are no corresponding shell theme tokens. The black
preview mask is an invisible alpha mask, not a surface color. Inner corner radii
subtract padding and stop at zero, so a square theme stays square.
