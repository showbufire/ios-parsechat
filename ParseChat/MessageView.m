//
//  MessageView.m
//  ParseChat
//
//  Created by Xiao Jiang on 10/30/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "MessageView.h"

@interface MessageView ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabelView;
@property (strong, nonatomic) PFObject *message;

@end

@implementation MessageView

- (void)updateMessage:(PFObject *)message {
    NSLog(@"here %@", message);
    self.message = message;
    self.messageLabelView.text = self.message[@"text"];
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
