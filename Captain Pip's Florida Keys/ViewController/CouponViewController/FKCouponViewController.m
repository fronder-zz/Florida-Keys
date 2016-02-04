//
//  FKCouponViewController.m
//  Florida Keys
//
//  Created by Hasan's Mac on 30.01.16.
//  Copyright © 2016 Khasan Abdullaev. All rights reserved.
//

#import "FKCouponViewController.h"
#import "FKCouponDetailsViewController.h"
#import "FKOfferViewController.h"
#import "AppDelegate.h"

static const NSInteger TagOffset = 1000;

@interface FKCouponViewController () 

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsMiddleLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offerEventLayout;

@property (weak, nonatomic) IBOutlet UIButton *offerButton;
@property (weak, nonatomic) IBOutlet UIButton *eventButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *faqButton;
@property (weak, nonatomic) IBOutlet UIView *bodyView;

@end

@implementation FKCouponViewController {
    UIView *tabButtonsContainerView;
    UIView *contentContainerView;
    UIImageView *indicatorImageView;
}

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutViews];
    [self initialize];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutTabButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
        tabButtonsContainerView = nil;
        contentContainerView = nil;
        indicatorImageView = nil;
    }
}


#pragma mark - Action

- (IBAction)offerButtonClicked:(id)sender {
    FKOfferViewController *offerVC = [[FKOfferViewController alloc] init];
    
}

- (IBAction)eventButtonClicked:(id)sender {
    
}

- (IBAction)settingsButtonClicked:(id)sender {
    
}

- (IBAction)faqButtonClicked:(id)sender {
    
}


#pragma mark - Helper

- (void)layoutViews {
    if (IS_IPHONE_5_OR_LESS) {
        self.buttonsMiddleLayout.constant -= 35;
        self.offerEventLayout.constant -= 10;
    } else if (IS_IPHONE_6)
        self.buttonsMiddleLayout.constant -= 10;
    else if (IS_IPHONE_6P) {
        self.offerEventLayout.constant += 10;
    }
    
    [self.offerButton setBackgroundImage:IMAGE(@"OFFER-190X50.gif") forState:UIControlStateNormal];
    [self.eventButton setBackgroundImage:IMAGE(@"POLICE-190X50.gif") forState:UIControlStateNormal];
    self.settingsButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.faqButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)initialize {
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.bodyView.bounds.size.width, self.tabBarHeight);
    tabButtonsContainerView = [[UIView alloc] initWithFrame:rect];
    tabButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    [self.bodyView addSubview:tabButtonsContainerView];
    
    rect.origin.y = self.tabBarHeight;
    rect.size.height = self.bodyView.bounds.size.height - self.tabBarHeight;
    contentContainerView = [[UIView alloc] initWithFrame:rect];
    contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.bodyView addSubview:contentContainerView];
    
    indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MHTabBarIndicator"]];
    [self.bodyView addSubview:indicatorImageView];
    
    [self reloadTabButtons];
}

- (void)reloadTabButtons
{
    [self removeTabButtons];
    [self addTabButtons];
    
    // Force redraw of the previously active tab.
    NSUInteger lastIndex = _selectedIndex;
    _selectedIndex = NSNotFound;
    self.selectedIndex = lastIndex;
}

- (void)addTabButtons
{
    NSUInteger index = 0;
    for (UIViewController *viewController in self.viewControllers)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = TagOffset + index;
        if (index >= 2) {
            return;
        }
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        
        UIOffset offset = viewController.tabBarItem.titlePositionAdjustment;
        button.titleEdgeInsets = UIEdgeInsetsMake(offset.vertical, offset.horizontal, 0.0f, 0.0f);
        button.imageEdgeInsets = viewController.tabBarItem.imageInsets;
        [button setTitle:viewController.tabBarItem.title forState:UIControlStateNormal];
        [button setImage:viewController.tabBarItem.image forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        
        [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        [self deselectTabButton:button];
        [tabButtonsContainerView addSubview:button];
        
        ++index;
    }
}

- (void)removeTabButtons
{
    while ([tabButtonsContainerView.subviews count] > 0)
    {
        [[tabButtonsContainerView.subviews lastObject] removeFromSuperview];
    }
}

- (void)layoutTabButtons
{
    NSUInteger index = 0;
    NSUInteger count = [self.viewControllers count]-1;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, floorf(self.view.bounds.size.width / count), self.tabBarHeight);
    
    indicatorImageView.hidden = YES;
    
    NSArray *buttons = [tabButtonsContainerView subviews];
    for (UIButton *button in buttons)
    {
        if (index == count - 1)
            rect.size.width = self.view.bounds.size.width - rect.origin.x;
        
        button.frame = rect;
        rect.origin.x += rect.size.width;
        
        if (index == self.selectedIndex)
            [self centerIndicatorOnButton:button];
        
        ++index;
    }
}

- (void)centerIndicatorOnButton:(UIButton *)button
{
    CGRect rect = indicatorImageView.frame;
    rect.origin.x = button.center.x - floorf(indicatorImageView.frame.size.width/2.0f);
    rect.origin.y = self.tabBarHeight - indicatorImageView.frame.size.height;
    indicatorImageView.frame = rect;
    indicatorImageView.hidden = NO;
}

