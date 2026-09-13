import QtQuick
import qs.Commons
import qs.Ui as Ui

// Use the shell's state palette and complete border specs, including gradients
// and per-side widths. A theme's zero width/alpha is intentional.
Ui.BorderSurface {
    id: root
    property bool focused: false
    property bool hovered: false
    property bool selected: false
    property bool pressed: false
    readonly property string controlState: focused ? "focus"
        : hovered ? "hover-cursor" : selected ? "selected" : "normal"
    readonly property color stateColor: focused ? Style.focusStateColor(Color.menu.text, Color.accent)
        : hovered ? Style.hoverStateColor(Color.menu.text, Color.accent)
        : selected ? Style.selectedStateColor(Color.menu.text, Color.accent)
        : Style.normalStateColor(Color.menu.text, Color.accent)
    radius: Style.cornerRadius
    borderSpec: Border.controlSpec(controlState, Color.menu.text, Color.accent)
    color: pressed ? Style.pressedFillFor(Color.menu.text, Color.accent)
        : focused ? Style.focusFillFor(Color.menu.text, Color.accent)
        : hovered ? Style.hoverFillFor(Color.menu.text, Color.accent)
        : selected ? Style.selectedFillFor(Color.menu.text, Color.accent)
        : Style.normalFillFor(Color.menu.text, Color.accent)
}
