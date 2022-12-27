#import <Foundation/Foundation.h>
@interface NSDate (CJDateComponents)
@property(nonatomic,strong) NSDateComponents *cjDateComponents;
@property(nonatomic,assign) NSUInteger cjDaysInMonth;
@property(nonatomic,assign) NSUInteger cjDaysInYear;
@property(nonatomic,assign)NSUInteger cjFirstWeekdayInMonth;
@property(nonatomic,assign)NSUInteger cjWeekday;
+(NSString *)cjDateSince1970WithSecs:(id)secs formatter:(NSString *)formatter;
@end
