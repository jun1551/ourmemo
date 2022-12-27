#import<UIKit/UIKit.h>
#pragma -mark  获取statusBar、navigationBar、tabBar的高度
UIKIT_EXTERN const CGFloat CJStatusBarHeight;
UIKIT_EXTERN const CGFloat CJNavigationBarHeight;
UIKIT_EXTERN const CGFloat CJTabBarHeight;
@interface NSObject (autoCreateProperty)
+(void)cjCreatePropertyWithDict:(NSDictionary *)dict;
@end
@protocol cjModelDelegate <NSObject>
@optional
+(NSDictionary *)cjModelContainModelInArray;
@end
@interface NSObject (dictToModel)<cjModelDelegate>
+(instancetype)cjModelWithDict:(NSDictionary *)dict;
@end
@interface UIView (didAddSubviewsExtension)
@property(nonatomic,copy)void (^cjDidAddSubviews)(void);
@end
@interface CJProgressView : UIView
@property(nonatomic,strong)UIView * foregroundView;
@property(nonatomic,strong)UIColor *cjProgressViewColor;
-(void)cjStartLoading;
-(void)cjEndLoading;
@end
@interface CALayer(CornerRadius)
-(instancetype)CJSetLayerMasksToBoundsToYES;
@end
@interface UIGestureRecognizer (gesBlock)
@property(nonatomic,copy)void (^block)(UIGestureRecognizer *gesture);
-(instancetype)initWithCjGestureRecognizer:(void (^)(UIGestureRecognizer *gesture))gesBlock;
+(instancetype)cjGestureRecognizer:(void (^)(UIGestureRecognizer *gesture))gesBlock;
@end
#ifndef CJGlobal_h
#define CJGlobal_h
#pragma -mark  获取当前屏幕的尺寸
#define CJScreenWidth [UIScreen mainScreen].bounds.size.width
#define CJScreenHeight [UIScreen mainScreen].bounds.size.height
#pragma -mark  获取当前的AppDeletegate单例
#define CJAppDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate;
#pragma -mark 获取沙盒路径
#define CJDocumentPath  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define CJLibraryPath  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)firstObject]
#define CJCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject]
#define CJTempPath NSTemporaryDirectory()
#define CJSetUserDefaults(keyArray,valueArray)\
do{\
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];\
    for(int i=0;i<keyArray.count;i++)\
    {\
        [userDefaults setObject:valueArray[i] forKey:keyArray[i]];\
    }\
    [userDefaults synchronize];\
}while(0)
#define CJGetUserDefaults(keyArray)\
({\
    NSMutableArray *valueArray=[NSMutableArray array];\
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];\
    for(NSString *key in keyArray)\
    {\
        [valueArray addObject:[userDefaults objectForKey:key]];\
    }\
    valueArray;\
})
#pragma -mark 定义weakSelf和strongSelf变量
#define CJWeak(object) __weak __typeof(&*object) weak##object = object;
#define CJStrong(object) __strong __typeof(&*object) strong##object = object;
#pragma -mark 生成颜色
#define CJRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
#define CJRGBAColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a];
#define CJRGBColor(r, g, b)  CJRGBAColor(r, g, b,1.0)
#define CJColorFromHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#pragma -mark 自定义NSLog
#if DEBUG
#define CJLog(formater,...)  NSLog(formater,##__VA_ARGS__)
#define CJLogFrame(view)  do{\
CGRect frame=view.frame;\
NSLog(@"{x=%f,y=%f,w=%f,h=%f}",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);\
}while(0)
#else
#define CJLog(formater,...)
#define CJLogFrame(view)
#endif
#pragma -mark   设置圆角
#define CJCornerRadius(view)\
[view.layer CJSetLayerMasksToBoundsToYES].cornerRadius
#pragma -mark 获取图片名称
#define CJGetImage(formater,...)   [UIImage imageNamed:[NSString stringWithFormat:formater,##__VA_ARGS__]]
#endif 
