#include "NASRootListController.h"

@implementation NASRootListController

- (NSArray *)specifiers {

	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	NSArray *chosenIDs = @[@"2", @"102"];
	[self setSavedSpecifiers:(![self savedSpecifiers]) ? [[NSMutableDictionary alloc] init] : [self savedSpecifiers]];
	for (PSSpecifier *specifier in _specifiers) {
		if ([chosenIDs containsObject:[specifier propertyForKey:@"id"]]) {
			[[self savedSpecifiers] setObject:specifier forKey:[specifier propertyForKey:@"id"]];
		}
	}

	return _specifiers;

}

- (id)readPreferenceValue:(PSSpecifier*)specifier {

	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier properties][@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[[specifier properties][@"key"]]) ?: [specifier properties][@"default"];

}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {

	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier properties][@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:[specifier properties][@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (__bridge CFStringRef)[specifier properties][@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}

	NSString *key = [specifier propertyForKey:@"key"];
	if ([key isEqualToString:@"alwaysAlert"]) {
		if (![value boolValue]) {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"2"]] afterSpecifierID:@"1" animated:YES];
		} else if ([self containsSpecifier:[self savedSpecifiers][@"2"]]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"2"]] animated:YES];
		}
	} else if ([key isEqualToString:@"enabled"]) {
		if ([value boolValue] == [self enabledSwitchStateWhenLastReset]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"102"]] animated:YES];
		} else {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"102"]] afterSpecifierID:@"101" animated:YES];
		}
	}

}

- (void)reloadSpecifiers {

  	[super reloadSpecifiers];

	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.instanotastalker.plist"];
  	if ([preferences[@"alwaysAlert"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"2"]] animated:NO];
	} else if (![self containsSpecifier:[self savedSpecifiers][@"2"]]) {
		[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"2"]] afterSpecifierID:@"1" animated:NO];
	}
	[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"102"]] animated:NO];

	[self setEnabledSwitchStateWhenLastReset:[preferences[@"enabled"] boolValue]];

}

- (void)viewDidLoad {

    [super viewDidLoad];

	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.instanotastalker.plist"];
  	if ([preferences[@"alwaysAlert"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"2"]] animated:NO];
	} else if (![self containsSpecifier:[self savedSpecifiers][@"2"]]) {
		[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"2"]] afterSpecifierID:@"1" animated:NO];
	}
	[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"102"]] animated:NO];

	[self setEnabledSwitchStateWhenLastReset:[preferences[@"enabled"] boolValue] ?: YES]; // enabled key does not exist when opening for the first time

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

	[[[[self navigationController] navigationController] navigationBar] setTintColor:[UIColor colorWithRed:0.74 green:0.48 blue:1.00 alpha:1.00]];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [UIView animateWithDuration:INFINITY animations:^{
        [[[[self navigationController] navigationController] navigationBar] setTintColor:nil];
    }];

}  

- (void)killInsta {

	if ([self containsSpecifier:[self savedSpecifiers][@"102"]]) {
		UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
		[impactGenerator impactOccurred];
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"102"]] animated:YES];
		[self setEnabledSwitchStateWhenLastReset:!_enabledSwitchStateWhenLastReset];
	}

    NSTask *killInsta = [NSTask new];
    [killInsta setLaunchPath:@"/usr/bin/killall"];
    [killInsta setArguments:@[@"-9", @"Instagram"]];
    [killInsta launch];

}

- (void)github {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/YulkyTulky/InstaNotAStalker"]];

}

@end