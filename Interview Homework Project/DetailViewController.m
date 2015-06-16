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

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    [self.venueSchedulesTableView setTableHeaderView:_venueHeaderView];
    [self.venueImageView sd_setImageWithURL:[NSURL URLWithString:self.venue.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _venueHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
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
    
    /*
     {
     "end_date": "2013-02-01 13:00:00 -0800",
     "start_date": "2013-02-01 08:00:00 -0800"
     }
     */
    
    //[dateFormatterGMTAware setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSDictionary *schedule = [_venue.schedule objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatterGMT = [[NSDateFormatter alloc] init];
    [dateFormatterGMT setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSDateFormatter *dateFormatterHuman = [[NSDateFormatter alloc] init];
    [dateFormatterHuman setDateFormat:@"EEEE dd 'from' hh:mm a"];
    
    NSDateFormatter *dateFormatterHumanTo = [[NSDateFormatter alloc] init];
    [dateFormatterHumanTo setDateFormat:@"'to' hh:mm a"];
    
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

@end
