#import "AppDelegate.h"
@interface AppDelegate (CJAutoSize)
-(CGFloat)autoRealHorizonSize:(CGFloat)estimateHorizonSize;
-(CGFloat)autoRealVerticalSize:(CGFloat)estimateVerticalSize;
-(CGFloat)autoRealSize:(CGFloat)estimateSize;
#define cjW(width) [(AppDelegate *)[UIApplication sharedApplication].delegate autoRealHorizonSize:width]
#define cjH(height) [(AppDelegate *)[UIApplication sharedApplication].delegate autoRealVerticalSize:height]
#define cjX(x) [(AppDelegate *)[UIApplication sharedApplication].delegate autoRealHorizonSize:x]
#define cjY(y) [(AppDelegate *)[UIApplication sharedApplication].delegate autoRealVerticalSize:y]
#define cjSize(size) [(AppDelegate *)[UIApplication sharedApplication].delegate autoRealSize:size]
@end