- (void)setViewControllers:(NSArray *)newViewControllers
{
    NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
    
    UIViewController *oldSelectedViewController = self.selectedViewController;
    
    // Remove the old child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    _viewControllers = [newViewControllers copy];
    
    // This follows the same rules as UITabBarController for trying to
    // re-select the previously selected view controller.
    NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
    if (newIndex != NSNotFound)
        _selectedIndex = newIndex;
    else if (newIndex < [_viewControllers count])
        _selectedIndex = newIndex;
    else
        _selectedIndex = 0;
    
    // Add the new child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    if ([self isViewLoaded])
        [self reloadTabButtons];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
    [self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
    NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
    
    if ([self.delegate respondsToSelector:@selector(mh_tabBarController:shouldSelectViewController:atIndex:)])
    {
        UIViewController *toViewController = (self.viewControllers)[newSelectedIndex];
        if (![self.delegate mh_tabBarController:self shouldSelectViewController:toViewController atIndex:newSelectedIndex])
            return;
    }
    
    if (![self isViewLoaded])
    {
        _selectedIndex = newSelectedIndex;
    }
    else if (_selectedIndex != newSelectedIndex)
    {
        UIViewController *fromViewController;
        UIViewController *toViewController;
        
        if (_selectedIndex != NSNotFound)
        {
            NSInteger _tag;
            if (newSelectedIndex < 2) {
                if (_selectedIndex == 2) {
                    _tag = 1000;
                } else {
                    _tag = TagOffset + _selectedIndex;
                }
                
                UIButton *fromButton = (UIButton *)[tabButtonsContainerView viewWithTag:_tag];
                [self deselectTabButton:fromButton];
            } else
                _tag = TagOffset + _selectedIndex;
            
            fromViewController = self.selectedViewController;
        }
        
        NSUInteger oldSelectedIndex = _selectedIndex;
        _selectedIndex = newSelectedIndex;
        
        UIButton *toButton;
        if (_selectedIndex != NSNotFound)
        {
            toButton = (UIButton *)[tabButtonsContainerView viewWithTag:TagOffset + _selectedIndex];
            [self selectTabButton:toButton];
            toViewController = self.selectedViewController;
        }
        
        if (toViewController == nil)  // don't animate
        {
            [fromViewController.view removeFromSuperview];
        }
        else if (fromViewController == nil)  // don't animate
        {
            toViewController.view.frame = contentContainerView.bounds;
            [contentContainerView addSubview:toViewController.view];
            [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
        else if (animated)
        {
            CGRect rect = contentContainerView.bounds;
            if (oldSelectedIndex < newSelectedIndex)
                rect.origin.x = rect.size.width;
            else
                rect.origin.x = -rect.size.width;
            
            toViewController.view.frame = rect;
            tabButtonsContainerView.userInteractionEnabled = NO;
            
            [self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3f
                                       options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                     rect.origin.x = -rect.size.width;
                 else
                     rect.origin.x = rect.size.width;
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = contentContainerView.bounds;
                 [self centerIndicatorOnButton:toButton];
             }
                                    completion:^(BOOL finished)
             {
                 tabButtonsContainerView.userInteractionEnabled = YES;
                 
                 if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                     [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
             }];
        }
        else  // not animated
        {
            [fromViewController.view removeFromSuperview];
            
            toViewController.view.frame = contentContainerView.bounds;
            [contentContainerView addSubview:toViewController.view];
            [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
    }
}

- (UIViewController *)selectedViewController
{
    if (self.selectedIndex != NSNotFound)
        return (self.viewControllers)[self.selectedIndex];
    else
        return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
    [self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated
{
    NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
    if (index != NSNotFound)
        [self setSelectedIndex:index animated:animated];
}

- (void)tabButtonPressed:(UIButton *)sender
{
    [self setSelectedIndex:sender.tag - TagOffset animated:YES];
}

- (void)showDetailForCouponObject:(FKCouponObject *)coupon {
    NSInteger ID = 2;
    FKCouponDetailsViewController *detailsVC = (FKCouponDetailsViewController *)(self.viewControllers)[ID];
    detailsVC.coupon = coupon;
    [self setSelectedIndex:ID animated:YES];
}

#pragma mark - Change these methods to customize the look of the buttons

- (void)selectTabButton:(UIButton *)button
{
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //	UIImage *image = [[UIImage imageNamed:@"MHTabBarActiveTab"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [button setBackgroundImage:IMAGE(@"segmentedSelectedBG") forState:UIControlStateNormal];
    [button setBackgroundImage:IMAGE(@"segmentedSelectedBG") forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
}

- (void)deselectTabButton:(UIButton *)button
{
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *image = [[UIImage imageNamed:@"MHTab/BarInactiveTab"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (CGFloat)tabBarHeight
{
    return 44.0f;
}


#pragma mark - MHTabBarControllerDelegate

- (BOOL)mh_tabBarController:(FKCouponViewController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    NSLog(@"mh_tabBarController %@ shouldSelectViewController %@ at index %lu", tabBarController, viewController, (unsigned long)index);
    
    // Uncomment this to prevent "Tab 3" from being selected.
    //return (index != 2);
    
    return YES;
}

- (void)mh_tabBarController:(FKCouponViewController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    NSLog(@"mh_tabBarController %@ didSelectViewController %@ at index %lu", tabBarController, viewController, (unsigned long)index);
}



@end
