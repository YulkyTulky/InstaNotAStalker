#import <Preferences/PSEditableTableCell.h>

@interface PSEditableTableCell (InstaNotAStalker)
- (UILabel *)titleTextLabel;
@end

@interface NASDynamicTextEditCell: PSEditableTableCell
- (void)dynamicallyUpdateLabel;
@end