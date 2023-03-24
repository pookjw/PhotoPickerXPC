//
//  PhotoPickerItemModel.h
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoPickerItemModel : NSObject
@property (readonly, copy) PHAsset *asset;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAsset:(PHAsset *)asset;
@end

NS_ASSUME_NONNULL_END
