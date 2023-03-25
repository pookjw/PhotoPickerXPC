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
        private var didSelectTask: Task<Void, Never>?
        private var errorTask: Task<Void, Never>?
        
        let viewController: PhotoPickerViewController = .init()
        
        init(configuration: PhotoPickerServiceConfiguration<E>) {
            self.configuration = configuration
            bind()
        }
        
        deinit {
            didSelectTask?.cancel()
        }
        
        private func bind() {
            let didSelectNotifications: NotificationCenter.Notifications = NotificationCenter.default.notifications(named: .photoPickerViewControllerDidSelectAssets, object: viewController)
            
            didSelectTask = .detached { [weak self] in
                for await notification in didSelectNotifications {
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
            
            let errorNotifications: NotificationCenter.Notifications = NotificationCenter.default.notifications(named: .photoPickerViewControllerErrorOccured, object: viewController)
            
            errorTask = .detached { [weak self] in
                for await notification in errorNotifications {
                    guard 
                        let configuration: PhotoPickerServiceConfiguration<E> = await MainActor.run(body: { [weak self] in
                            self?.configuration
                        }),
                        let error: Error = notification.userInfo?[PhotoPickerViewControllerErrorOccuredKey] as? Error
                    else {
                        continue
                    }
                    
                    try! await configuration.errorOccured(error: error)
                }
            }
        }
    }
}
