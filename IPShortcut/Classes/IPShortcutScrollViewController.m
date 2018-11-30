//
//  IPShortcutScrollViewController.m
//  Instapaper
//
//  Created by briandonohue on 11/29/18.
//

#import "IPShortcutScrollViewController.h"

@interface IPShortcutScrollViewController ()

@end

@implementation IPShortcutScrollViewController

- (id)init {
    self = [super init];
    if (self) {
        self.scrollView = [[UIScrollView alloc] init];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (CGFloat)scrollArrowHeight {
    return 350;
}

- (CGFloat)scrollWithinPageMargin {
    /* Provide enough space that there is context from the last page */
    return 150;
}

- (NSString *)keyUpTitle {
    return NSLocalizedString(@"Scroll Up", nil);
}

- (NSString *)keyDownTitle {
    return NSLocalizedString(@"Scroll Down", nil);
}

- (void)scrollToPoint:(CGPoint)point {
    if (self.isScrollInProgress || point.y == self.scrollView.contentOffset.y)
        return;
    self.isScrollInProgress = YES;
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)pageDown {
    CGFloat yOffset = MIN(self.scrollView.contentOffset.y + self.scrollView.frame.size.height - [self scrollWithinPageMargin],
                          self.scrollView.contentSize.height - self.scrollView.frame.size.height);
    [self scrollToPoint:CGPointMake(0, yOffset)];
}

- (void)pageUp {
    CGFloat yOffset = MAX(self.scrollView.contentOffset.y - self.scrollView.frame.size.height + [self scrollWithinPageMargin], 0);
    [self scrollToPoint:CGPointMake(0, yOffset)];
}

- (void)keyUp {
    CGFloat yOffset = MAX(self.scrollView.contentOffset.y - [self scrollArrowHeight], 0);
    [self scrollToPoint:CGPointMake(0, yOffset)];
}

- (void)keyDown {
    CGFloat yOffset = MIN(self.scrollView.contentOffset.y + [self scrollArrowHeight],
                          self.scrollView.contentSize.height - self.scrollView.frame.size.height);
    [self scrollToPoint:CGPointMake(0, yOffset)];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.isScrollInProgress = NO;
}

- (NSArray<UIKeyCommand *>*)keyCommands {
    return @[
             [UIKeyCommand keyCommandWithInput:@" " modifierFlags:0 action:@selector(pageDown) discoverabilityTitle:NSLocalizedString(@"Page Down", nil)],
             [UIKeyCommand keyCommandWithInput:@" " modifierFlags:UIKeyModifierShift action:@selector(pageUp) discoverabilityTitle:NSLocalizedString(@"Page Up", nil)],
             [UIKeyCommand keyCommandWithInput:UIKeyInputUpArrow modifierFlags:0 action:@selector(keyUp) discoverabilityTitle:[self keyUpTitle]],
             [UIKeyCommand keyCommandWithInput:UIKeyInputDownArrow modifierFlags:0 action:@selector(keyDown) discoverabilityTitle:[self keyDownTitle]],
             ];
}

@end
