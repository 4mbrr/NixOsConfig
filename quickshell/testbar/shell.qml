import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io

Scope {
    id: root
    property string time

        Variants {
            model: Quickshell.screens;

            delegate: Component {
                PanelWindow {
                    property var modelData
                    screen: modelData
                  anchors {
                    top: true
                    left: true
                    right: true
                  }

                  implicitHeight: 30

                  Text {
                    anchors.centerIn: parent

                    text: root.time
                  }
                }
            }
        }

        Process {
            id: dateProc

            command: ["date"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: root.time = this.text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
}
