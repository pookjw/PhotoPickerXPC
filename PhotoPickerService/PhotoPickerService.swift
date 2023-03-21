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
struct PhotoPickerService: PhotoPickerXPCExtension {
    var configuration: AppExtensionSceneConfiguration {
        let configuration: PhotoPickerServiceConfiguration<Self> = .init(self)
        
        return .init(
            PrimitiveAppExtensionScene(
                id: sceneID, 
                content: { 
                    Button("Send") { 
                        Task {
                            try! await configuration.sendSelectedLocalIdentifiers(["Test"])
                        }
                    }
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
        "\(input) \(input)"
    }
    
    init() { }
}
