//
//  NSCollectionViewDiffableDataSource+Private.h
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCollectionViewDiffableDataSource (Private)
- (void)applySnapshot:(id)arg1 animatingDifferences:(_Bool)arg2 completion:(void(^ _Nullable)(void))arg3;
@end

NS_ASSUME_NONNULL_END
