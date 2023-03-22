//
//  PhotoPickerService.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import ExtensionKit
import PhotoPickerCommon

@main
struct PhotoPickerService: PhotoPickerServiceExtension {
    var configuration: AppExtensionSceneConfiguration {
        let configuration: PhotoPickerServiceConfiguration<Self> = .init(self)
        
        return .init(
            PrimitiveAppExtensionScene(
                id: sceneID, 
                content: { 
                    PhotoPickerServiceView(configuration: configuration)
                },
                onConnection: { connection in
                    connection.activate()
                    return true
                }
            ), 
            configuration: configuration
        )
    }
    
    func transform(_ input: String) async -> String {
        "Pong"
    }
    
    init() { }
}
