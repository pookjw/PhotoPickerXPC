//
//  ExtensionDetailView.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/20/23.
//

import SwiftUI
import ExtensionKit

struct ExtensionDetailView: View {
    private let appExtensionIdentity: AppExtensionIdentity
    
    init(appExtensionIdentity: AppExtensionIdentity) {
        self.appExtensionIdentity = appExtensionIdentity
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
