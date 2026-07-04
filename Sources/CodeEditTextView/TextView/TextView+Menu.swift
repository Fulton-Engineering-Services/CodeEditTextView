//
//  TextView+Menu.swift
//  CodeEditTextView
//
//  Created by Khan Winter on 8/21/23.
//

import AppKit

extension TextView {
    override public func menu(for event: NSEvent) -> NSMenu? {
        guard event.type == .rightMouseDown else { return nil }

        let menu = NSMenu()

        menu.items = [
            NSMenuItem(title: "Cut", action: #selector(cut(_:)), keyEquivalent: "x"),
            NSMenuItem(title: "Copy", action: #selector(copy(_:)), keyEquivalent: "c"),
            NSMenuItem(title: "Paste", action: #selector(paste(_:)), keyEquivalent: "v")
        ]

        // Append additional menu items from the provider if available
        if let provider = additionalMenuItemsProvider {
            let selectedRange = selectionManager?.textSelections.first?.range ?? NSRange(location: 0, length: 0)
            let additionalItems = provider(selectedRange)
            if !additionalItems.isEmpty {
                menu.addItem(NSMenuItem.separator())
                menu.items.append(contentsOf: additionalItems)
            }
        }

        return menu
    }
}
