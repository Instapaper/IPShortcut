//
//  IPShortcutTableViewController.h
//  Instapaper
//
//  Created by briandonohue on 11/28/18.
//

#import <UIKit/UIKit.h>

#import "IPShortcutScrollViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IPShortcutTableViewController : IPShortcutScrollViewController

@property (nonatomic, strong, nullable) UITableView *tableView;

- (void)keyEnter;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
