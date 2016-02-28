//
//  CustomTableCell.m
//  CustomTable
//
//  Created by Thiago Guimaraes on 2/23/16.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import "RecipeTableCell.h"

@implementation RecipeTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
