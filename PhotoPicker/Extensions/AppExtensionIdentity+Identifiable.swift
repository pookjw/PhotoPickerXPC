//
//  AppExtensionIdentity+Identifiable.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/19/23.
//

import ExtensionFoundation

extension AppExtensionIdentity: Identifiable {
    public var id: Int {
        hashValue
    }
}
