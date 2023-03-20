//
//  EXHostView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/20/23.
//

import SwiftUI
import ExtensionKit

struct EXHostView: NSViewRepresentable {
    private let configuration: EXHostViewController.Configuration
    
    init(configuration: EXHostViewController.Configuration) {
        self.configuration = configuration
    }
    
    func makeNSView(context: Context) -> NSView {
        context.coordinator.exHostViewController.view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        context.coordinator.configurationDidChange(configuration)
    }
    
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    final class Coordinator: NSObject, EXHostViewControllerDelegate {
        fileprivate let exHostViewController: EXHostViewController = .init()
        
        override init() {
            super.init()
            exHostViewController.delegate = self
        }
        
        fileprivate func configurationDidChange(_ configuration: EXHostViewController.Configuration) {
            exHostViewController.configuration = configuration
        }
    }
}
