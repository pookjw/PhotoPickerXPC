//
//  PhotoPickerCollectionViewItem.m
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import "PhotoPickerCollectionViewItem.h"
#import <time.h>

@interface PhotoPickerCollectionViewItem ()

@end

@implementation PhotoPickerCollectionViewItem

- (void)loadView {
    NSView *view = [NSView new];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImageView];
}

- (void)configureWithAsset:(PHAsset *)asset {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = NO;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.networkAccessAllowed = YES;
    
    // TODO: Cancelling
    [PHImageManager.defaultManager requestImageForAsset:asset
                                             targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)
                                            contentMode:PHImageContentModeAspectFit
                                                options:options
                                          resultHandler:^(NSImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = result;
        });
    }];
    
    [options release];
}

- (void)setupImageView {
    NSImageView *imageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    self.imageView = imageView;
    [imageView release];
}

@end
