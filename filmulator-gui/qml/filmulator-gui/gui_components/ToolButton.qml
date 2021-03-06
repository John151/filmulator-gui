import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../colors.js" as Colors
import "."

Item {
    id: root
    property real uiScale: 1
    property alias text: button.text
    property bool notDisabled: true
    property alias tooltipText: tooltip.tooltipText
    property real __padding: 2 * uiScale
    property bool pressed: notDisabled ? button.pressed : false

    signal triggered()

    signal tooltipWanted(string text, int x, int y)
    width: 30 * uiScale
    height: 30 * uiScale
    Button {
        id: button
        width: parent.width - __padding * 2
        height: parent.height - __padding * 2
        x: __padding
        y: __padding
        style: ToolButtonStyle {
            uiScale: root.uiScale
            notDisabled: root.notDisabled
        }
        action: Action {
            onTriggered: {
                if (root.notDisabled){
                    root.triggered()
                }
            }
        }
    }
    ToolTip {
        id: tooltip
        anchors.fill: button
        Component.onCompleted: {
            //Forward the tooltipWanted signal to root.
            tooltip.tooltipWanted.connect(root.tooltipWanted)
        }
    }
}

