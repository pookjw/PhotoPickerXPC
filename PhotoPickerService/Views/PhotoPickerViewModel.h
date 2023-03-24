//
//  PhotoPickerViewModel.h
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import <Cocoa/Cocoa.h>
#import "PhotoPickerSectionModel.h"
#import "PhotoPickerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSCollectionViewDiffableDataSource<PhotoPickerSectionModel *, PhotoPickerItemModel *> PhotoPickerDataSource;

@interface PhotoPickerViewModel : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(PhotoPickerDataSource *)dataSource;
- (void)loadDataSourceWithError:(NSError * __autoreleasing _Nullable *)error;
@end

NS_ASSUME_NONNULL_END
