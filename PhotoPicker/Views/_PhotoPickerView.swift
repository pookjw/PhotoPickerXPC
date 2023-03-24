//
//  _PhotoPickerView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/24/23.
//

import SwiftUI

struct _PhotoPickerView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        context.coordinator.viewController.view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    @MainActor
    final class Coordinator {
        let viewController: PhotoPickerViewController = .init()
        private var task: Task<Void, Never>?
        
        init() {
            let notifications: NotificationCenter.Notifications = NotificationCenter.default.notifications(named: .photoPickerViewControllerDidSelectAssets, object: viewController)
            
            task = .detached {
                for await notification in notifications {
                    print(notification)
                }
            }
        }
        
        deinit {
            task?.cancel()
        }
    }
}
