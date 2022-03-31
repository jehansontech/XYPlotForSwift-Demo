//
//  View+Extensions.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 3/31/22.
//

import SwiftUI

// ============================================================================
// MARK: snapshot
// ============================================================================

enum SnapshotError: Error {
    case snapshotFailed(_ reason: String)
}

#if os(iOS) // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

extension View {

    public func takeSnapshot() throws -> UIImage {

        // Adapted from
        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image

        // FIXME: targetSize is currently hard-coded
        // * If I use controller.view.intrinsicContentSize, the layout is screwed up. E.g., in XYPlotView,
        //   the actual plot is squeezed to nearly nothing.
        // * If I use controller.view.bounds.size instead, no picture gets saved (and no error thrown).

        let controller = UIHostingController(rootView: self)
        // let targetSize = controller.view.bounds.size
        // let targetSize = controller.view.intrinsicContentSize
        let targetSize = CGSize(width: 800, height: 600)
        if let view = controller.view {
            view.bounds = CGRect(origin: .zero, size: targetSize)
            // view.backgroundColor = .clear
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            return renderer.image { _ in
                view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
            }
        }
        else {
            throw SnapshotError.snapshotFailed("No view")
        }
    }
}

#elseif os(macOS) // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

extension View {

    public func takeSnapshot() throws -> NSImage {

        // Adapted from
        // https://developer.apple.com/forums/thread/88315

        // FIXME: broken
        // * If I use view.bounds then rep is nil
        // * If I use view.visibleRect as the developer docco suggests, I get error
        //   message "Inconsistent set of values to create NSBitmapImageRep"

        let controller = NSHostingController(rootView: self)
        let view = controller.view
        let rect = view.bounds
        if let rep = view.bitmapImageRepForCachingDisplay(in: controller.view.visibleRect) {
            view.cacheDisplay(in: rect, to: rep)
            let image: NSImage = NSImage()
            image.addRepresentation(rep)
            return image
        }
        else {
            throw SnapshotError.snapshotFailed("No bitmap image")
        }
    }
}

#endif // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
