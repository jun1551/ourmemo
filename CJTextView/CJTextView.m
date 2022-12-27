#import "CJTextView.h"
@interface CJTextView ()
@property (nonatomic, strong) UILabel * placeHolderLabel;
@end
@implementation CJTextView
-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)textDidChanged
{
    [self setNeedsDisplay];
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=[placeholder copy];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    if (self.hasText) {
        [self viewWithTag:888].hidden = YES;
        return;
    }
    if (self.placeholder.length > 0) {
        if (_placeHolderLabel == nil) {
            _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, self.bounds.size.width - 16, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.tag = 888;
            _placeHolderLabel.textColor = [UIColor grayColor];
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    if (self.text.length == 0 && self.placeholder.length>0) {
        [self viewWithTag:888].hidden = NO; 
    }
}
@end
