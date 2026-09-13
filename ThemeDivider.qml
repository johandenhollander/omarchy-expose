import QtQuick
import qs.Commons
import qs.Ui as Ui

Ui.BorderSurface {
    property bool vertical: false
    color: "transparent"
    borderSpec: Border.controlSpec("normal", Color.menu.text, Color.accent)
    implicitWidth: vertical ? Math.max(borderLeft, borderRight) : 0
    implicitHeight: vertical ? 0 : Math.max(borderTop, borderBottom)
}
