#import <UIKit/UIKit.h>
@interface UIControl (didRespondTarget)
@property(nonatomic,strong)NSMutableDictionary *dictM;
-(void)cjRespondTargetForControlEvents:(UIControlEvents)events actionBlock:(void (^)(UIControl *control))block;
@end
