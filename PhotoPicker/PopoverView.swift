//
//  PopoverView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI

// https://stackoverflow.com/a/68692478/17473716

struct PopoverView<T: View>: NSViewRepresentable {
    @Binding private var isVisible: Bool
    private let content: () -> T
    
    init(isVisible: Binding<Bool>, @ViewBuilder content: @escaping () -> T) {
        self._isVisible = isVisible
        self.content = content
    }
    
    func makeNSView(context: Context) -> NSView {
        .init()
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        context.coordinator.visibilityDidChange(isVisible, in: nsView)
        context.coordinator.contentDidChange(content)
    }
    
    func makeCoordinator() -> Coordinator {
        .init(isVisible: $isVisible)
    }
    
    @MainActor
    final class Coordinator: NSObject, NSPopoverDelegate {
        private let popover: NSPopover = .init()
        private let isVisible: Binding<Bool>
        
        fileprivate init(isVisible: Binding<Bool>) {
            self.isVisible = isVisible
            super.init()
            
            popover.delegate = self
            popover.behavior = .semitransient
        }
        
        fileprivate func visibilityDidChange(_ isVisible: Bool, in view: NSView) {
            if isVisible {
                if !popover.isShown {
                    popover.show(relativeTo: view.bounds, of: view, preferredEdge: .maxX)
                }
            } else {
                if popover.isShown {
                    popover.close()
                }
            }
        }
        
        fileprivate func contentDidChange<T: View>(@ViewBuilder _ content: () -> T) {
            popover.contentViewController = NSHostingController(rootView: content())
        }
        
        func popoverDidClose(_ notification: Notification) {
            isVisible.wrappedValue = false
        }
    }
}
