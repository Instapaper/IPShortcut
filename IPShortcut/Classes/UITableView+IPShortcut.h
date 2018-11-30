//
//  UITableView+IPShortcut.h
//  Instapaper
//
//  Created by briandonohue on 11/28/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (IPShortcut)

- (NSIndexPath *)ip_firstSelectedIndexPath;
- (NSIndexPath *)ip_firstCompletelyVisibleIndexPath;
- (NSIndexPath *)ip_lastCompletelyVisibleIndexPath;
- (void)ip_deselectAllIndexPaths:(BOOL)animated;
- (BOOL)ip_isIndexPathCompletelyVisible:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
