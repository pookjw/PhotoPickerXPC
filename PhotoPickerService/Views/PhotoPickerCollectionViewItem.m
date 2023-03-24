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
    self.view.wantsLayer = YES;
}

- (void)configureWithAsset:(PHAsset *)asset {
    CGFloat red = rand() / (CGFloat)RAND_MAX;
    CGFloat green = rand() / (CGFloat)RAND_MAX;
    CGFloat blue = rand() / (CGFloat)RAND_MAX;
    
    CGColorRef color = CGColorCreateSRGB(red, green, blue, 1.f);
    self.view.layer.backgroundColor = color;
    CGColorRelease(color);
}

@end
