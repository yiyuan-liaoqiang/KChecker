
#import "ProgressHUD.h"

@implementation ProgressHUD

@synthesize window, hud;

+ (ProgressHUD *)shared
{
	static dispatch_once_t once = 0;
	static ProgressHUD *progressHUD;
	dispatch_once(&once, ^{ progressHUD = [[ProgressHUD alloc] init]; });
	return progressHUD;
}

+ (void)showMessage:(NSString *)status
{
    if (status == nil || status.length == 0) {
        return;
    }
	[[self shared] hudMake2:status imgage:nil spin:NO hide:YES Width:300 High:30];
}

- (id)init
{
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
	if ([delegate respondsToSelector:@selector(window)])
		window = [delegate performSelector:@selector(window)];
	else window = [[UIApplication sharedApplication] keyWindow];
	hud = nil; self.label = nil;
	self.alpha = 0;
	return self;
}

- (void)hudCreate
{
	if (hud == nil)
	{
		hud = [[UIToolbar alloc] initWithFrame:CGRectZero];
        hud.barTintColor = HUD_BACKGROUND_COLOR;
		hud.translucent = YES;
		hud.layer.cornerRadius = 10;
		hud.layer.masksToBounds = YES;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	if (hud.superview == nil)
        [window addSubview:hud];
	if (self.label.superview == nil){
        [hud addSubview:self.label];
    }
}

- (void)hudDestroy
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[self.label removeFromSuperview];	self.label = nil;
	[hud removeFromSuperview];		hud = nil;
}

- (void)rotate:(NSNotification *)notification
{
	[self hudOrient];
}

- (void)hudOrient
{
	CGFloat rotate = 0.0;
	UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
	if (orient == UIInterfaceOrientationPortrait)			rotate = 0.0;
	if (orient == UIInterfaceOrientationPortraitUpsideDown)	rotate = M_PI;
	if (orient == UIInterfaceOrientationLandscapeLeft)		rotate = - M_PI_2;
	if (orient == UIInterfaceOrientationLandscapeRight)		rotate = + M_PI_2;
//	hud.transform = CGAffineTransformMakeRotation(rotate);
}

- (void)hudShow
{
	if (self.alpha == 0)
	{
		self.alpha = 1;

		hud.alpha = 0;
		hud.transform = CGAffineTransformScale(hud.transform, 1.2, 1.2);

		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;

		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            self->hud.transform = CGAffineTransformScale(self->hud.transform, 1/1.4, 1/1.4);
            self->hud.alpha = 1;
		}
		completion:^(BOOL finished){ }];
	}
}

- (void)hudHide
{
	if (self.alpha == 1)
	{
		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;

		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
            self->hud.transform = CGAffineTransformScale(self->hud.transform, 0.7, 0.7);
            self->hud.alpha = 0;
		}
		completion:^(BOOL finished)
		{
			[self hudDestroy];
			self.alpha = 0;
		}];
	}
}

- (void)timedHide
{
    dispatch_async(dispatch_get_main_queue(), ^{
        double length = self.label.text.length;
        NSTimeInterval sleep = length * 0.05 + 0.5;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sleep * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hudHide];
        });
    });
}

//-------------------===============自定义=============--------------------------------

- (void)hudMake2:(NSString *)status imgage:(UIImage *)img spin:(BOOL)spin hide:(BOOL)hide Width:(float)width High:(float)high
{
    
	[self hudCreate];
	self.label.text = status;
	
	[self hudOrient];
	[self hudWidth:width High:high withText:status];
    
	[self hudShow];
	if (hide) [NSThread detachNewThreadSelector:@selector(timedHide) toTarget:self withObject:nil];
}

// 设置弹出框宽高
- (void)hudWidth:(float)width High:(float)high withText:(NSString *)text
{
    CGRect labelRect = CGRectZero;
    if (self.label.text != nil)
    {
        NSDictionary *attributes = @{NSFontAttributeName:self.label.font};
        NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
        
        labelRect = [self.label.text boundingRectWithSize:CGSizeMake(260, 300) options:options attributes:attributes context:NULL];
        
        labelRect.origin.x = 6;
        labelRect.origin.y = 7;
        
        width = labelRect.size.width + 12;
        high =  labelRect.size.height + 14;
    }
    CGSize screen = [UIScreen mainScreen].bounds.size;
    hud.center = CGPointMake(screen.width/2, screen.height/2 + screen.height/4);
    hud.bounds = CGRectMake(0, 0, width, high);
    self.label.frame = labelRect;
    [self.hud addSubview:self.label];
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = HUD_STATUS_FONT;
        _label.textColor = HUD_STATUS_COLOR;
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
