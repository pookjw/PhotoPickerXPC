//
//  PhotoPickerItemModel.m
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import "PhotoPickerItemModel.h"

@implementation PhotoPickerItemModel

- (instancetype)initWithAsset:(PHAsset *)asset {
    if (self = [self init]) {
        [self->_asset release];
        self->_asset = [asset copy];
    }
    
    return self;
}

- (void)dealloc {
    [_asset release];
    [super dealloc];
}

- (NSUInteger)hash {
    return self.asset.hash;
}


@end
