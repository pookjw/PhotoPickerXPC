//
//  ExtensionDetailView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/21/23.
//

import SwiftUI
import ExtensionFoundation

struct ExtensionDetailView: View {
    @ObservedObject private var viewModel: ExtensionDetailViewModel
    @State private var title: String = "Title"
    
    init(appExtensionIdentity: AppExtensionIdentity) {
        self.viewModel = try! .init(appExtensionIdentity: appExtensionIdentity)
    }
    
    var body: some View {
        EXHostView(
            configuration: .init(
                appExtension: viewModel.appExtensionIdentity,
                sceneID: "scene"
            )
        ) { 
            Text("Pending...")
        }
        .navigationTitle(title)
        .task {
            title = try! await viewModel.xpcService.transform(title)
        }
    }
}
