#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CJButtonPositionStyle)
{
    CJButtonPositionLeftImageRightTitle=0,
    CJButtonPositionLeftTitleRightImage,
    CJButtonPositionTopImageBottomTitle,
    CJButtonPositionTopTitleBottomImage,
    CJButtonPositionCenter,
};
@interface UIButton (positionStyle)
@property(nonatomic,assign)CJButtonPositionStyle cjPositionStyle;
@property(nonatomic,assign)CGFloat cjSpace;
@end
