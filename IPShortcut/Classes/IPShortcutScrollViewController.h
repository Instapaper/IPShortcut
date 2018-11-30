//
//  IPShortcutScrollViewController.h
//  Instapaper
//
//  Created by briandonohue on 11/29/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPShortcutScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong, nullable) UIScrollView *scrollView;
@property (nonatomic) BOOL isScrollInProgress;

- (void)pageUp;
- (void)pageDown;
- (void)keyUp;
- (void)keyDown;
- (CGFloat)scrollWithinPageMargin;
- (CGFloat)scrollArrowHeight;
- (NSString *)keyUpTitle;
- (NSString *)keyDownTitle;

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
