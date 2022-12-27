#import "UIView+CJViewExtension.h"
@implementation UIView (CJViewExtension)
- (void)setCj_x:(CGFloat)cj_x
{
    CGRect frame = self.frame;
    frame.origin.x = cj_x;
    self.frame = frame;
}
- (CGFloat)cj_x
{
    return self.frame.origin.x;
}
- (void)setCj_y:(CGFloat)cj_y
{
    CGRect frame = self.frame;
    frame.origin.y = cj_y;
    self.frame = frame;
}
- (CGFloat)cj_y
{
    return self.frame.origin.y;
}
- (void)setCj_width:(CGFloat)cj_width
{
    CGRect frame = self.frame;
    frame.size.width = cj_width;
    self.frame = frame;
}
- (CGFloat)cj_width
{
    return self.frame.size.width;
}
- (void)setCj_height:(CGFloat)cj_height
{
    CGRect frame = self.frame;
    frame.size.height = cj_height;
    self.frame = frame;
}
- (CGFloat)cj_height
{
    return self.frame.size.height;
}
- (void)setCj_size:(CGSize)cj_size
{
    CGRect frame = self.frame;
    frame.size = cj_size;
    self.frame = frame;
}
- (CGSize)cj_size
{
    return self.frame.size;
}
- (void)setCj_origin:(CGPoint)cj_origin
{
    CGRect frame = self.frame;
    frame.origin = cj_origin;
    self.frame = frame;
}
- (CGPoint)cj_origin
{
    return self.frame.origin;
}
-(void)setCj_centerX:(CGFloat)cj_centerX
{
    CGPoint center=self.center;
    center.x=cj_centerX;
    self.center=center;
}
-(CGFloat)cj_centerX
{
    return self.center.x;
}
-(void)setCj_centerY:(CGFloat)cj_centerY
{
    CGPoint center=self.center;
    center.y=cj_centerY;
    self.center=center;
}
-(CGFloat)cj_centerY
{
    return  self.center.y;
}
-(void)setCj_maxY:(CGFloat)cj_maxY{
    self.cj_y = cj_maxY - self.cj_height;
}
-(void)setCj_maxX:(CGFloat)cj_maxX{
    self.cj_x = cj_maxX - self.cj_width;
}
-(CGFloat)cj_maxY
{
    return CGRectGetMaxY(self.frame);
}
-(CGFloat)cj_maxX
{
    return CGRectGetMaxX(self.frame);
}
-(CGPoint)cj_center{
    return CGPointMake(self.cj_centerX, self.cj_centerX);
}
-(void)setCj_center:(CGPoint)cj_center{
    self.cj_centerX = cj_center.x;
    self.cj_centerY = cj_center.y;
}
@end
