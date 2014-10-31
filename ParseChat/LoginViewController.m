//
//  LoginViewController.m
//  ParseChat
//
//  Created by Xiao Jiang on 10/30/14.
//  Copyright (c) 2014 Xiao Jiang. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ChatViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (IBAction)onSignUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self postLogIn];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Ooops"                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            NSLog(@"error happens when signing up %@", errorString);
            [theAlert show];
        }
    }];
}

- (void) postLogIn {
    ChatViewController *cvc = [[ChatViewController alloc] init];
    [self presentViewController:cvc animated:YES completion:nil];
}

- (IBAction)onSignIn:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *pwd = self.passwordTextField.text;
    [PFUser logInWithUsernameInBackground:username password:pwd block:^(PFUser *user, NSError *error) {
        if (user) {
            [self postLogIn];
        } else {
            UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Ooops"                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [theAlert show];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.passwordTextField.secureTextEntry = YES;
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
