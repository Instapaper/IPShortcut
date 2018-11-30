//
//  IPShortcutCollectionViewController.m
//  Instapaper
//
//  Created by briandonohue on 11/28/18.
//

#import "IPShortcutCollectionViewController.h"

#import "UICollectionView+IPShortcut.h"

@implementation IPShortcutCollectionViewController

- (id)init {
    self = [super init];
    if (self) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    return self;
}

- (NSInteger)numberOfColumns {
    return 1;
}

- (NSString *)nextItemTitle {
    return NSLocalizedString(@"Next Item", nil);
}

- (NSString *)previousItemTitle {
    return NSLocalizedString(@"Previous Item", nil);
}

- (NSString *)keyUpTitle {
    return [self numberOfColumns] == 1? [self previousItemTitle]: NSLocalizedString(@"Previous Row", nil);
}

- (NSString *)keyDownTitle {
    return [self numberOfColumns] == 1? [self nextItemTitle]: NSLocalizedString(@"Next Row", nil);
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    self.scrollView = collectionView;
}

- (void)pageUp {
    NSIndexPath *firstCompletelyVisibleIndexPath = [self.collectionView ip_firstCompletelyVisibleIndexPath];
    [self.collectionView ip_deselectAllIndexPaths:NO];
    [self.collectionView scrollToItemAtIndexPath:firstCompletelyVisibleIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

- (void)pageDown {
    NSIndexPath *lastCompletelyVisibleIndexPath = [self.collectionView ip_lastCompletelyVisibleIndexPath];
    [self.collectionView ip_deselectAllIndexPaths:NO];
    [self.collectionView scrollToItemAtIndexPath:lastCompletelyVisibleIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSIndexPath *firstSelectedIndexPath = [self.collectionView ip_firstSelectedIndexPath];
    if (self.isScrollInProgress && firstSelectedIndexPath != nil) {
        // There is an issue where cells are selected but do not appear selected after keyUp animation
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:firstSelectedIndexPath];
        [cell setSelected:YES];
    }
    self.isScrollInProgress = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // Reset selected index paths so next key up/down is within current view
    [self.collectionView ip_deselectAllIndexPaths:NO];
}

#pragma mark - UIKeyCommands

- (void)keyPrevious:(NSInteger)decrement {
    if (self.isScrollInProgress) {
        return;
    }
    NSIndexPath *lastVisibleIndexPath = [self.collectionView ip_lastCompletelyVisibleIndexPath];
    NSIndexPath *selectedIndexPath = [self.collectionView ip_firstSelectedIndexPath];
    NSIndexPath *indexPathToSelect = selectedIndexPath? [NSIndexPath indexPathForRow:MAX(selectedIndexPath.row - decrement, 0) inSection:0]: lastVisibleIndexPath;
    
    if (!indexPathToSelect) {
        return;
    }
    
    [self.collectionView ip_deselectAllIndexPaths:NO];
    
    self.isScrollInProgress = ![self.collectionView ip_isIndexPathCompletelyVisible:indexPathToSelect];
    UICollectionViewScrollPosition position = self.isScrollInProgress? UICollectionViewScrollPositionTop: UICollectionViewScrollPositionNone;
    [self.collectionView selectItemAtIndexPath:indexPathToSelect animated:self.isScrollInProgress scrollPosition:position];
}

- (void)keyNext:(NSInteger)increment {
    if (self.isScrollInProgress) {
        return;
    }
    NSIndexPath *firstVisibleIndexPath = [self.collectionView ip_firstCompletelyVisibleIndexPath];
    NSIndexPath *selectedIndexPath = [self.collectionView ip_firstSelectedIndexPath];
    NSInteger itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    NSIndexPath *indexPathToSelect = selectedIndexPath?
    [NSIndexPath indexPathForRow:MIN(selectedIndexPath.row + increment, itemCount - 1) inSection:0]: firstVisibleIndexPath;
    
    if (!indexPathToSelect) {
        return;
    }
    
    [self.collectionView ip_deselectAllIndexPaths:NO];
    
    self.isScrollInProgress = ![self.collectionView ip_isIndexPathCompletelyVisible:indexPathToSelect];
    UICollectionViewScrollPosition position = self.isScrollInProgress? UICollectionViewScrollPositionBottom: UICollectionViewScrollPositionNone;
    [self.collectionView selectItemAtIndexPath:indexPathToSelect animated:self.isScrollInProgress scrollPosition:position];
}

- (void)keyUp {
    [self keyPrevious:[self numberOfColumns]];
}

- (void)keyDown {
    [self keyNext:[self numberOfColumns]];
}

- (void)keyLeft {
    [self keyPrevious:1];
}

- (void)keyRight {
    [self keyNext:1];
}

- (void)keyEnter {
    NSIndexPath *selectedIndexPath = [self.collectionView ip_firstSelectedIndexPath];
    if (selectedIndexPath)
        [self.collectionView.delegate collectionView:self.collectionView didSelectItemAtIndexPath:selectedIndexPath];
}

- (NSArray<UIKeyCommand *>*)keyCommands {
    NSMutableArray *allCommands = [[super keyCommands] mutableCopy];
    if ([self numberOfColumns] > 1) {
        [allCommands addObjectsFromArray:
         @[[UIKeyCommand keyCommandWithInput:UIKeyInputLeftArrow
                               modifierFlags:0
                                      action:@selector(keyLeft)
                        discoverabilityTitle:[self previousItemTitle]],
           [UIKeyCommand keyCommandWithInput:UIKeyInputRightArrow
                               modifierFlags:0
                                      action:@selector(keyRight)
                        discoverabilityTitle:[self nextItemTitle]]
           ]];
    }
    [allCommands addObject:[UIKeyCommand keyCommandWithInput:@"\r"
                                               modifierFlags:0
                                                      action:@selector(keyEnter)
                                        discoverabilityTitle:NSLocalizedString(@"Open Selected", nil)]];
    return allCommands;
}

@end
