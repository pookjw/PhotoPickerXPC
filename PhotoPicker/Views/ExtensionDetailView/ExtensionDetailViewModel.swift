//
//  ExtensionDetailViewModel.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/21/23.
//

import SwiftUI
import ExtensionFoundation

actor ExtensionDetailViewModel: ObservableObject {
    let appExtensionIdentity: AppExtensionIdentity
    let xpcService: PhotoPickerXPCService
    
    init(appExtensionIdentity: AppExtensionIdentity) throws {
        self.appExtensionIdentity = appExtensionIdentity
        
        let configuration: AppExtensionProcess.Configuration = .init(
            appExtensionIdentity: appExtensionIdentity,
            onInterruption: {
                fatalError()
            }
        )
        
        let process: AppExtensionProcess = try .init(configuration: configuration)
        
        self.xpcService = try .init(process: process)
    }
}
