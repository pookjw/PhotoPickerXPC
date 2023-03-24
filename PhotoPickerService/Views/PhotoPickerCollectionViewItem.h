//
//  PhotoPickerCollectionViewItem.h
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import <Cocoa/Cocoa.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

static NSUserInterfaceItemIdentifier const NSUserInterfaceItemIdentifierPhotoPickerCollectionViewItem = @"NSUserInterfaceItemIdentifierPhotoPickerCollectionViewItem";

@interface PhotoPickerCollectionViewItem : NSCollectionViewItem
- (void)configureWithAsset:(PHAsset *)asset;
@end

NS_ASSUME_NONNULL_END
