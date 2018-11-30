//
//  IPShortcutTableViewController.m
//  Instapaper
//
//  Created by briandonohue on 11/28/18.
//

#import "IPShortcutTableViewController.h"

#import "UITableView+IPShortcut.h"

@implementation IPShortcutTableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.tableView = [[UITableView alloc] init];
    }
    return self;
}

- (NSString *)keyUpTitle {
    return NSLocalizedString(@"Previous Item", nil);
}

- (NSString *)keyDownTitle {
    return NSLocalizedString(@"Next Item", nil);
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    self.scrollView = tableView;
}

- (void)pageUp {
    NSIndexPath *firstCompletelyVisibleIndexPath = [self.tableView ip_firstCompletelyVisibleIndexPath];
    [self.tableView ip_deselectAllIndexPaths:NO];
    [self.tableView scrollToRowAtIndexPath:firstCompletelyVisibleIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)pageDown {
    NSIndexPath *lastCompletelyVisibleIndexPath = [self.tableView ip_lastCompletelyVisibleIndexPath];
    [self.tableView ip_deselectAllIndexPaths:NO];
    [self.tableView scrollToRowAtIndexPath:lastCompletelyVisibleIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSIndexPath *firstSelectedIndexPath = [self.tableView ip_firstSelectedIndexPath];
    if (self.isScrollInProgress && firstSelectedIndexPath != nil) {
        // There is an issue where cells are selected but do not appear selected after keyUp animation
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:firstSelectedIndexPath];
        [cell setSelected:YES];
    }
    self.isScrollInProgress = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // Reset selected index paths so next key up/down is within current view
    [self.tableView ip_deselectAllIndexPaths:NO];
}

#pragma mark - UIKeyCommands

- (void)keyUp {
    if (self.isScrollInProgress) {
        return;
    }
    NSIndexPath *lastVisibleIndexPath = [self.tableView ip_lastCompletelyVisibleIndexPath];
    NSIndexPath *selectedIndexPath = [self.tableView ip_firstSelectedIndexPath];
    NSIndexPath *indexPathToSelect = selectedIndexPath? [NSIndexPath indexPathForRow:MAX(selectedIndexPath.row - 1, 0) inSection:0]: lastVisibleIndexPath;
    
    if (!indexPathToSelect) {
        return;
    }
    
    [self.tableView ip_deselectAllIndexPaths:NO];
    
    self.isScrollInProgress = ![self.tableView ip_isIndexPathCompletelyVisible:indexPathToSelect];
    UITableViewScrollPosition position = self.isScrollInProgress? UITableViewScrollPositionTop: UITableViewScrollPositionNone;
    [self.tableView selectRowAtIndexPath:indexPathToSelect animated:self.isScrollInProgress scrollPosition:position];
}

- (void)keyDown {
    if (self.isScrollInProgress) {
        return;
    }
    NSIndexPath *firstVisibleIndexPath = [self.tableView ip_firstCompletelyVisibleIndexPath];
    NSIndexPath *selectedIndexPath = [self.tableView ip_firstSelectedIndexPath];
    NSInteger itemCount = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:0];
    NSIndexPath *indexPathToSelect = selectedIndexPath?
    [NSIndexPath indexPathForRow:MIN(selectedIndexPath.row + 1, itemCount - 1) inSection:0]: firstVisibleIndexPath;
    
    if (!indexPathToSelect) {
        return;
    }
    
    [self.tableView ip_deselectAllIndexPaths:NO];
    
    self.isScrollInProgress = ![self.tableView ip_isIndexPathCompletelyVisible:indexPathToSelect];
    UITableViewScrollPosition position = self.isScrollInProgress? UITableViewScrollPositionBottom: UITableViewScrollPositionNone;
    [self.tableView selectRowAtIndexPath:indexPathToSelect animated:self.isScrollInProgress scrollPosition:position];
}

- (void)keyEnter {
    NSIndexPath *selectedIndexPath = [self.tableView ip_firstSelectedIndexPath];
    if (selectedIndexPath)
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:selectedIndexPath];
}

- (NSArray<UIKeyCommand *>*)keyCommands {
    
    NSMutableArray *allCommands = [[super keyCommands] mutableCopy];
    [allCommands addObject:[UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(keyEnter) discoverabilityTitle:NSLocalizedString(@"Open Selected", nil)]];
    return allCommands;
}

@end
