#import "NASKillButtonCell.h"

@implementation NASKillButtonCell

- (void)refreshCellContentsWithSpecifier:(id)arg1 {

    [super refreshCellContentsWithSpecifier:arg1];

    [[self textLabel] setTextColor:[UIColor colorWithRed:1.00 green:0.27 blue:0.27 alpha:1.00]];
    [[self textLabel] setHighlightedTextColor:[UIColor colorWithRed:1.00 green:0.27 blue:0.27 alpha:1.00]];

}

@end