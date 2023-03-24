//
//  PhotoPickerSectionModel.m
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import "PhotoPickerSectionModel.h"

@implementation PhotoPickerSectionModel

- (instancetype)initWithType:(PhotoPickerSectionModelType)type {
    if (self = [self init]) {
        self->_type = type;
    }
    
    return self;
}

- (NSUInteger)hash {
    return self.type;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:PhotoPickerSectionModel.self]) {
        return NO;
    }
    
    PhotoPickerSectionModel *other = object;
    return self.type == other.type;
}

@end
