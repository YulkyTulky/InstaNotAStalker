#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <NSTask.h>

@interface PSListController (InstaNotAStalker)
- (BOOL)containsSpecifier:(id)arg1;
@end

@interface NASRootListController: PSListController
@property (nonatomic, retain) NSMutableDictionary *savedSpecifiers;
@property (nonatomic) BOOL enabledSwitchStateWhenLastReset;
@end