#import "InstaNotAStalker.h"

%hook IGFeedItemPhotoCell

- (void)feedPhotoDidDoubleTapToLike:(id)arg1 locationInfo:(id)arg2 {

	NSString *username = [[[self mediaCellFeedItem] user] username];
	NSString *title = [NSString stringWithFormat:@"Like %@'s Post?", username];
	NSDate *now = [NSDate date];
	NSDate *takenAtDate = [[[self mediaCellFeedItem] takenAtDate] date];

	if (([now timeIntervalSinceDate:takenAtDate] > minimumTakenAtTime || alwaysAlert) && doubleTapModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like photo
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like photo
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[self viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end

%hook IGFeedItemVideoCell

- (void)didDoubleTapFeedItemVideoView:(id)arg1 {

	NSString *username = [[[self mediaCellFeedItem] user] username];
	NSString *title = [NSString stringWithFormat:@"Like %@'s Post?", username];
	NSDate *now = [NSDate date];
	NSDate *takenAtDate = [[[self mediaCellFeedItem] takenAtDate] date];

	if (([now timeIntervalSinceDate:takenAtDate] > minimumTakenAtTime || alwaysAlert) && doubleTapModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like video
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like video
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[self viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end

%hook IGFeedItemPageCell

- (void)pageMediaViewDidDoubleTap:(id)arg1 {

	NSString *username = [[[self mediaCellFeedItem] user] username];
	NSString *title = [NSString stringWithFormat:@"Like %@'s Post?", username];
	NSDate *now = [NSDate date];
	NSDate *takenAtDate = [[[self mediaCellFeedItem] takenAtDate] date];

	if (([now timeIntervalSinceDate:takenAtDate] > minimumTakenAtTime || alwaysAlert) && doubleTapModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like carousel
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like carousel
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[self viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end

%hook IGFeedItemUFICell

- (void)UFIButtonBarDidTapOnLike:(id)arg1 {

	NSString *username = [[[[self delegate] feedItem] user] username];
	NSString *title = [NSString stringWithFormat:@"Like %@'s Post?", username];
	NSDate *now = [NSDate date];
	NSDate *takenAtDate = [[[[self delegate] feedItem] takenAtDate] date];
	BOOL hasLiked = [[[self delegate] feedItem] hasLiked];
	
	if ((!hasLiked) && ([now timeIntervalSinceDate:takenAtDate] > minimumTakenAtTime || alwaysAlert) && heartTapModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like post
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like post
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[self viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end

static void loadPrefs() {

	NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.instanotastalker.plist"];

	enabled = [preferences objectForKey:@"enabled"] ? [[preferences objectForKey:@"enabled"] boolValue] : YES; // Default: Enabled

	doubleTapModeEnabled = [preferences objectForKey:@"doubleTapModeEnabled"] ? [[preferences objectForKey:@"doubleTapModeEnabled"] boolValue] : YES;
	heartTapModeEnabled = [preferences objectForKey:@"heartTapModeEnabled"] ? [[preferences objectForKey:@"heartTapModeEnabled"] boolValue] : NO;

	alertStyle = [preferences objectForKey:@"alertStyle"] ? [[preferences objectForKey:@"alertStyle"] intValue] : 0;

	alwaysAlert = [preferences objectForKey:@"alwaysAlert"] ? [[preferences objectForKey:@"alwaysAlert"] boolValue] : NO;
	minimumTakenAtTime = [preferences objectForKey:@"minimumTakenAtTime"] ? [[preferences objectForKey:@"minimumTakenAtTime"] floatValue] : 604800.0f;

}

%ctor {

	// DEVELOPER'S NOTE: Hooking IGFeedItem did not work as the like would "half-happen" by then and crash Instagram

	loadPrefs(); // Load preferences into variables
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.yulkytulky.instanotastalker/saved"), NULL, CFNotificationSuspensionBehaviorCoalesce); // Listen for preference changes

	if (enabled) { // Thanks, Dimitar Nestorov
        dispatch_async(dispatch_queue_create("InstaNotAStalker.wait", 0), ^{
            dispatch_queue_t signal = dispatch_queue_create("InstaNotAStalker.signal", 0);
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            while (!NSClassFromString(@"IGFeedItemPhotoCell") || !NSClassFromString(@"IGFeedItemVideoCell") || !NSClassFromString(@"IGFeedItemPageCell") || !NSClassFromString(@"IGFeedItemUFICell")) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), signal, ^{
                    dispatch_semaphore_signal(semaphore);
                });
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            }
            %init;
        });
    }

}