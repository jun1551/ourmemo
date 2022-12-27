#import "UIButton+CJCategory.h"
#import "UIView+CJViewExtension.h"
#import <objc/runtime.h>
@implementation UIButton (positionStyle)
static const char *positionStyleKey="positionStyleKey";
static const char *spaceKey="spaceKey";
-(void)setCjPositionStyle:(CJButtonPositionStyle)cjPositionStyle
{
    objc_setAssociatedObject(self, positionStyleKey, @(cjPositionStyle), OBJC_ASSOCIATION_ASSIGN);
    self.imageView.backgroundColor=[UIColor clearColor];
    CGFloat leftMove=self.titleLabel.cj_centerX-self.cj_width/2;
    CGFloat rightMove=self.cj_centerX-self.cj_x-self.imageView.cj_centerX;
    CGFloat upMove=self.imageView.cj_height/2;
    CGFloat downMove=self.titleLabel.cj_height/2;
    switch (cjPositionStyle)
    {
        case CJButtonPositionLeftImageRightTitle://左图右title
        {
            break;
        }
        case CJButtonPositionLeftTitleRightImage://左title右图
        {
            CGFloat leftMove=self.imageView.cj_width;
            CGFloat rightMove=self.titleLabel.cj_width;
            self.titleEdgeInsets=UIEdgeInsetsMake(0, 0-leftMove, 0, 0+leftMove);
            self.imageEdgeInsets=UIEdgeInsetsMake(0, 0+rightMove, 0, 0-rightMove);
            break;
        }
        case CJButtonPositionTopImageBottomTitle://上图下title
        {
            self.titleEdgeInsets=UIEdgeInsetsMake(0+upMove, 0-leftMove, 0-upMove, 0+leftMove);
            self.imageEdgeInsets=UIEdgeInsetsMake(0-downMove,0+rightMove,0+downMove,0-rightMove);
            break;
        }
        case CJButtonPositionTopTitleBottomImage://上title下图
        {
            self.titleEdgeInsets=UIEdgeInsetsMake(0-upMove, 0-leftMove, 0+upMove, 0+leftMove);
            self.imageEdgeInsets=UIEdgeInsetsMake(0+downMove,0+rightMove,0-downMove,0-rightMove);
            break;
        }
        case CJButtonPositionCenter://中间位置
        {
            self.titleEdgeInsets=UIEdgeInsetsMake(0, 0-leftMove, 0, 0+leftMove);
            self.imageEdgeInsets=UIEdgeInsetsMake(0,0+rightMove,0,0-rightMove);
            break;
        }
        default:
            break;
    }
}
-(CJButtonPositionStyle)cjPositionStyle
{
    return [objc_getAssociatedObject(self, positionStyleKey) integerValue];
}
-(void)setCjSpace:(CGFloat)cjSpace
{
    objc_setAssociatedObject(self, spaceKey, @(cjSpace), OBJC_ASSOCIATION_ASSIGN);
    UIEdgeInsets titleEdgeInsets=self.titleEdgeInsets;
    UIEdgeInsets imageEdgeInsets=self.imageEdgeInsets;
    CJButtonPositionStyle positionStyle=(CJButtonPositionStyle)self.cjPositionStyle;
    switch (positionStyle)
    {
        case CJButtonPositionLeftImageRightTitle:
            self.imageEdgeInsets=UIEdgeInsetsMake(0, 0-cjSpace, 0, 0+cjSpace);
            self.titleEdgeInsets=UIEdgeInsetsMake(0, 0+cjSpace, 0, 0-cjSpace);
            break;
        case CJButtonPositionLeftTitleRightImage:
            self.imageEdgeInsets=UIEdgeInsetsMake(0, imageEdgeInsets.left+cjSpace, 0, imageEdgeInsets.right-cjSpace);
            self.titleEdgeInsets=UIEdgeInsetsMake(0, titleEdgeInsets.left-cjSpace,0,titleEdgeInsets.right+cjSpace);
            break;
        case CJButtonPositionTopImageBottomTitle:
            NSLog(@"CJButtonPositionTopImageBottomTitle");
            self.imageEdgeInsets=UIEdgeInsetsMake(imageEdgeInsets.top-cjSpace,imageEdgeInsets.left,imageEdgeInsets.bottom+cjSpace,imageEdgeInsets.right);
            self.titleEdgeInsets=UIEdgeInsetsMake(titleEdgeInsets.top+cjSpace, titleEdgeInsets.left,titleEdgeInsets.bottom-cjSpace,titleEdgeInsets.right);
            break;
        case CJButtonPositionTopTitleBottomImage:
            self.imageEdgeInsets=UIEdgeInsetsMake(imageEdgeInsets.top+cjSpace,imageEdgeInsets.left,imageEdgeInsets.bottom-cjSpace,imageEdgeInsets.right);
            self.titleEdgeInsets=UIEdgeInsetsMake(titleEdgeInsets.top-cjSpace, titleEdgeInsets.left,titleEdgeInsets.bottom+cjSpace,titleEdgeInsets.right);
            break;
        case CJButtonPositionCenter:
            break;
        default:
            break;
    }
}
-(CGFloat)cjSpace
{
    return [objc_getAssociatedObject(self, positionStyleKey) floatValue];
}
@end
