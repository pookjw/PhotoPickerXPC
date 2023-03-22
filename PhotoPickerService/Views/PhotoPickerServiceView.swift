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
//        ScrollView { 
//            SquaresLayout(maxItemLength: .constant(200)) {
//                ForEach(0..<30) { number in
//                    Color(
//                        red: Double.random(in: 0...1),
//                        green: Double.random(in: 0...1),
//                        blue: Double.random(in: 0...1)
//                    )
//                }
//            }
//        }
        List(0..<100) { number in
            Color(
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )
        }
    }
}
