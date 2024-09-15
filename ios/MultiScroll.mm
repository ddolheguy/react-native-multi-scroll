#import "MultiScroll.h"
#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import <React/RCTLog.h>
#import <React/RCTBridge.h>
#import <React/RCTScrollView.h>

@interface RCTNativeSyncScrollViews : RCTViewManager<UIScrollViewDelegate>
@property (nonatomic) UIScrollView *primaryScrollViewToManage;
@property (nonatomic) UIScrollView *secondaryScrollViewToManage;
@end

@implementation RCTNativeSyncScrollViews

RCT_EXPORT_MODULE();

#pragma mark - UIScrollViewDelegate methods;

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
  [self.secondaryScrollViewToManage setContentOffset:_scrollView.contentOffset animated:NO];
}

RCT_EXPORT_METHOD(syncScrollEvent:(nonnull NSNumber*) primaryNodeId secondaryNodeId:(nonnull NSNumber*) secondaryNodeId) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, RCTScrollView *> *viewRegistry) {
      RCTScrollView *viewOne = viewRegistry[primaryNodeId];
      RCTScrollView *viewTwo = viewRegistry[secondaryNodeId];

        if (![viewOne isKindOfClass:[RCTScrollView class]] || ![viewTwo isKindOfClass:[RCTScrollView class]]) {
            RCTLogError(@"Invalid view returned from registry, expecting RCTScrollView");
          return;
        }

      self.primaryScrollViewToManage = ((RCTScrollView*)viewOne).scrollView;
      self.secondaryScrollViewToManage = ((RCTScrollView*)viewTwo).scrollView;

      if(viewOne.scrollView == self.primaryScrollViewToManage)
      {
          [viewOne removeScrollListener:self];
          [viewOne addScrollListener:self];
      }
    }];
}

@end
