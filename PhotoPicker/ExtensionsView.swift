//
//  ExtensionsView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/18/23.
//

import SwiftUI
import ExtensionFoundation

struct ExtensionsView: View {
    @ObservedObject private var viewModel: ExtensionsViewModel = .init()
    @State private var isVisible: Bool = false
    @State private var sortOrders: [KeyPathComparator] = [KeyPathComparator(\AppExtensionIdentity.localizedName)]
    
    var body: some View {
        VStack { 
            Text(String(describing: viewModel.availability))
                .multilineTextAlignment(.center)
            
            Table(
                viewModel.identities,
                sortOrder: $sortOrders
            ) { 
                TableColumn("Name", value: \.localizedName)
                TableColumn("Bundle Identifier", value: \.bundleIdentifier)
                TableColumn("Extension Point Identifier", value: \.extensionPointIdentifier)
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
                AppExtensionBrowser()
            }
        }
        .task {
            try! await viewModel.start()
        }
    }
}

struct ExtensionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionsView()
    }
}
