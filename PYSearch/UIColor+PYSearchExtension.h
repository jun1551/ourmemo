#import <UIKit/UIKit.h>
@interface UIColor (PYSearchExtension)
+ (instancetype)py_colorWithHexString:(NSString *)hexString;
+ (instancetype)py_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
