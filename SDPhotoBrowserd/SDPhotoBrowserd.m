#import "SDPhotoBrowserd.h"
#import "UIImageView+WebCache.h"
#import "SDImageView.h"
#import "SDBrowserdConfig.h"
@interface SDPhotoBrowserd ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *scourceView;
@property (nonatomic, strong) UIView *recordView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@end
@implementation SDPhotoBrowserd {
    UIScrollView *_scrollView;  
    BOOL _hasShowedFistView;
    UILabel *_indexLabel;
    UIActivityIndicatorView *_indicatorView;
    BOOL _willDisappear;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)didMoveToSuperview {
    [self setupScrollView];
    [self setupCountLabel];
    [self addSaveBtn];
}
-(void)addSaveBtn{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-20);
        make.width.height.mas_equalTo(25);
    }];
    CJCornerRadius(v) = 5;
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"保存白"]];
    [v addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(v);
        make.width.height.mas_equalTo(15);
    }];
    v.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage)];
    [v addGestureRecognizer:tap];
}
- (void)dealloc {
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}
- (void)setupCountLabel {
    if (self.imageCount > 1) {
        UILabel *indexLabel = [[UILabel alloc] init];
        indexLabel.bounds = CGRectMake(0, 0, 80, 30);
        indexLabel.textAlignment = NSTextAlignmentCenter;
        indexLabel.textColor = [UIColor whiteColor];
        indexLabel.font = [UIFont boldSystemFontOfSize:20];
        indexLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        indexLabel.layer.cornerRadius = indexLabel.bounds.size.height * 0.5;
        indexLabel.clipsToBounds = YES;
        indexLabel.text = [NSString stringWithFormat:@"1/%ld", (long)self.imageCount];
        _indexLabel = indexLabel;
        [self addSubview:indexLabel];
    }
}
- (void)saveImage {
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    UIImageView *currentImageView = _scrollView.subviews[index];
    UIImageWriteToSavedPhotosAlbum(currentImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error){
        [CJProgressHUD cjShowErrorWithPosition:CJProgressHUDPositionBothExist withText:@"保存失败"];
        return;
    }
    [CJProgressHUD cjShowSuccessWithPosition:CJProgressHUDPositionBothExist withText:@"保存成功"];
}
- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc] init];
    UIVisualEffectView *toolbar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [self addSubview:toolbar];
    CJWeak(self)
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(weakself);
    }];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    for (int i = 0; i < self.imageCount; i++) {
        SDImageView *imageView = [[SDImageView alloc] init];
        imageView.tag = i;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
        doubleTap.numberOfTapsRequired = 2;
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        [_scrollView addSubview:imageView];
    }
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
}
- (void)setupImageOfImageViewForIndex:(NSInteger)index {
    if (index > self.imageCount-1) return;
    SDImageView *imageView = _scrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) return;
    if ([self highQualityImageURLForIndex:index]) {
        [imageView setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
    } else {
        imageView.image = [self placeholderImageForIndex:index];
    }
    imageView.hasLoadedImage = YES;
}
- (void)photoClick:(UITapGestureRecognizer *)recognizer {
    _scrollView.hidden = YES;
    _willDisappear = YES;
    SDImageView *currentImageView = (SDImageView *)recognizer.view;
    NSInteger currentIndex = currentImageView.tag;
    UIView *sourceView = nil;
    if ([self.sourceImagesContainerView isKindOfClass:UICollectionView.class]) {
        UICollectionView *view = (UICollectionView *)self.sourceImagesContainerView;
        NSIndexPath *path = [NSIndexPath indexPathForItem:currentIndex inSection:0];
        sourceView = [view cellForItemAtIndexPath:path];
    } else {
        sourceView = self.scourceView;
    }
    self.recordView = sourceView;
    CGRect targetTemp = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.contentMode = sourceView.contentMode;
    tempView.clipsToBounds = YES;
    tempView.image = currentImageView.image;
    CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;
    if (!currentImageView.image) { 
        h = self.bounds.size.height;
    }
    tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
    tempView.center = self.center;
    [self addSubview:tempView];
    if (self.recordView == self.scourceView) {
        [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else{
        [UIView animateWithDuration:SDPhotoBrowserHideImageAnimationDuration animations:^{
            tempView.frame = targetTemp;
            self.backgroundColor = [UIColor clearColor];
            _indexLabel.alpha = 0.1;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}
- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer {
    SDImageView *imageView = (SDImageView *)recognizer.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    SDImageView *view = (SDImageView *)recognizer.view;
    [view doubleTapToZommWithScale:scale];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.bounds;
    rect.size.width += SDPhotoBrowserImageViewMargin * 2;
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    CGFloat y = 0;
    CGFloat w = _scrollView.frame.size.width - SDPhotoBrowserImageViewMargin * 2;
    CGFloat h = _scrollView.frame.size.height;
    [_scrollView.subviews enumerateObjectsUsingBlock:^(SDImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = SDPhotoBrowserImageViewMargin + idx * (SDPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    if (!_hasShowedFistView) {
        [self showFirstImage];
    }
    _indexLabel.center = CGPointMake(self.bounds.size.width * 0.5, 50);
}
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    self.alpha = 0;
    [window addSubview:self];
    [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
        self.alpha = 1;
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
        SDImageView *currentImageView = _scrollView.subviews[_currentImageIndex];
        if ([currentImageView isKindOfClass:[SDImageView class]]) {
            [currentImageView clear];
        }
    }
}
- (void)showFirstImage {
    UIView *sourceView = nil;
    if ([self.sourceImagesContainerView isKindOfClass:UICollectionView.class]) {
        UICollectionView *view = (UICollectionView *)self.sourceImagesContainerView;
        NSIndexPath *path = [NSIndexPath indexPathForItem:self.currentImageIndex inSection:0];
        sourceView = [view cellForItemAtIndexPath:path];
    } else {
        sourceView = self.scourceView;
    }
    self.recordView = sourceView;
    CGRect rect = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
    [self addSubview:tempView];
    CGRect targetTemp = [_scrollView.subviews[self.currentImageIndex] bounds];
    tempView.frame = rect;
    tempView.contentMode = [_scrollView.subviews[self.currentImageIndex] contentMode];
    _scrollView.hidden = YES;
    [UIView animateWithDuration:SDPhotoBrowserShowImageAnimationDuration animations:^{
        tempView.center = self.center;
        tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
    } completion:^(BOOL finished) {
        _hasShowedFistView = YES;
        [tempView removeFromSuperview];
        _scrollView.hidden = NO;
    }];
}
- (UIImage *)placeholderImageForIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }
    return nil;
}
- (NSURL *)highQualityImageURLForIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
    }
    return nil;
}
#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    CGFloat margin = 150;
    CGFloat x = scrollView.contentOffset.x;
    if ((x - index * self.bounds.size.width) > margin || (x - index * self.bounds.size.width) < - margin) {
        if (index > self.imageCount - 1) return;
        SDImageView *imageView = _scrollView.subviews[index];
        if (imageView.isScaled) {
            [UIView animateWithDuration:0.5 animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [imageView eliminateScale];
            }];
        }
    }
    if (!_willDisappear) {
        _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1, (long)self.imageCount];
    }
    [self setupImageOfImageViewForIndex:index];
}
- (UIView *)scourceView {
    if (!_scourceView) {
        _scourceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        _scourceView.center = self.center;
    }
    return _scourceView;
}
@end
