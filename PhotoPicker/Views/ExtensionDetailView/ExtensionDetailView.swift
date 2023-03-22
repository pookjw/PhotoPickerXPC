//
//  ExtensionDetailView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/21/23.
//

import SwiftUI
import ExtensionFoundation
import PhotoPickerCommon

struct ExtensionDetailView: View {
    @ObservedObject private var viewModel: ExtensionDetailViewModel
    @State private var title: String = "Ping"
    
    init(appExtensionIdentity: AppExtensionIdentity) {
        self.viewModel = try! .init(appExtensionIdentity: appExtensionIdentity)
    }
    
    var body: some View {
        EXHostView(
            configuration: .init(
                appExtension: viewModel.appExtensionIdentity,
                sceneID: sceneID
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
