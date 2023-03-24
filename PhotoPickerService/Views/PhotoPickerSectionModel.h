//
//  PhotoPickerSectionModel.h
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PhotoPickerSectionModelType) {
    PhotoPickerSectionModelTypePhotos
};

@interface PhotoPickerSectionModel : NSObject
@property (readonly) PhotoPickerSectionModelType type;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(PhotoPickerSectionModelType)type;
@end

NS_ASSUME_NONNULL_END
