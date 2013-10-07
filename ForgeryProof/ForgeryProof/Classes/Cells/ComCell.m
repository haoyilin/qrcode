//
//  ComCell.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-21.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "ComCell.h"

@implementation ComCell

@synthesize btn1, btn2, btn3, btn4;
@synthesize imageView1, imageView2, imageView3;

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
