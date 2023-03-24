//
//  ContentView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import ExtensionFoundation

struct ContentView: View {
    @State private var selectedAppExtensionIdentity: AppExtensionIdentity?
    
    var body: some View {
        NavigationSplitView {
            ExtensionsView(selectedAppExtensionIdentity: $selectedAppExtensionIdentity)
        } detail: {
            if let selectedAppExtensionIdentity: AppExtensionIdentity {
                ExtensionDetailView(appExtensionIdentity: selectedAppExtensionIdentity)
            } else {
                _PhotoPickerView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
