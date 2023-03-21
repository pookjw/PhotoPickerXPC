//
//  EXHostView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/20/23.
//

import SwiftUI
import ExtensionKit

struct EXHostView<Placeholder: View>: NSViewRepresentable {
    private let configuration: EXHostViewController.Configuration
    private let placeholder: () -> Placeholder
    
    init(
        configuration: EXHostViewController.Configuration,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.configuration = configuration
        self.placeholder = placeholder
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
        private var placeholderController: NSViewController?
        
        fileprivate override init() {
            super.init()
            exHostViewController.delegate = self
        }
        
        fileprivate func configurationDidChange(_ configuration: EXHostViewController.Configuration) {
            exHostViewController.configuration = configuration
        }
        
        fileprivate func placeholderDidChange<Placeholder: View>(@ViewBuilder _ placeholder: () -> Placeholder) {
            placeholderController?.removeFromParent()
            placeholderController = nil
            
            let placeholder: Placeholder = placeholder()
            let placeholderController: NSHostingController<Placeholder> = .init(rootView: placeholder)
            exHostViewController.addChild(placeholderController)
            exHostViewController.placeholderView = placeholderController.view
            
            self.placeholderController = placeholderController
        }
        
        func hostViewControllerDidActivate(_ viewController: EXHostViewController) {
            
        }
        
        func hostViewControllerWillDeactivate(_ viewController: EXHostViewController, error: Error?) {
            if let error: Error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
