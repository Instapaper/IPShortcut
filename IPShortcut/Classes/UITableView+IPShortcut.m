//
//  UITableView+IPShortcut.m
//  Instapaper
//
//  Created by briandonohue on 11/28/18.
//

#import "UITableView+IPShortcut.h"

@implementation UITableView (IPShortcut)

- (NSIndexPath *)ip_firstSelectedIndexPath {
    NSArray<NSIndexPath *> * selectedIndexes = [self indexPathsForSelectedRows];
    return [selectedIndexes count] > 0? selectedIndexes[0]: nil;
}

- (NSIndexPath *)ip_firstCompletelyVisibleIndexPath {
    NSArray<NSIndexPath *> * visibleIndexes = [self indexPathsForVisibleRows];
    if ([visibleIndexes count] == 0) {
        return nil;
    }
    
    NSIndexPath *firstVisibleIndexPath = nil;
    for (NSIndexPath *visibleIndexPath in visibleIndexes) {
        if ((firstVisibleIndexPath == nil || firstVisibleIndexPath.row > visibleIndexPath.row) &&
            [self ip_isIndexPathCompletelyVisible:visibleIndexPath]) {
            firstVisibleIndexPath = visibleIndexPath;
        }
    }
    
    return firstVisibleIndexPath;
}

- (NSIndexPath *)ip_lastCompletelyVisibleIndexPath {
    NSArray<NSIndexPath *> * visibleIndexes = [self indexPathsForVisibleRows];
    if ([visibleIndexes count] == 0) {
        return nil;
    }
    
    NSIndexPath *lastVisibleIndexPath = nil;
    for (NSIndexPath *visibleIndexPath in visibleIndexes) {
        if ((lastVisibleIndexPath == nil || lastVisibleIndexPath.row < visibleIndexPath.row) &&
            [self ip_isIndexPathCompletelyVisible:visibleIndexPath]) {
            lastVisibleIndexPath = visibleIndexPath;
        }
    }
    
    return lastVisibleIndexPath;
}

- (void)ip_deselectAllIndexPaths:(BOOL)animated {
    for (NSIndexPath *selectedIndexPath in self.indexPathsForSelectedRows) {
        [self deselectRowAtIndexPath:selectedIndexPath animated:animated];
    }
}

- (BOOL)ip_isIndexPathCompletelyVisible:(NSIndexPath *)indexPath {
    CGRect cellRect = [self rectForRowAtIndexPath:indexPath];
    return CGRectContainsRect(self.bounds, cellRect);
}

@end
