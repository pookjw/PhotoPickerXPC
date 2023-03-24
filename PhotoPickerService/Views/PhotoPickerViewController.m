//
//  PhotoPickerViewController.m
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/24/23.
//

#import "PhotoPickerViewController.h"
#import "PhotoPickerViewModel.h"
#import "PhotoPickerCollectionViewItem.h"

// TODO: Prefetching
// TODO: Touch Bar
// TODO: PHAsset has isOriginalRaw methods and more!

@interface PhotoPickerViewController ()
@property (retain) NSScrollView *scrollView;
@property (retain) NSCollectionView *collectionView;
@property (retain) PhotoPickerViewModel *viewModel;
@end

@implementation PhotoPickerViewController

- (void)dealloc {
    [_scrollView release];
    [_collectionView release];
    [_viewModel release];
    [super dealloc];
}

- (void)loadView {
    NSView *view = [NSView new];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupCollectionView];
    [self setupViewModel];
    [self.viewModel loadDataSourceWithError:nil]; // TOOD: Error Handling
    
    [PHAsset new];
}

- (void)setupScrollView {
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:scrollView];
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    self.scrollView = scrollView;
    [scrollView release];
}

- (void)setupCollectionView {
    NSCollectionView *collectionView = [[NSCollectionView alloc] initWithFrame:self.scrollView.bounds];
    collectionView.collectionViewLayout = [self makeCollectionViewLayout];
    [collectionView registerClass:PhotoPickerCollectionViewItem.class forItemWithIdentifier:NSUserInterfaceItemIdentifierPhotoPickerCollectionViewItem];
    
    self.scrollView.documentView = collectionView;
    self.collectionView = collectionView;
    [collectionView release];
}

- (void)setupViewModel {
    PhotoPickerViewModel *viewModel = [[PhotoPickerViewModel alloc] initWithDataSource:[self makeDataSource]];
    self.viewModel = viewModel;
    [viewModel release];
}

- (NSCollectionViewCompositionalLayout *)makeCollectionViewLayout {
    NSCollectionViewCompositionalLayoutConfiguration *configuration = [NSCollectionViewCompositionalLayoutConfiguration new];
    configuration.scrollDirection = NSCollectionViewScrollDirectionVertical;
    
    NSCollectionViewCompositionalLayout *collectionViewLayout = [[NSCollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger sectionIndex, id<NSCollectionLayoutEnvironment> _Nonnull environment) {
        CGFloat minLength = 150.f;
        CGFloat count = ceilf(environment.container.contentSize.width / minLength);
        
        NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.f / count]
                                                                          heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.f]];
        
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
        
        NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.f]
                                                                           heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.f / count]];
        
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize
                                                                                        subitem:item
                                                                                          count:(NSInteger)count];
        
        NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
        
        return section;
    } configuration:configuration];
    
    [configuration release];
    return [collectionViewLayout autorelease];
}

- (PhotoPickerDataSource *)makeDataSource {
    PhotoPickerDataSource *dataSource = [[PhotoPickerDataSource alloc] initWithCollectionView:self.collectionView itemProvider:^NSCollectionViewItem * _Nullable(NSCollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, PhotoPickerItemModel * _Nonnull itemModel) {
        PhotoPickerCollectionViewItem *item = [collectionView makeItemWithIdentifier:NSUserInterfaceItemIdentifierPhotoPickerCollectionViewItem forIndexPath:indexPath];
        
        [item configureWithAsset:itemModel.asset];
        
        return item;
    }];
    
    dataSource.supplementaryViewProvider = ^NSView * _Nullable(NSCollectionView * _Nonnull collectionView, NSString * _Nonnull kind, NSIndexPath * _Nonnull indexPath) {
        // TODO: Bagdes
        return nil;
    };
    
    return [dataSource autorelease];
}

@end
