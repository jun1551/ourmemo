#import "AppDelegate+CJAppDelegateCategory.h"
#define CJScreenWidth [UIScreen mainScreen].bounds.size.width
#define CJScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation AppDelegate (CJAutoSize)
static CGFloat horizonScale;
static CGFloat verticalScale;
-(CGFloat)autoRealHorizonSize:(CGFloat)estimateHorizonSize
{
    return estimateHorizonSize*horizonScale;
}
-(CGFloat)autoRealVerticalSize:(CGFloat)estimateVerticalSize
{
    return estimateVerticalSize*verticalScale;
}
-(CGFloat)autoRealSize:(CGFloat)estimateSize
{
    return estimateSize*(horizonScale+verticalScale)/2.0;
}
+(void)load
{
    horizonScale=CJScreenWidth/375;
    verticalScale=CJScreenHeight/667;
}
@end
