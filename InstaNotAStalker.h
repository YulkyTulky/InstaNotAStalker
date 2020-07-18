#import <UIKit/UIKit.h>

//--Preferences Variables--//
BOOL enabled;

BOOL doubleTapModeEnabled;
BOOL heartTapModeEnabled;
BOOL followModeEnabled;

int alertStyle;

BOOL alwaysAlert;
float minimumTakenAtTime;
int timeMultiplier;

//--Interface Declarations--//
@interface UIView (Instagram)
@property UIViewController *viewController;
@end

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

@interface IGFeedItemPhotoCell: UIView
- (IGFeedItem *)mediaCellFeedItem;
@end

@interface IGFeedItemVideoCell: UIView
- (IGFeedItem *)mediaCellFeedItem;
@end

@interface IGFeedItemPageCell: UIView
- (IGFeedItem *)mediaCellFeedItem;
@end

@interface IGFeedSelectionController
@property IGFeedItem *feedItem;
@end

@interface IGFeedItemUFICell: UIView
@property IGFeedSelectionController *delegate;
@end

@interface IGFollowButton: UIView
@property NSInteger buttonState;
@end

@interface IGFollowController
@property IGUser *user;
@property IGFollowButton *followAccountButton;
@end