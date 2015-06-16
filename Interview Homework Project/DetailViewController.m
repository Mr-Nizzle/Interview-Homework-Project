//
//  DetailViewController.m
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "DetailViewController.h"
#import "VenueTableViewCell.h"
#import "Venue.h"
#import "UIImageView+WebCache.h"
#import "VenueMapViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    if (IS_IPAD) {
        _venueHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 400);
    }
    else{
        _venueHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    }
    [self.venueSchedulesTableView setTableHeaderView:_venueHeaderView];
    [self.venueImageView sd_setImageWithURL:[NSURL URLWithString:self.venue.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    if (IS_IPAD) {
        if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]){
            self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        }
        self.navigationItem.leftItemsSupplementBackButton = true;
    }
    [_locationButton setImage:[_locationButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_phoneButton setImage:[_phoneButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_ticketButton setImage:[_ticketButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self displayVenueData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.venue.schedule count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"VenueTableViewCell";
    VenueTableViewCell *cell = (VenueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *schedule = [_venue.schedule objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatterGMT = [[NSDateFormatter alloc] init];
    [dateFormatterGMT setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSDateFormatter *dateFormatterHuman = [[NSDateFormatter alloc] init];
    [dateFormatterHuman setDateFormat:@"EEEE dd 'from' hh:mma"];
    [dateFormatterHuman setAMSymbol:@"am"];
    [dateFormatterHuman setPMSymbol:@"pm"];
    
    NSDateFormatter *dateFormatterHumanTo = [[NSDateFormatter alloc] init];
    [dateFormatterHumanTo setDateFormat:@"'to' hh:mma"];
    [dateFormatterHumanTo setAMSymbol:@"am"];
    [dateFormatterHumanTo setPMSymbol:@"pm"];
    
    NSDate *dateFrom = [dateFormatterGMT dateFromString:[schedule valueForKey:@"start_date"]];
    NSDate *dateTo = [dateFormatterGMT dateFromString:[schedule valueForKey:@"end_date"]];
    
    NSString *formattedDateStringFrom = [dateFormatterHuman stringFromDate:dateFrom];
    NSString *formattedDateStringTo = [dateFormatterHumanTo stringFromDate:dateTo];
    
    [cell.venueScheduleLabel setText:[NSString stringWithFormat:@"%@ %@", formattedDateStringFrom, formattedDateStringTo]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 21.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _schedulesHeaderView;
}

#pragma mark -
#pragma mark Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Layout Fix

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        [UIView animateWithDuration:0.3f animations:^{
            self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
        } completion:^(BOOL finished) {
            self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
        }];
    }
}

#pragma mark -
#pragma mark Display Venue Data

-(void)displayVenueData{
    [_venueNameLabel setText:_venue.name];
    [_venueAddressLabel setText:_venue.address];
}

- (IBAction)openTicket:(id)sender {
    if ([_venue.ticket_link length] != 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_venue.ticket_link]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"No link available for %@", _venue.name] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)callPhone:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Call %@", _venue.name]
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    if ([_venue.phone length] != 0) {
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"Call %@", _venue.phone]];
    }
    if ([_venue.tollfreephone length] != 0) {
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"Call Toll Free %@", _venue.tollfreephone]];
    }
    [actionSheet showInView:self.view];
}

- (IBAction)showLocation:(id)sender {
    VenueMapViewController *mapViewController = [[VenueMapViewController alloc] initWithNibName:@"VenueMapViewController"  bundle:[NSBundle mainBundle]];
    mapViewController.venue = _venue;
    [[self navigationController] pushViewController:mapViewController animated:YES];
}

#pragma mark -
#pragma mark Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Cancel"]) {
        // do nothing
    }
    else{
        if (buttonIndex == 1) {
            // make call
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _venue.phone]];
            [[UIApplication sharedApplication] openURL:url];
        }
        else if (buttonIndex == 2){
            // make call
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _venue.tollfreephone]];
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }
}

@end
