//
//  PhotoPickerServiceView.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/22/23.
//

import SwiftUI

struct PhotoPickerServiceView<E: PhotoPickerServiceExtension>: View {
    private let configuration: PhotoPickerServiceConfiguration<E>
    
    init(configuration: PhotoPickerServiceConfiguration<E>) {
        self.configuration = configuration
    }
    
    var body: some View {
        LazyLayoutScrollView(data: 0..<1_000) {
            SquaresLayout(maxItemLength: .constant(150))
        } content: { index, isVisible in
            if isVisible {
                StateColor()
            } else {
                Color.clear
            }
        }
    }
}
