//
//  PhotoPickerXPCExtension.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/22/23.
//

import ExtensionFoundation

protocol PhotoPickerXPCExtension : AppExtension {
    func transform(_ input: String) async -> String
}
