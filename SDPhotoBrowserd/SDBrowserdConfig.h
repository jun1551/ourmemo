#ifndef SDBrowserdConfig_h
#define SDBrowserdConfig_h
typedef enum {
    SDWaitingViewModeLoopDiagram, 
    SDWaitingViewModePieDiagram 
} SDWaitingViewMode;
static NSString *const SDPhotoBrowserSaveImageText = @" 保存 ";
static NSString *const SDPhotoBrowserSaveImageSuccessText = @" 保存成功 ";
static NSString *const SDPhotoBrowserSaveImageFailText = @" 保存失败 ";
#define SDPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]
#define SDPhotoBrowserImageViewMargin 10
#define SDPhotoBrowserShowImageAnimationDuration 0.25f
#define SDPhotoBrowserHideImageAnimationDuration 0.25f
#define SDWaitingViewProgressMode SDWaitingViewModeLoopDiagram
#define SDWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
#define SDWaitingViewItemMargin 10
#endif 
