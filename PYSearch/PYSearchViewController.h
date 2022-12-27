#import <UIKit/UIKit.h>
#import "PYSearchConst.h"
@class PYSearchViewController, PYSearchSuggestionViewController;
typedef void(^PYDidSearchBlock)(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText);
typedef NS_ENUM(NSInteger, PYHotSearchStyle)  {
    PYHotSearchStyleNormalTag,      
    PYHotSearchStyleColorfulTag,    
    PYHotSearchStyleBorderTag,      
    PYHotSearchStyleARCBorderTag,   
    PYHotSearchStyleRankTag,        
    PYHotSearchStyleRectangleTag,   
    PYHotSearchStyleDefault = PYHotSearchStyleNormalTag 
};
typedef NS_ENUM(NSInteger, PYSearchHistoryStyle) {
    PYSearchHistoryStyleCell,           
    PYSearchHistoryStyleNormalTag,      
    PYSearchHistoryStyleColorfulTag,    
    PYSearchHistoryStyleBorderTag,      
    PYSearchHistoryStyleARCBorderTag,   
    PYSearchHistoryStyleDefault = PYSearchHistoryStyleCell 
};
typedef NS_ENUM(NSInteger, PYSearchResultShowMode) {
    PYSearchResultShowModeCustom,   
    PYSearchResultShowModePush,     
    PYSearchResultShowModeEmbed,    
    PYSearchResultShowModeDefault = PYSearchResultShowModeCustom 
};
typedef NS_ENUM(NSInteger, PYSearchViewControllerShowMode) {
    PYSearchViewControllerShowModeModal,    
    PYSearchViewControllerShowModePush,   
    PYSearchViewControllerShowDefault = PYSearchViewControllerShowModeModal 
};
@protocol PYSearchViewControllerDataSource <NSObject>
@optional
- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView;
- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@protocol PYSearchViewControllerDelegate <NSObject, UITableViewDelegate>
@optional
- (void)searchViewController:(PYSearchViewController *)searchViewController
      didSearchWithSearchBar:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText;
- (void)searchViewController:(PYSearchViewController *)searchViewController
   didSelectHotSearchAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText;
- (void)searchViewController:(PYSearchViewController *)searchViewController
didSelectSearchHistoryAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText;
- (void)searchViewController:(PYSearchViewController *)searchViewController
didSelectSearchSuggestionAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText PYSEARCH_DEPRECATED("Use searchViewController:didSelectSearchSuggestionAtIndexPath:searchText:");
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)indexPath
                   searchBar:(UISearchBar *)searchBar;
- (void)searchViewController:(PYSearchViewController *)searchViewController
         searchTextDidChange:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText;
- (void)didClickCancel:(PYSearchViewController *)searchViewController;
- (void)didClickBack:(PYSearchViewController *)searchViewController;
@end
@interface PYSearchViewController : UIViewController
@property (nonatomic, weak) id<PYSearchViewControllerDelegate> delegate;
@property (nonatomic, weak) id<PYSearchViewControllerDataSource> dataSource;
@property (nonatomic, strong) NSArray<NSString *> *rankTagBackgroundColorHexStrings;
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorPol;
@property (nonatomic, assign) BOOL swapHotSeachWithSearchHistory;
@property (nonatomic, copy) NSArray<NSString *> *hotSearches;
@property (nonatomic, copy) NSArray<UILabel *> *hotSearchTags;
@property (nonatomic, weak) UILabel *hotSearchHeader;
@property (nonatomic, assign) BOOL showHotSearch;
@property (nonatomic, copy) NSString *hotSearchTitle;
@property (nonatomic, copy) NSArray<UILabel *> *searchHistoryTags;
@property (nonatomic, weak) UILabel *searchHistoryHeader;
@property (nonatomic, copy) NSString *searchHistoryTitle;
@property (nonatomic, assign) BOOL showSearchHistory;
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
@property (nonatomic, assign) NSUInteger searchHistoriesCount;
@property (nonatomic, assign) BOOL removeSpaceOnSearchString;
@property (nonatomic, weak) UIButton *emptyButton;
@property (nonatomic, weak) UILabel *emptySearchHistoryLabel;
@property (nonatomic, assign) PYHotSearchStyle hotSearchStyle;
@property (nonatomic, assign) PYSearchHistoryStyle searchHistoryStyle;
@property (nonatomic, assign) PYSearchResultShowMode searchResultShowMode;
@property (nonatomic, assign) PYSearchViewControllerShowMode searchViewControllerShowMode;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITextField *searchTextField;
@property (nonatomic, strong) UIColor *searchBarBackgroundColor;
@property (nonatomic, assign) CGFloat searchBarCornerRadius;
@property (nonatomic, strong) UIBarButtonItem *cancelBarButtonItem;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak, readonly) UITableView *searchSuggestionView;
@property (nonatomic, copy) PYDidSearchBlock didSearchBlock;
@property (nonatomic, copy) NSArray<NSString *> *searchSuggestions;
@property (nonatomic, assign) BOOL searchSuggestionHidden;
@property (nonatomic, strong) UIViewController *searchResultController;
@property (nonatomic, assign) BOOL showSearchResultWhenSearchTextChanged;
@property (nonatomic, assign) BOOL showSearchResultWhenSearchBarRefocused;
@property (nonatomic, assign) BOOL showKeyboardWhenReturnSearchResult;
+ (instancetype)searchViewControllerWithHotSearches:(NSArray<NSString *> *)hotSearches
                               searchBarPlaceholder:(NSString *)placeholder;
+ (instancetype)searchViewControllerWithHotSearches:(NSArray<NSString *> *)hotSearches
                               searchBarPlaceholder:(NSString *)placeholder
                                     didSearchBlock:(PYDidSearchBlock)block;
@end
