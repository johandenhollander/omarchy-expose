import QtQuick
import QtTest

Item {
    id: root
    width: 200
    height: 200
    property int hotCornerReach: 48
    property int hotCornerDepth: 6
    property int effectiveHotCornerDelay: 500

// HOT CORNER COMPONENT

    HotCornerTarget { id: corner; onTop: true; onLeft: true }
    SignalSpy { id: entered; target: corner; signalName: "entered" }
    SignalSpy { id: exited; target: corner; signalName: "exited" }

    TestCase {
        name: "HotCornerDwell"
        when: windowShown

        function init() {
            mouseMove(root, 100, 100);
            root.effectiveHotCornerDelay = 500;
            entered.clear();
            exited.clear();
        }

        function test_zeroDelayIsSynchronous() {
            root.effectiveHotCornerDelay = 0;
            mouseMove(root, 20, 2);
            compare(entered.count, 1);
        }

        function test_dwellFiresOnce() {
            mouseMove(root, 20, 2);
            wait(200);
            compare(entered.count, 0);
            tryCompare(entered, "count", 1, 600);
            wait(600);
            compare(entered.count, 1);
        }

        function test_leavingCancelsDwell() {
            mouseMove(root, 20, 2);
            wait(200);
            mouseMove(root, 100, 100);
            compare(exited.count, 1);
            wait(600);
            compare(entered.count, 0);
        }

        function test_crossingStrips_data() {
            return [
                { tag: "horizontal to vertical", startX: 20, startY: 2, endX: 2, endY: 20 },
                { tag: "vertical to horizontal", startX: 2, startY: 20, endX: 20, endY: 2 }
            ];
        }

        function test_crossingStrips(data) {
            mouseMove(root, data.startX, data.startY);
            wait(200);
            mouseMove(root, 2, 2);
            wait(200);
            mouseMove(root, data.endX, data.endY);
            compare(exited.count, 0);
            // The original 500 ms dwell must fire before a restarted one could.
            tryCompare(entered, "count", 1, 250);
        }
    }
}
