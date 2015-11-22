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
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;

- (void)configureTextViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureTextViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showTwitterShare:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if ([self.tweetTextView.text length] < 140) {
            [twitterController setInitialText:self.tweetTextView.text];
        } else {
            NSString *shortText = [self.tweetTextView.text substringToIndex:140];
            [twitterController setInitialText:shortText];
        }
        
        [self presentViewController:twitterController animated:YES completion:nil];
        
    } else {
        [self showAlertMessage:@"You are not logged in to your Twitter account."];
    }
    
}
- (IBAction)showFacebookShare:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookController setInitialText:self.facebookTextView.text];
        
        [self presentViewController:facebookController animated:YES completion:nil];
    } else {
        [self showAlertMessage:@"You are not logged in to your Facebook account."];
    }
    
}
- (IBAction)showMoreShare:(id)sender {
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.moreTextView.text] applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
- (IBAction)showNoAction:(id)sender {
    
    [self showAlertMessage:@"This doesn't do anything"];
    
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
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.tweetTextView.text] applicationActivities:nil];
        
        [self presentViewController:moreVC animated:YES completion:nil];
        
    }];
    
    [actionController addAction:cancelAction];
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    [actionController addAction:moreAction];
    
    [self presentViewController:actionController animated:YES completion:nil];
    
}

- (void)showAlertMessage:(NSString *)anyMessage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Social Share" message:anyMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)configureTextViews {
    self.tweetTextView.layer.backgroundColor = [[UIColor colorWithRed:1.0 green:0.8 blue:0.89 alpha:1.0] CGColor];
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.5] CGColor];
    self.tweetTextView.layer.borderWidth = 2.0;
    
    self.facebookTextView.layer.backgroundColor = [[UIColor colorWithRed:0.89 green:1 blue:0.89 alpha:1.0] CGColor];
    self.facebookTextView.layer.cornerRadius = 10.0;
    self.facebookTextView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.5] CGColor];
    self.facebookTextView.layer.borderWidth = 2.0;
    
    self.moreTextView.layer.backgroundColor = [[UIColor colorWithRed:0.9 green:0.89 blue:0.98 alpha:1.0] CGColor];
    self.moreTextView.layer.cornerRadius = 10.0;
    self.moreTextView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.5] CGColor];
    self.moreTextView.layer.borderWidth = 2.0;
}
@end
