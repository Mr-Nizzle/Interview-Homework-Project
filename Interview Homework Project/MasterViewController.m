//
//  MasterViewController.m
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "MasterViewController.h"
#import "VenueTableViewCell.h"
#import "MBProgressHUD.h"
#import "Venue.h"
#import "DetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "NetworkManager.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *venuesArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Venues";
    [self.venuesTableView registerNib:[UINib nibWithNibName:@"VenueTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VenueTableViewCell"];
    [self loadVenues];
    
    _refreshControl = [[UIRefreshControl alloc]init];
    [self.venuesTableView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(loadVenues) forControlEvents:UIControlEventValueChanged];
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
    return [_venuesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"VenueTableViewCell";
    VenueTableViewCell *cell = (VenueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VenueTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSError* err = nil;
    Venue *venue = [[Venue alloc] initWithDictionary:[_venuesArray objectAtIndex:indexPath.row] error:&err];
    
    [[cell venueNameLabel] setText:venue.name];
    [[cell venueAddressLabel] setText:[NSString stringWithFormat:@"%@, %@ %@", venue.address, venue.state, venue.zip]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

#pragma mark -
#pragma mark Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSError* err = nil;
    Venue *venue = [[Venue alloc] initWithDictionary:[_venuesArray objectAtIndex:indexPath.row] error:&err];
    if (IS_IPAD) {
        [self.delegate ipadMasterdidSelectVenue:venue];
    }
    else{
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
        detailViewController.venue = venue;
        [[self navigationController] pushViewController:detailViewController animated:YES];
    }
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

#pragma mark -
#pragma mark Request Data

-(void)loadVenues{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    [networkManager requestDataFromURL:[NSURL URLWithString:@"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json"] andCompletionHandler:^(bool success, id responseObject, NSError *error){
        if (success) {
            _venuesArray = [NSArray arrayWithArray:responseObject];
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [_venuesArray sortedArrayUsingDescriptors:sortDescriptors];
            _venuesArray = sortedArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [_refreshControl endRefreshing];
                [_venuesTableView reloadData];
            });
        }
        else{
            _venuesArray = @[];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [_refreshControl endRefreshing];
                [_venuesTableView reloadData];
            });
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Information"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];
}


@end
