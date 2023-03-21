//
//  PhotoPickerServiceObject.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/22/23.
//

import Foundation
import PhotoPickerCommon

actor PhotoPickerServiceObject: NSObject, PhotoPickerServiceProtocol {
    let appExtension: any PhotoPickerXPCExtension
    
    init(appExtension: some PhotoPickerXPCExtension) {
        self.appExtension = appExtension
        super.init()
    }
    
    func transform(_ input: String) async -> String {
        await appExtension.transform(input)
    }
}
