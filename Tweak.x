#import <libAPAppView.h>

@interface APAppViewPullOverWrapper : NSObject
+(instancetype)sharedInstance;
@end

%hook ContextHostManager
+(id)sharedInstance {
	return [APAppViewPullOverWrapper sharedInstance];
}
%end

@interface APAppViewPullOverWrapperView : UIView
@property (nonatomic, retain) APAppView *appView;
@end

@implementation APAppViewPullOverWrapperView
@end

@implementation APAppViewPullOverWrapper

+(instancetype)sharedInstance {
  static dispatch_once_t p = 0;
  __strong static id _sharedSelf = nil;
  dispatch_once(&p, ^{
    _sharedSelf = [[self alloc] init];
  });
  return _sharedSelf;
}

-(UIView *)hostViewForBundleID:(NSString *)arg2 {
	APAppView *IAppView = [[APAppView alloc] init];
	UIView *appView = [IAppView viewForBundleID:arg2];
	APAppViewPullOverWrapperView *view = [[APAppViewPullOverWrapperView alloc] initWithFrame:appView.frame];
	[view addSubview:appView];
	view.appView = IAppView;
	return view;
}

-(void)stopHostingView:(UIView *)arg2 forBundleId:(void *)arg3 {
	if([arg2 isKindOfClass:[APAppViewPullOverWrapperView class]]) {
		[((APAppViewPullOverWrapperView *)arg2).appView stopAppView];
		((APAppViewPullOverWrapperView *)arg2).appView = nil;
	}
}

-(bool)isHostViewHosting {
	return false;
}
-(bool)isHostViewHosting:(UIView *)arg2 {
	if([arg2 isKindOfClass:[APAppViewPullOverWrapperView class]]) {
		return ((APAppViewPullOverWrapperView *)arg2).appView != nil;
	}
	return false;
}

-(void)setSceneDelegate:(id)arg2 {}
-(void)stopHostingForBundleID:(void *)arg2 {}
@end