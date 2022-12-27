#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSBundle (PYSearchExtension)
+ (NSString *)py_localizedStringForKey:(NSString *)key;
+ (NSBundle *)py_searchBundle;
+ (UIImage *)py_imageNamed:(NSString *)name;
@end
