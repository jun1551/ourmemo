#import "NSDate+CJDateCategory.h"
@implementation NSDate (CJDateComponents)
@dynamic cjDaysInYear;
@dynamic cjDaysInMonth;
@dynamic cjDateComponents;
@dynamic cjFirstWeekdayInMonth;
@dynamic cjWeekday;
-(NSDateComponents *)cjDateComponents
{
    NSCalendar *greCal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [greCal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:self];
}
-(NSUInteger)cjDaysInMonth
{
    NSCalendar *greCal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range=[greCal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}
-(NSUInteger)cjDaysInYear
{
    NSCalendar *greCal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range=[greCal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    return range.length;
}
-(NSUInteger)cjFirstWeekdayInMonth
{
    NSCalendar *greCal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents=[greCal components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date =[dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-01",dateComponents.year,dateComponents.month]];
    return [greCal component:NSCalendarUnitWeekday fromDate:date];
}
-(NSUInteger)cjWeekday
{
    NSCalendar *greCal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [greCal component:NSCalendarUnitWeekday fromDate:self];
}
+(NSString *)cjDateSince1970WithSecs:(NSString *)secs formatter:(NSString *)formatter{
    NSDate *date;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    date = [NSDate dateWithTimeIntervalSince1970:[secs integerValue]];
    [dateformatter setDateFormat:formatter];
    return [dateformatter stringFromDate:date];
}
@end
