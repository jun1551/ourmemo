#import "NSBundle+PYSearchExtension.h"
#import "PYSearchViewController.h"
@implementation NSBundle (PYSearchExtension)
+ (NSBundle *)py_searchBundle
{
    static NSBundle *searchBundle = nil;
    if (nil == searchBundle) {
        searchBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"PYSearch" ofType:@"bundle"]];
        if (nil == searchBundle) { 
            searchBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[PYSearchViewController class]] pathForResource:@"PYSearch" ofType:@"bundle"]];
        }
    }
    return searchBundle;
}
+ (NSString *)py_localizedStringForKey:(NSString *)key;
{
    return [self py_localizedStringForKey:key value:nil];
}
+ (NSString *)py_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    static NSBundle *bundle = nil;
    if (nil == bundle) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) language = @"en";
        else if ([language hasPrefix:@"es"]) language = @"es";
        else if ([language hasPrefix:@"fr"]) language = @"fr";
        else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans";
            } else {
                language = @"zh-Hant";
            }
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle py_searchBundle] pathForResource:language ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
+ (UIImage *)py_imageNamed:(NSString *)name
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    name = 3.0 == scale ? [NSString stringWithFormat:@"%@@3x.png", name] : [NSString stringWithFormat:@"%@@2x.png", name];
    UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle py_searchBundle] resourcePath] stringByAppendingPathComponent:name]];
    return image;
}
@end
