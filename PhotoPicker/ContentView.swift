//
//  ContentView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isVisible: Bool = false
    
    var body: some View {
        NavigationSplitView { 
            ExtensionsView()
        } detail: { 
            Color.purple
        }

//        Button("Toggle") {
//            isVisible = true
//        }
//        .background { 
//            PopoverView(isVisible: $isVisible) {
//                AppExtensionBrowser()
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
