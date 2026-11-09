import AppKit
import Testing
@testable import NotchNotes

@MainActor
struct NotchPanelActivationTests {
    @Test
    func panelIsPassiveByDefault() {
        let panel = makePanel()

        #expect(!panel.canBecomeKey)
        #expect(!panel.canBecomeMain)
    }

    @Test
    func panelBecomesFocusableOnlyAfterExplicitActivation() {
        let panel = makePanel()

        panel.allowsKeyActivation = true
        #expect(panel.canBecomeKey)
        #expect(!panel.canBecomeMain)

        panel.allowsKeyActivation = false
        #expect(!panel.canBecomeKey)
        #expect(!panel.canBecomeMain)
    }

    @Test
    func panelCanJoinOtherAppsWithoutActivatingItsOwnSpace() {
        let panel = makePanel()
        #expect(panel.styleMask.contains(.nonactivatingPanel))
        #expect(panel.collectionBehavior.contains(.canJoinAllSpaces))
        #expect(panel.collectionBehavior.contains(.canJoinAllApplications))
        #expect(panel.collectionBehavior.contains(.fullScreenAuxiliary))
        #expect(!panel.collectionBehavior.contains(.moveToActiveSpace))
    }

    private func makePanel() -> NotchPanel {
        NotchPanel()
    }
}
