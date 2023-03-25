//
//  ContentView.swift
//  PhotoPickerProvider
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import Photos

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status != .authorized {
                    fatalError("\(status)")
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
