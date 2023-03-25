//
//  PhotoPickerViewModel.m
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import "PhotoPickerViewModel.h"
#import "NSCollectionViewDiffableDataSource+ApplySnapshotAndWait.h"
#define PHOTO_PICKER_VIEW_MODEL_SERIAL_QUEUE_LABEL "com.pookjw.PhotoPicker.Provider.Service.Queue"

typedef NSDiffableDataSourceSnapshot<PhotoPickerSectionModel *, PhotoPickerItemModel *> PhotoPickerDataSourceSnapshot;

void (^requestAuthorization)(void (^completion)(NSError * _Nullable)) = ^(void (^completion)(NSError * _Nullable)) {
    [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusNotDetermined:
                requestAuthorization(completion);
                break;
            case PHAuthorizationStatusAuthorized:
                completion(nil);
                break;
            default: {
                NSLog(@"%lu", status);
                // TODO
                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadNoPermissionError userInfo:nil];
                completion(error);
                break;
            }
        }
    }];
};

@interface PhotoPickerViewModel ()
@property (retain) PhotoPickerDataSource *dataSource;
@property (retain) dispatch_queue_t queue;
@end

@implementation PhotoPickerViewModel

- (instancetype)initWithDataSource:(PhotoPickerDataSource *)dataSource {
    if (self = [self init]) {
        self.dataSource = dataSource;
        [self setupQueue];
    }
    
    return self;
}

- (void)dealloc {
    [_dataSource release];
    dispatch_release(_queue);
    [super dealloc];
}

- (void)loadDataSourceWithCompletion:(void (^ _Nullable)(NSError * __autoreleasing _Nullable error))completion {
    PhotoPickerDataSource *dataSource = self.dataSource;
    
    dispatch_async(self.queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        __block NSError * _Nullable error = nil;
        
        requestAuthorization(^(NSError * _Nullable _error) {
            error = [_error copy];
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_release(semaphore);
        
        if (error) {
            completion([error autorelease]);
            return;
        }
        
        [error release];
        
        //
        
        PHFetchOptions *options = [PHFetchOptions new];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
        options.sortDescriptors = @[sortDescriptor];
        [sortDescriptor release];
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithOptions:options];
        [options release];
        
        //
        
        PhotoPickerDataSourceSnapshot *snapshot = [PhotoPickerDataSourceSnapshot new];
        
        PhotoPickerSectionModel *sectionModel = [[PhotoPickerSectionModel alloc] initWithType:PhotoPickerSectionModelTypePhotos];
        
        [snapshot appendSectionsWithIdentifiers:@[sectionModel]];
        
        [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PhotoPickerItemModel *itemModel = [[PhotoPickerItemModel alloc] initWithAsset:obj];
            [snapshot appendItemsWithIdentifiers:@[itemModel] intoSectionWithIdentifier:sectionModel];
            [itemModel release];
        }];
        
        [sectionModel release];
        
        [dataSource applySnapshotAndWait:snapshot animatingDifferences:YES];
        [snapshot release];
        
        completion(nil);
    });
}

- (void)setupQueue {
    dispatch_queue_attr_t attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, 0);
    dispatch_queue_t queue = dispatch_queue_create(PHOTO_PICKER_VIEW_MODEL_SERIAL_QUEUE_LABEL, attribute);
    dispatch_release(attribute);
    self.queue = queue;
    dispatch_release(queue);
}

@end
