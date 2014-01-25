    //
//  SettingsViewController.m
//  Ghostile
//
//  Created by Michael Fellows on 12/3/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "SettingsViewController.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"
#import <MessageUI/MessageUI.h>

@interface SettingsViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation SettingsViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavBar];
    [self.tableView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Appearance

-(void)configureNavBar
{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Dismiss", nil) style:UIBarButtonItemStylePlain target:self action:@selector(dismissSettingsController:)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    [self.navigationItem setTitle:NSLocalizedString(@"Settings", nil)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:18.0]};
    
}

#pragma tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num;
    if (section == 2) {
        num =  2;
    }
    
    if (section == 0 || section == 1 || section  == 3) {
        num =  1;
    }
    return num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = NSLocalizedString(@"Instructions", nil);
        cell.textLabel.textColor = [self normalColor];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = NSLocalizedString(@"Contact Support", nil);
        cell.textLabel.textColor = [self normalColor];
    }
    
    if (indexPath.section == 2) {
        NSArray *section1 = @[ NSLocalizedString(@"Follow Broadway Lab on Twitter", nil), NSLocalizedString(@"Follow Ghostile on Instagram", nil)];
        cell.textLabel.text = section1[indexPath.row];
        cell.textLabel.textColor = [self accentColor];
    }
    
    if (indexPath.section == 3) {
        cell.textLabel.text = NSLocalizedString(@"Rate Ghostile", nil);
        cell.textLabel.textColor = [self accentColor];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *footer;
    if (section == 0) {
        footer = NSLocalizedString(@"Having trouble? We'll walk you through the tutorial on how to use Ghostile.", nil);
    }
    
    if (section == 1) {
        footer = NSLocalizedString(@"If you have questions or feedback, please contact support.", nil);
    }
    
    if (section == 2) {
        footer = NSLocalizedString(@"Connect with us and see incredible Ghostile photos from users across the world.", nil);
    }
    
    if (section == 3) {
        footer = NSLocalizedString(@"Please take a moment to rate Ghostile on the App Store.", nil);
    }
    return footer;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self showIntro];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setSubject:NSLocalizedString(@"Ghostile: Support", nil)];
            [mailer setMessageBody:@"" isHTML:NO];
            [mailer setToRecipients:@[@"hello@broadwaylab.com"]];
            [self presentViewController:mailer animated:YES completion:nil];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email Not Available", nil) message:NSLocalizedString(@"Your don't have email set up on your device.", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        NSURL *url = [NSURL URLWithString:@"https://twitter.com/broadwaylab"];
        [[UIApplication sharedApplication] openURL:url];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        NSURL *url = [NSURL URLWithString:@"http://instagram.com/ghostileapp"];
        [[UIApplication sharedApplication] openURL:url]; 
    }
    
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/ghostile-easily-blend-images/id697588942?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - Convenience Methods

-(UIColor *)accentColor
{
    return [UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
}

-(UIColor *)normalColor
{
    return [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
}

#pragma mark - EAIntro

-(void)showIntro
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = NSLocalizedString(@"Welcome to Ghostile!", nil);
    page1.desc = NSLocalizedString(@"Tap the screen to select your background photo.", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page1.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro1.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page1.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro1.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = NSLocalizedString(@"We selected an ocean picture!", nil);
    page2.desc = NSLocalizedString(@"Swipe right or hit the next button to select another picture.", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page2.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro2.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page2.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro2.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = NSLocalizedString(@"Use Ghostile as the foreground.", nil);
    page3.desc = NSLocalizedString(@"But this isn't very cool. What's next?", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page3.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro3.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page3.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro3.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = NSLocalizedString(@"Adjust the transparency slider.", nil);
    page4.desc = NSLocalizedString(@"Fade to what looks best. Now this is better.", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page4.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro4.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page4.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro4.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.title = NSLocalizedString(@"Let's add a filter!", nil);
    page5.desc = NSLocalizedString(@"Tap which filter you like best", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page5.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro5.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page5.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro5.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    EAIntroPage *page6 = [EAIntroPage page];
    page6.title = NSLocalizedString(@"This one looks cool...", nil);
    page6.desc = NSLocalizedString(@"Tap the share buton on the top right.", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page6.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro6.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page6.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro6.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    EAIntroPage *page7 = [EAIntroPage page];
    page7.title = NSLocalizedString(@"Share your picture!", nil);
    page7.desc = NSLocalizedString(@"Facebook, Twitter, Instagram. Or just keep it for yourself.", nil);
    if ([UIScreen mainScreen].bounds.size.height < 568.0) {
        page7.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro7.png"] convertToSize:CGSizeMake(176, 312)];
    } else {
        page7.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro7.png"] convertToSize:CGSizeMake(224, 398)];
    }
    
    EAIntroView *introView = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andPages:@[page1, page2, page3, page4, page5, page6, page7]];
    [introView showInView:self.navigationController.view animateDuration:1.0];
}

#pragma mark - Selector Methods

-(void)dismissSettingsController:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMailComposeViewController Delegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}


@end
