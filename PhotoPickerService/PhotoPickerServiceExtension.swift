//
//  PhotoPickerServiceExtension.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/22/23.
//

import ExtensionFoundation

protocol PhotoPickerServiceExtension : AppExtension {
    func transform(_ input: String) async -> String
}
