//
//  SLHistoryTableViewCell.m
//  SleepLogger
//
//  Created by Thomas Bibby on 06/04/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLHistoryTableViewCell.h"

@implementation SLHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
