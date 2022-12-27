#import <UIKit/UIKit.h>
@interface UIBarButtonItem (CJBarButtonItemCategory)
+(instancetype)itemWithNormalImage:(NSString *)normalImage highImage:(NSString *)highImage showsTouchWhenHighlighted:(BOOL)highlight didClick:(void (^)(UIControl *control))didClickBlock;
+(instancetype)backItemWithNormalImage:(NSString *)normalImage highImage:(NSString *)highImage backTitle:(NSString *)backTitle  backTitleNormalColor:(UIColor *)normalColor backTitleHighColor:(UIColor *)highColor  didClick:(void (^)(UIControl *control))didClickBlock;
@end
