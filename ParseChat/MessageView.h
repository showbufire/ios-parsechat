//
//  MessageView.h
//  ParseChat
//
//  Created by Xiao Jiang on 10/30/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MessageView : UITableViewCell

- (void) updateMessage:(PFObject *)message;

@end
