#import "UIBarButtonItem+CJCategory.h"
#import "UIButton+CJCategory.h"
#import "UIControl+CJCategory.h"
@implementation UIBarButtonItem (CJBarButtonItemCategory)
+(instancetype)itemWithNormalImage:(NSString *)normalImage highImage:(NSString *)highImage showsTouchWhenHighlighted:(BOOL)highlight didClick:(void (^)(UIControl *control))didClickBlock
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn cjRespondTargetForControlEvents:UIControlEventTouchUpInside actionBlock:didClickBlock];
    btn.showsTouchWhenHighlighted=highlight;
    [btn sizeToFit];
    return [[self alloc]initWithCustomView:btn];
}
+(instancetype)backItemWithNormalImage:(NSString *)normalImage highImage:(NSString *)highImage backTitle:(NSString *)backTitle  backTitleNormalColor:(UIColor *)normalColor backTitleHighColor:(UIColor *)highColor  didClick:(void (^)(UIControl *control))didClickBlock
{
    UIButton *backBtn=[[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [backBtn setTitle:backTitle forState:UIControlStateNormal];
    [backBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [backBtn setTitleColor:highColor forState:UIControlStateHighlighted];
    backBtn.cj_width = 40;
    backBtn.cj_height = 25;
    [backBtn cjRespondTargetForControlEvents:UIControlEventTouchUpInside actionBlock:didClickBlock];
    backBtn.contentEdgeInsets=UIEdgeInsetsMake(0, -40, 0, 0);
    return [[self alloc]initWithCustomView:backBtn];
}
@end
