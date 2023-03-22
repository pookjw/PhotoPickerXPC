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
                Color.purple
//                ScrollView { 
//                    SquaresLayout(maxItemLength: .constant(200)) {
//                        ForEach(0..<1_000) { number in
//                            Color(
//                                red: Double.random(in: 0...1),
//                                green: Double.random(in: 0...1),
//                                blue: Double.random(in: 0...1)
//                            )
//                        }
//                    }
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
