//--Preferences Variables--//
BOOL enabled;

BOOL doubleTapModeEnabled;
BOOL heartTapModeEnabled;

int alertStyle;

BOOL alwaysAlert;
int minimumTakenAtTime;

//--Interface Declarations--//
@interface IGUser
@property NSString *username;
@end

@interface IGDate
@property NSDate *date;
@end

@interface IGFeedItem
@property IGUser *user;
@property IGDate *takenAtDate;
@property BOOL hasLiked;
@end

@interface IGFeedItemPhotoCell
@property UIViewController *viewController;
- (IGFeedItem *)mediaCellFeedItem;
@end

@interface IGFeedItemVideoCell
@property UIViewController *viewController;
- (IGFeedItem *)mediaCellFeedItem;
@end

@interface IGFeedItemPageCell
@property UIViewController *viewController;
- (IGFeedItem *)mediaCellFeedItem;
@end

@interface IGFeedSelectionController
@property IGFeedItem *feedItem;
@end

@interface IGFeedItemUFICell
@property IGFeedSelectionController *delegate;
@property UIViewController *viewController;
@end