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
                ScrollView { 
                    LazyVGrid(
                        columns: [
                            .init(
                                .adaptive(minimum: 150.0),
                                spacing: .zero,
                                alignment: .leading
                            )
                        ],
                        alignment: .leading,
                        spacing: .zero
                    ) { 
                        ForEach(0..<3_000) { index in
                            Color(
                                red: .random(in: .zero...1.0),
                                green: .random(in: .zero...1.0), 
                                blue: .random(in: .zero...1.0)
                            )
                            .aspectRatio(1.0, contentMode: .fit)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
