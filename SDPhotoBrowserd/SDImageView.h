#import <UIKit/UIKit.h>
#import "SDLoadingView.h"
@interface SDImageView : UIImageView<UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;
- (void)eliminateScale; 
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)doubleTapToZommWithScale:(CGFloat)scale;
- (void)clear;
@end
