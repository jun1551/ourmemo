#import <UIKit/UIKit.h>
typedef void(^PYSearchSuggestionDidSelectCellBlock)(UITableViewCell *selectedCell);
@protocol PYSearchSuggestionViewDataSource <NSObject, UITableViewDataSource>
@required
- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section;
@optional
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView;
- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface PYSearchSuggestionViewController : UITableViewController
@property (nonatomic, weak) id<PYSearchSuggestionViewDataSource> dataSource;
@property (nonatomic, copy) NSArray<NSString *> *searchSuggestions;
@property (nonatomic, copy) PYSearchSuggestionDidSelectCellBlock didSelectCellBlock;
+ (instancetype)searchSuggestionViewControllerWithDidSelectCellBlock:(PYSearchSuggestionDidSelectCellBlock)didSelectCellBlock;
@end
