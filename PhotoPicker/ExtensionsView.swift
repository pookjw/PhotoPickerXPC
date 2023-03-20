//
//  ExtensionsView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import ExtensionFoundation

struct ExtensionsView: View {
    @Binding private(set) var selectedAppExtensionIdentity: AppExtensionIdentity?
    @StateObject private var viewModel: ExtensionsViewModel = .init()
    @State private var isVisible: Bool = false
    @State private var selection: AppExtensionIdentity.ID?
    @State private var sortOrders: [KeyPathComparator] = [KeyPathComparator(\AppExtensionIdentity.localizedName)]
    
    var body: some View {
        VStack { 
            Text(String(describing: viewModel.availability))
                .multilineTextAlignment(.center)
                .padding()
            
            Table(
                viewModel.identities,
                selection: $selection,
                sortOrder: $sortOrders
            ) { 
                TableColumn("Name", value: \.localizedName)
                TableColumn("Bundle Identifier", value: \.bundleIdentifier)
                TableColumn("Extension Point Identifier", value: \.extensionPointIdentifier)
            }
            .onChange(of: selection) { newValue in
                guard let id: AppExtensionIdentity.ID = newValue else {
                    selectedAppExtensionIdentity = nil
                    return
                }
                
                selectedAppExtensionIdentity = viewModel.identity(from: id)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation) { 
                Button("Manager") { 
                    isVisible.toggle()
                }
            }
        }
        .background { 
            PopoverView(isVisible: $isVisible) { 
                EXAppExtensionBrowserView()
            }
        }
        .task {
            try! await viewModel.start()
        }
    }
}

struct ExtensionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionsView(selectedAppExtensionIdentity: .constant(nil))
    }
}
