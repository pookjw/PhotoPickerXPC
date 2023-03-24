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
    
    int e = NSBundleErrorMinimum;
    
    return self;
}

- (void)dealloc {
    [_dataSource release];
    dispatch_release(_queue);
    [super dealloc];
}

- (void)loadDataSourceWithError:(NSError * __autoreleasing _Nullable *)error {
    PhotoPickerDataSource *dataSource = self.dataSource;
    
    dispatch_async(self.queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        requestAuthorization(^(NSError * _Nullable error) {
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_release(semaphore);
        
        PhotoPickerDataSourceSnapshot *snapshot = [PhotoPickerDataSourceSnapshot new];
        
        PhotoPickerSectionModel *sectionModel = [[PhotoPickerSectionModel alloc] initWithType:PhotoPickerSectionModelTypePhotos];
        
        [snapshot appendSectionsWithIdentifiers:@[sectionModel]];
        
        for (NSUInteger i = 0; i < 3000; i++) {
            NSAutoreleasePool *pool = [NSAutoreleasePool new];
            
            PhotoPickerItemModel *itemModel = [[PhotoPickerItemModel alloc] initWithAsset:nil];
            [snapshot appendItemsWithIdentifiers:@[itemModel] intoSectionWithIdentifier:sectionModel];
            [itemModel release];
            
            [pool release];
        }
        
        [sectionModel release];
        
        [dataSource applySnapshotAndWait:snapshot animatingDifferences:YES];
        [snapshot release];
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
