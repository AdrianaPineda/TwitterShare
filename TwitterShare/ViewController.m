//
//  ViewController.m
//  TwitterShare
//
//  Created by Adriana Pineda on 11/22/15.
//  Copyright © 2015 Adriana Pineda. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
- (void)configureTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showShareAction:(id)sender {

    if ([self.tweetTextView isFirstResponder]) {
        [self.tweetTextView resignFirstResponder];
    }
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Share" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            SLComposeViewController *twiterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            // Tweet out the tweet
            if ([self.tweetTextView.text length] < 140) {
                
                [twiterVC setInitialText:self.tweetTextView.text];
                
            } else {
                NSString *shortText = [self.tweetTextView.text substringToIndex:140];
                [twiterVC setInitialText:shortText];
            }
            
            [self presentViewController:twiterVC animated:YES completion:nil];
            
        } else {
            // Raise some kind of objection
            
            [self showAlertMessage:@"Please sign in to twitter before you tweet"];
        }
    }];
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            
            SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [facebookVC setInitialText:self.tweetTextView.text];
            
            [self presentViewController:facebookVC animated:YES completion:nil];
            
        } else {
            // Raise some kind of objection
            
            [self showAlertMessage:@"Please sign in to facebook"];
        }
        
    }];
    
    [actionController addAction:cancelAction];
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    
    [self presentViewController:actionController animated:YES completion:nil];
    
}

- (void)showAlertMessage:(NSString *)anyMessage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Share" message:anyMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)configureTextView {
    self.tweetTextView.layer.backgroundColor = [[UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0] CGColor];
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.5] CGColor];
    self.tweetTextView.layer.borderWidth = 2.0;
}
@end
