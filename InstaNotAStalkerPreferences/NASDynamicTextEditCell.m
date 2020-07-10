#import "NASDynamicTextEditCell.h"

@implementation NASDynamicTextEditCell

- (void)refreshCellContentsWithSpecifier:(id)arg1 {

    [super refreshCellContentsWithSpecifier:arg1];
    
    [self dynamicallyUpdateLabel];

}

- (void)dynamicallyUpdateLabel {

    NSDictionary *timeMap = @{@"86400":@"Number of Days:", @"604800":@"Number of Weeks:", @"2419200":@"Number of Months:", @"31536000":@"Number of Years:"};
    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.instanotastalker.plist"];
    NSString *timeString = [timeMap objectForKey:[preferences objectForKey:@"minimumTakenAtTime"]] ?: @"Number of Weeks:";

    [[self titleTextLabel] setText:timeString];

}

@end