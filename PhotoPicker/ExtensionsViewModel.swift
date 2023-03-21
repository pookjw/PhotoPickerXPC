//
//  ExtensionsViewModel.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import ExtensionFoundation

actor ExtensionsViewModel: ObservableObject {
    @MainActor @Published private(set) var availability: AppExtensionIdentity.Availability = .init()
    @MainActor @Published private(set) var identities: [AppExtensionIdentity] = .init()
    private var availabilityUpdatesTask: Task<Void, Never>?
    private var identitiesTask: Task<Void, Never>?
    
    init() {
        
    }
    
    deinit {
        availabilityUpdatesTask?.cancel()
    }
    
    func start() throws {
        availabilityUpdatesTask = .init {
            for await availability in AppExtensionIdentity.availabilityUpdates {
                await MainActor.run {
                    self.availability = availability
                }
            }
        }
        
        let identitiesSteam: AppExtensionIdentity.Identities = try AppExtensionIdentity.matching(appExtensionPointIDs: "com.pookjw.PhotoPicker.Extension")
        
        identitiesTask = .init {
            for await identities in identitiesSteam {
                await MainActor.run {
                    self.identities = identities
                }
            }
        }
    }
    
    @MainActor func identity(from id: AppExtensionIdentity.ID) -> AppExtensionIdentity? {
        identities.first { $0.id == id }
    }
}
