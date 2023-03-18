//
//  AppExtensionBrowser.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import ExtensionKit

struct AppExtensionBrowser: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        context.coordinator.appExtensionBrowserViewController.view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSView, context: Context) -> CGSize? {
        .init(width: 400.0, height: 300.0)
    }
    
    final class Coordinator {
        fileprivate let appExtensionBrowserViewController: EXAppExtensionBrowserViewController = .init()
    }
}
