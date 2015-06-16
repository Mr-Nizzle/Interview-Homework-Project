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

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *venuesArray;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Venues";
    [self.venuesTableView registerNib:[UINib nibWithNibName:@"VenueTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VenueTableViewCell"];
    [self loadVenues];
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
    Venue *venue = [[Venue alloc] initWithDictionary:[_venuesArray objectAtIndex:indexPath.row]];
    
    [[cell venueNameLabel] setText:venue.name];
    [[cell venueAddressLabel] setText:venue.address];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

#pragma mark -
#pragma mark Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Venue *venue = [[Venue alloc] initWithDictionary:[_venuesArray objectAtIndex:indexPath.row]];
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
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSArray *jsonRecentPomotions = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 _venuesArray = [NSMutableArray arrayWithArray:jsonRecentPomotions];
             
         }
         else{

         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [_venuesTableView reloadData];
         });
     }];
}

@end
