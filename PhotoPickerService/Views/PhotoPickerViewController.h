//
//  PhotoPickerViewController.h
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import <Cocoa/Cocoa.h>

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

static NSNotificationName const NSNotificationNamePhotoPickerViewControllerDidSelectAssets = @"NSNotificationNamePhotoPickerViewControllerDidSelectAssets";
static NSString * const PhotoPickerViewControllerSelectedAssetsKey = @"PhotoPickerViewControllerSelectedAssetsKey";

static NSNotificationName const NSNotificationNamePhotoPickerViewControllerErrorOccured = @"NSNotificationNamePhotoPickerViewControllerDidSelectAssets";
static NSString * const PhotoPickerViewControllerErrorOccuredKey = @"PhotoPickerViewControllerErrorOccuredKey";

NS_SWIFT_UI_ACTOR
@interface PhotoPickerViewController : NSViewController

@end

NS_HEADER_AUDIT_END(nullability, sendability)
