#import <objc/runtime.h>
#import "CJGlobal.h"
const CGFloat CJStatusBarHeight = 20;
const CGFloat CJNavigationBarHeight = 44;
const CGFloat CJTabBarHeight = 49;
@implementation NSObject (autoCreateProperty)
+(void)cjCreatePropertyWithDict:(NSDictionary *)dict
{
    NSMutableString *strM=[NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *code;
        if([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
        {
            code=[NSMutableString stringWithFormat:@"@property(nonatomic,assign)BOOL %@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")])
        {
            code=[NSMutableString stringWithFormat:@"@property(nonatomic,strong)NSNumber *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")])
        {
            code=[NSMutableString stringWithFormat:@"@property(nonatomic,strong)NSArray *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSTaggedDate")])
        {
            code=[NSMutableString stringWithFormat:@"@property(nonatomic,strong)NSDate *%@;",key];
        }
        else if([obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")])
        {
            code=[NSMutableString stringWithFormat:@"@property(nonatomic,strong)NSString *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")])
        {
            code=[NSMutableString stringWithFormat:@"@property(nonatomic,strong)NSDictionary *%@;",key];
        }
        [strM appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"\n%@\n",strM);
}
@end
@implementation NSObject (dictToModel)
+(instancetype)cjModelWithDict:(NSDictionary *)dict
{
    id obj=[[self alloc]init];
    unsigned int count;
    Ivar *ivarList=class_copyIvarList(self, &count);
    int i;
    for (i=0; i<count; i++){
        const char *ivarName=ivar_getName(ivarList[i]);
        const char *ivarType=ivar_getTypeEncoding(ivarList[i]);
        NSString *propertyName=[NSString stringWithUTF8String:ivarName];
        NSString *propertyType=[NSString stringWithUTF8String:ivarType];
        NSString *key=[propertyName substringFromIndex:1];
        id value=dict[key];
        if([value isKindOfClass:[NSDictionary class]] && ![propertyType isEqualToString:@"\"NSDictionary\""])
        {
            NSString *modelType=[propertyType substringWithRange:NSMakeRange(2, propertyType.length-3)];
            Class modelClass=NSClassFromString(modelType);
            if(modelClass)
            {
                value=[modelClass cjModelWithDict:value];
            }
        }
        if([value isKindOfClass:[NSArray class]])
        {
            if([self respondsToSelector:@selector(cjModelContainModelInArray)])
            {
                id idSelf=self;
                NSString *modelType=[idSelf cjModelContainModelInArray][key];
                Class modelClass=NSClassFromString(modelType);
                if(modelClass)
                {
                    NSMutableArray *arrM=[NSMutableArray array];
                    for (NSDictionary *dict in value)
                    {
                        id model=[modelClass cjModelWithDict:dict];
                        [arrM addObject:model];
                    }
                    value=arrM;
                }
            }
        }
        if(value)
        {
            [obj setValue:value forKey:key];
        }
    }
    return obj;
}
@end
@interface UIView (frameExtension)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@end
@implementation UIView (frameExtension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}
-(CGFloat)centerX
{
    return self.center.x;
}
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}
-(CGFloat)centerY
{
    return  self.center.y;
}
@end
@implementation UIView (didAddSubviewsExtension)
static char *didAddSubviewsKey="didAddSubviewsKey";
-(void)setCjDidAddSubviews:(void (^)(void))cjDidAddSubviews
{
    objc_setAssociatedObject(self, didAddSubviewsKey, cjDidAddSubviews, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void (^)(void))cjDidAddSubviews
{
    return objc_getAssociatedObject(self, didAddSubviewsKey);
}
+(void)load
{
    static dispatch_once_t one_token;
    dispatch_once(&one_token, ^{
        Method addSubviewMethod=class_getInstanceMethod(self,@selector(addSubview:));
        Method cjAddSubviewMethod=class_getInstanceMethod(self, @selector(cjAddSubview:));
        method_exchangeImplementations(addSubviewMethod, cjAddSubviewMethod);
    });
}
-(void)cjAddSubview:(UIView *)view
{
    [self cjAddSubview:view];
    if(self.cjDidAddSubviews)
    {
        self.cjDidAddSubviews();
    }
}
@end
@implementation CJProgressView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor clearColor];
        self.foregroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 3)];
        self.foregroundView.backgroundColor=[UIColor yellowColor];
        [self addSubview:self.foregroundView];
    }
    return self;
}
-(void)setCjProgressViewColor:(UIColor *)cjProgressViewColor
{
    self.foregroundView.backgroundColor=cjProgressViewColor;
}
-(UIColor *)cjProgressViewColor
{
    return self.foregroundView.backgroundColor;
}
-(void)cjStartLoading
{
    __weak typeof(self) weakSelf=self;
    __weak typeof(self.superview) weakSuperview=self.superview;
    self.superview.cjDidAddSubviews=^(){
        [weakSuperview bringSubviewToFront:weakSelf];
    };
    self.foregroundView.width=0;
    self.hidden=NO;
    [UIView animateWithDuration:10 delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        weakSelf.foregroundView.width=0.8*CJScreenWidth;
    } completion:nil];
}
-(void)cjEndLoading
{
    [UIView animateWithDuration:0.5 animations:^{
        self.foregroundView.width=CJScreenWidth;
    }completion:^(BOOL finished) {
        self.hidden=YES;
    }];
}
@end
@implementation CALayer (CornerRadius)
-(instancetype)CJSetLayerMasksToBoundsToYES
{
    self.masksToBounds=YES;
    return self;
}
@end
@implementation UIGestureRecognizer (gesBlock)
static const char *gesBlockKey="gesBlockKey";
+(instancetype)cjGestureRecognizer:(void (^)(UIGestureRecognizer *))gesBlock
{
    return [[self alloc]initWithCjGestureRecognizer:gesBlock];
}
-(instancetype)initWithCjGestureRecognizer:(void (^)(UIGestureRecognizer *))gesBlock
{
    self=[self init];
    self.block=gesBlock;
    [self addTarget:self action:@selector(gestureFunc:)];
    return self;
}
-(void)gestureFunc:(UIGestureRecognizer *)gesture
{
    self.block(gesture);
}
-(void)setBlock:(void (^)(UIGestureRecognizer *))block
{
    objc_setAssociatedObject(self, gesBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void (^)(UIGestureRecognizer *))block
{
    return objc_getAssociatedObject(self, gesBlockKey);
}
@end
