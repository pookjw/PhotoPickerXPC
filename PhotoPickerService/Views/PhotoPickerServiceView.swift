//
//  PhotoPickerServiceView.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/22/23.
//

import SwiftUI
import Photos

struct PhotoPickerServiceView<E: PhotoPickerServiceExtension>: NSViewRepresentable {
    private let configuration: PhotoPickerServiceConfiguration<E>
    
    init(configuration: PhotoPickerServiceConfiguration<E>) {
        self.configuration = configuration
    }
    
    func makeNSView(context: Context) -> NSView {
        context.coordinator.viewController.view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        context.coordinator.configuration = configuration
    }
    
    func makeCoordinator() -> Coordinator<E> {
        .init(configuration: configuration)
    }
    
    @MainActor
    final class Coordinator<E: PhotoPickerServiceExtension> {
        var configuration: PhotoPickerServiceConfiguration<E>
        private var task: Task<Void, Never>?
        
        let viewController: PhotoPickerViewController = .init()
        
        init(configuration: PhotoPickerServiceConfiguration<E>) {
            self.configuration = configuration
            
            let notifications: NotificationCenter.Notifications = NotificationCenter.default.notifications(named: .photoPickerViewControllerDidSelectAssets, object: viewController)
            
            task = .detached { [weak self] in
                for await notification in notifications {
                    guard 
                        let configuration: PhotoPickerServiceConfiguration<E> = await MainActor.run(body: { [weak self] in
                            self?.configuration
                        }),
                        let assets: [PHAsset] = notification.userInfo?[PhotoPickerViewControllerSelectedAssetsKey] as? [PHAsset]
                    else {
                        continue
                    }
                    
                    let identifiers: [String] = assets
                        .map { $0.localIdentifier }
                    try! await configuration.sendSelectedLocalIdentifiers(identifiers)
                }
            }
        }
        
        deinit {
            task?.cancel()
        }
    }
}
