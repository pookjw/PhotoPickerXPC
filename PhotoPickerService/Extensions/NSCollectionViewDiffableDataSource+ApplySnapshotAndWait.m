//
//  NSCollectionViewDiffableDataSource+ApplySnapshotAndWait.m
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import "NSCollectionViewDiffableDataSource+ApplySnapshotAndWait.h"
#import "NSCollectionViewDiffableDataSource+Private.h"

@implementation NSCollectionViewDiffableDataSource (ApplySnapshotAndWait)

- (void)applySnapshotAndWait:(NSDiffableDataSourceSnapshot *)snapshot animatingDifferences:(BOOL)animatingDifferences {
    if (NSThread.isMainThread) {
        [self applySnapshot:snapshot animatingDifferences:animatingDifferences];
    } else {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self applySnapshot:snapshot animatingDifferences:animatingDifferences completion:^{
                dispatch_semaphore_signal(semaphore);
            }];
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_release(semaphore);
    }
}

@end
