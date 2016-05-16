//
//  ViewController.m
//  SunriseSample
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//

#import "ViewController.h"
#import "EventCustomCell.h"
#import "AlertToastView.h"


const NSUInteger eventListViewControllerSectionCount                        = 1;
const NSUInteger eventListViewControllerHeightForHeaderInSection            = 30;
const NSUInteger eventListViewControllerheightForRowAtIndexPath             = 95;
const NSUInteger eventListViewControllerheightForFooterInSection            = 45;
const NSUInteger eventListViewControllerheightofToastView                   = 100;




@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * arrEventsOfADate;
    __weak IBOutlet CalenderView *viewCalender;
}
@property (weak, nonatomic) IBOutlet UITableView    *eventsList;
@property (strong, nonatomic) IBOutlet AlertToastView *toastView;
@property (strong, nonatomic) NSDate    *calenderSelectedDate;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self screenDesigning];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)screenDesigning{
    
    viewCalender.delegate = self;
    viewCalender.fontOfCalender = [UIFont fontWithName:@"Arial" size:15];
    arrEventsOfADate = [[NSMutableArray alloc]initWithObjects:@"Hi am Bansal",@"this is animesh", nil];
    [self.eventsList setEditing:YES animated:YES];
    [viewCalender setTodayDateToCalender];
}

#pragma mark :- CalenderViewDelegate
- (void)calenderDateChanged:(NSDate *)calDate{
    self.calenderSelectedDate =calDate;
    [self.eventsList reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return eventListViewControllerSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return arrEventsOfADate.count>0?arrEventsOfADate.count+1:2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return eventListViewControllerheightForRowAtIndexPath;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return eventListViewControllerHeightForHeaderInSection;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return eventListViewControllerheightForFooterInSection;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    header.textLabel.textColor = [UIColor darkGrayColor];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [self dateFormater:self.calenderSelectedDate];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of ItemCell
    
    NSString *identifier = @"AddEventOnDateCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    NSString *rowString=@"No event exists";
    if (arrEventsOfADate.count==0) {
        if (indexPath.row == arrEventsOfADate.count+1) {
            rowString = @"Add Event on date";
            cell.editing = YES;
        }
    }
    else{
        if (indexPath.row == arrEventsOfADate.count) {
            rowString = @"Add Events on date";
            cell.editing = YES;
        }
        else{
            identifier = @"EventCustomCellIdentifier";
            rowString = [arrEventsOfADate objectAtIndex:indexPath.row];
            EventCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [cell setEventDetail:nil];
            return cell;

        }
    }
   
    
    if (rowString.length>0) {
        cell.textLabel.text = rowString;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BOOL callEdit = NO;
    if (arrEventsOfADate.count==0) {
        if (indexPath.row == arrEventsOfADate.count+1) {
            callEdit = YES;
        }
    }
    else{
        if (indexPath.row == arrEventsOfADate.count) {
           callEdit = YES;
        }
    }

    if (callEdit) {
        [self insertRowWithIndexPath:indexPath];
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (arrEventsOfADate.count==0) {
        if (indexPath.row == arrEventsOfADate.count+1) {
            return UITableViewCellEditingStyleInsert;
        }
    }
    else{
        if (indexPath.row == arrEventsOfADate.count) {
            return UITableViewCellEditingStyleInsert;
        } else {
            return UITableViewCellEditingStyleDelete;
        }
    }
    
    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
            [arrEventsOfADate removeObjectAtIndex:indexPath.row];
            
        if (arrEventsOfADate.count>0) {
             [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.toastView =[[AlertToastView alloc]init];
            self.toastView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), eventListViewControllerheightofToastView);
            
            [self.toastView showToastView:self.view viewColor:[UIColor redColor] message:@"Item deleted successfully"];
            [self.eventsList addSubview:self.toastView];

        }
        [self.eventsList reloadData];
       
    }
    else{
        [self insertRowWithIndexPath:indexPath];
    }
}

-(void)insertRowWithIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"Open");
    
}

#pragma mark :- Action methods

-(NSString*)dateFormater:(NSDate *)selectedDate
{
    NSString *formatedDate ;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMM"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dateString = [format stringFromDate:selectedDate];
    NSString *week = [dateFormatter stringFromDate:selectedDate];
    ;
    formatedDate = [NSString stringWithFormat:@"%@ , %@", week ,dateString ];
    return formatedDate;
}

@end
