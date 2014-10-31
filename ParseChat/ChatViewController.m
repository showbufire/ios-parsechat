//
//  ChatViewController.m
//  ParseChat
//
//  Created by Xiao Jiang on 10/30/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "MessageView.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *messages;

@end

@implementation ChatViewController

- (IBAction)onSend:(id)sender {
    NSString *message = self.messageTextField.text;
    PFObject *messageObj = [PFObject objectWithClassName:@"Message"];
    messageObj[@"text"] = message;
    [messageObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
        } else {
            NSLog(@"fail to save: %@", error);
        }
    }];
}

- (void) refresh {
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];

     // Sorts the results in descending order by the score field
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        if (!error) {
            // The find succeeded.
            self.messages = messages;
            NSLog(@"%@", messages);
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector: @selector(refresh) userInfo:nil repeats:YES];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageView" bundle:nil] forCellReuseIdentifier:@"MessageView"];
     self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageView *messageView = [self.tableView dequeueReusableCellWithIdentifier:@"MessageView"];
    [messageView updateMessage:self.messages[indexPath.row]];
    return messageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
