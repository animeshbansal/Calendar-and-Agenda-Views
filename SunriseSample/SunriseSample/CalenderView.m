
//
//  CalenderView.m
//  Calender
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//


#import "CalenderView.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat    CalenderViewNavigationButtonSize            = 40.0f;
const CGFloat    CalenderViewNavigationXSpace                = 5.0f;
const CGFloat    CalenderViewNavigationYSpace                = 4.0f;

//fonts
const NSUInteger CalenderViewFontSize                        = 16.0;




@interface CalenderView ()
{
    float width;
    float height;
}
// today day
@property(nonatomic,assign)   NSInteger              intToday;

// total days in month
// used to set cell sizes
@property(nonatomic,assign)   NSInteger              totalDaysInMonth;

//selected index number i.e calender date
@property(nonatomic,assign)   NSInteger              intIndexNumber;

// current date
@property(nonatomic,assign)   NSInteger              intCurrentDate;

// used to identify month
@property(nonatomic,assign)   NSInteger              intDiffOfMonth;

// number of days in previous month
@property(nonatomic,assign)   NSInteger              intNumberOfDaysInPrev_Month;

// starting week day
@property(nonatomic,assign)   NSInteger              startingweekday;

@end


@implementation CalenderView

@synthesize fontOfCalender;
@synthesize delegate;

#pragma mark - Lifecycle


- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        [self designingOfCalender];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self designingOfCalender];
    
}


/*
 //
 //designing of calender components and calender
 //
 // imgView used to show current selected date  .
 //
 // month-year button showing current month and year
 //
 
 */
-(void)designingOfCalender{
    width = (self.frame.size.width-60)/7.0;
    height = ((self.frame.size.height-72)/6.0)-CalenderViewNavigationYSpace-2;
    
    // Initialization code
    fontOfCalender = [UIFont fontWithName:@"Arial" size:CalenderViewFontSize];
    self.backgroundColor = [UIColor whiteColor];
    
    self.imgViewDateSelecter = [[UIImageView alloc] init];
    [self.imgViewDateSelecter setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CalRedTile" ofType:@"png"]]];
    self.imgViewDateSelecter.frame = CGRectMake(0,
                                                0,
                                                width,
                                                height-2);
    [self addSubview:self.imgViewDateSelecter];
    
    self.month_YearButton = [[UIButton alloc] init];
    [self.month_YearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.month_YearButton.titleLabel.font = fontOfCalender;
    self.month_YearButton.frame = CGRectMake(CalenderViewNavigationButtonSize,
                                             0,
                                             self.frame.size.width-CalenderViewNavigationButtonSize*2,
                                             CalenderViewNavigationButtonSize);
    [self addSubview:self.month_YearButton];
    
    [self setCalenderParameter:0];
    [self showWeekDays];
}

/*
 //
 //setting font of calender
 //
 */
- (void)setFontOfCalender:(UIFont *)font
{
    fontOfCalender = font;
    [self setCalenderParameter:0];
    [self showWeekDays];
}


/*
 //
 // Showing week days @"S", @"M", @"T", @"W", @"T", @"F", @"S",
 // If not sunday than black color else red colour
 //
 
 */
- (void)showWeekDays
{
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNext.frame = CGRectMake(self.frame.size.width-CalenderViewNavigationButtonSize,
                               0,
                               CalenderViewNavigationButtonSize,
                               CalenderViewNavigationButtonSize);
    btnNext.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:CalenderViewFontSize];
    [btnNext setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ArrowNext" ofType:@"png"]] forState:UIControlStateNormal];
    [btnNext addTarget:self action:@selector(gotoNextMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnNext];
    
    UIButton *btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPrev.frame = CGRectMake(0,
                               0,
                               CalenderViewNavigationButtonSize,
                               CalenderViewNavigationButtonSize);
    btnPrev.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:CalenderViewFontSize];
    [btnPrev setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ArrowPrev" ofType:@"png"]] forState:UIControlStateNormal];
    [btnPrev addTarget:self action:@selector(gotoPrevMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnPrev];
    
    float xRef = 15;
    
    NSArray *arrWeeks = [[NSArray alloc] initWithObjects:@"S", @"M", @"T", @"W", @"T", @"F", @"S", nil];
    for (int i=0; i<[arrWeeks count]; i++) {
        
        UILabel *lblWeekDay = [[UILabel alloc] initWithFrame:CGRectMake(xRef,CGRectGetMaxY(self.month_YearButton.frame)-10, width, height)];
        if(i!=0)
            lblWeekDay.textColor = [UIColor blackColor];
        else
            lblWeekDay.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        lblWeekDay.text = [arrWeeks objectAtIndex:i];
        lblWeekDay.font = fontOfCalender;
        lblWeekDay.textAlignment = NSTextAlignmentCenter;
        lblWeekDay.backgroundColor = [UIColor clearColor];
        [self addSubview:lblWeekDay];
        xRef += 5+width;
    }
}

/*
 //Setting caleneder values and Animation type
 //
 //designing of calender with dates
 //
 //@param NSInteger type
 //
 //current month = 0
 //
 //previous month from current month = 1
 //
 //next month from current month = -1
 //
 //
 */

- (void)setCalenderParameter:(NSInteger)intMonth
{
    if(intMonth==0)
        self.selectedDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MMMM - yyyy"];
    
    [self.month_YearButton setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:self.selectedDate]] forState:UIControlStateNormal];
    self.month_YearButton.titleLabel.font = fontOfCalender;
    
    [dateFormatter setDateFormat:@"dd"];
    self.intCurrentDate = [[dateFormatter stringFromDate:self.selectedDate] integerValue];
    self.intToday = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    self.startingweekday = [self firstWeekDayNumberOfDate:self.selectedDate];
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    [cal setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    NSRange days = [cal rangeOfUnit:NSCalendarUnitDay
                             inUnit:NSCalendarUnitMonth
                            forDate:self.selectedDate];
    
    self.totalDaysInMonth = days.length;
    
    NSInteger flags = (NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay|NSCalendarUnitWeekOfMonth| NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal);
    NSDateComponents *dateComponents = [cal components:flags fromDate:self.selectedDate];
    
    [dateComponents setMonth:[dateComponents month]-1];
    
    NSDate *prev_Month = [cal dateFromComponents:dateComponents];
    NSRange days_prv_month = [cal rangeOfUnit:NSCalendarUnitDay
                                       inUnit:NSCalendarUnitMonth
                                      forDate:prev_Month];
    self.intNumberOfDaysInPrev_Month = days_prv_month.length;
    
    int DateToShow = 1;
    
    float xRef = 15;
    float yRef = 60;
    
    for(UIView *view in self.subviews)
        [view removeFromSuperview];
    
    [self addSubview:self.imgViewDateSelecter];
    [self addSubview:self.month_YearButton];
    
    for (int i=0; i<6; i++)
    {
        for (int j=1; j<=7; j++)
        {
            UILabel *lblDateInCAl = [[UILabel alloc] initWithFrame:CGRectMake(xRef, yRef, width, height)];
            lblDateInCAl.font = fontOfCalender;
            lblDateInCAl.textAlignment = NSTextAlignmentCenter;
            
            //Prev month date showing
            if(i==0 && j<self.startingweekday)// || (i==0 && self.startingweekday==1))
            {
                lblDateInCAl.alpha = 0.5;
                lblDateInCAl.text = [NSString stringWithFormat:@"%li", self.intNumberOfDaysInPrev_Month-(self.startingweekday-j-1)];
            }
            else if(i==0 && j>=self.startingweekday)//Curr Month
            {
                lblDateInCAl.text = [NSString stringWithFormat:@"%i", DateToShow++];
            }
            else if(i>0 && DateToShow<=self.totalDaysInMonth)// curr month
            {
                lblDateInCAl.text = [NSString stringWithFormat:@"%i", DateToShow++];
            }
            else if(DateToShow>=self.totalDaysInMonth+1)// Next Month
            {
                lblDateInCAl.text = [NSString stringWithFormat:@"%li", DateToShow-self.totalDaysInMonth];
                DateToShow++;
                lblDateInCAl.alpha = 0.5;
            }
            
            if(j==1)
            {
                lblDateInCAl.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:10/255.0 alpha:0.20];
                lblDateInCAl.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
            }
            else
            {
                lblDateInCAl.backgroundColor = [UIColor clearColor];
                lblDateInCAl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            }
            
            [self addSubview:lblDateInCAl];
            
            xRef += width+CalenderViewNavigationXSpace;
            
            // Set Current date highlited as
            NSDateFormatter *dateFormat_first = [[NSDateFormatter alloc] init];
            [dateFormat_first setDateFormat:@"dd"];
            NSString *strCurrMonth_MMM = [dateFormat_first stringFromDate:[NSDate date]];
            
            if(self.intDiffOfMonth == 0 && [strCurrMonth_MMM integerValue] == DateToShow-1) {
                lblDateInCAl.layer.borderColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor;
                lblDateInCAl.layer.borderWidth = 2.0;
            }
        }
        xRef = 15;
        yRef += height+CalenderViewNavigationYSpace;
    }
    
    if(intMonth!=2)
    {
        if (self.animationName.length==0) {
            self.animationName = @"pageUnCurl";
        }
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        [animation  setDuration:1.0];
        if(intMonth==-1)
        {
            animation.type=self.animationName;
            animation.subtype=kCATransitionFromLeft;
        }
        else if(intMonth==1)
        {
            animation.type=self.animationName;
            animation.subtype=kCATransitionFromRight;
        }
        
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [[self layer] addAnimation:animation forKey:self.animationName];
    }
    
    int intPOS_X = (self.intCurrentDate + self.startingweekday-2)%7;
    long intPOS_Y = (self.intCurrentDate + self.startingweekday-2)/7;
    
    self.imgViewDateSelecter.center = CGPointMake((width/2.0)+15+((width+5)*intPOS_X), 60+(height/2.0)+((height+4)*intPOS_Y));
}

- (NSInteger)firstWeekDayNumberOfDate:(NSDate *)arbitraryDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:arbitraryDate];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSDateComponents* compWeek = [calendar components:NSCalendarUnitWeekday fromDate:firstDayOfMonthDate];
    
    return [compWeek weekday]; // 1 = Sunday, 2 = Monday,
}

/*
 //
 // methods called when animation start
 //
 */

- (void)animationDidStart:(CAAnimation *)anim
{
    self.userInteractionEnabled =  NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
}


#pragma mark - touch delegates methods


// touch event methoods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if((touchPoint.y>=55 && touchPoint.y<235) && (touchPoint.x>=9 && touchPoint.x<self.frame.size.width-15))
    {
        int intPOS_X = (touchPoint.x-14)/(width+5);
        int intPOS_Y = (touchPoint.y-60)/(height+CalenderViewNavigationYSpace);
        self.intIndexNumber = (intPOS_Y*7) + intPOS_X+1;
        self.imgViewDateSelecter.center = CGPointMake((width/2.0)+15+((width+5)*intPOS_X), 60+(height/2.0)+((height+4)*intPOS_Y));
        [self dateChanged:self.intIndexNumber andWeekStart:self.startingweekday];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if((touchPoint.y>=55 && touchPoint.y<235) && (touchPoint.x>=9 && touchPoint.x<self.frame.size.width-15))
    {
        int intPOS_X = (touchPoint.x-14)/(width+5);
        int intPOS_Y = (touchPoint.y-60)/(height+CalenderViewNavigationYSpace);
        self.intIndexNumber = (intPOS_Y*7) + intPOS_X+1;
        self.imgViewDateSelecter.center = CGPointMake((width/2.0)+15+((width+5)*intPOS_X), 60+(height/2.0)+((height+4)*intPOS_Y));
        [self dateChanged:self.intIndexNumber andWeekStart:self.startingweekday];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

/*
 // when ever user change date , method called
 */

- (void)dateChanged:(NSInteger)index andWeekStart:(NSInteger)weekStartDay
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDateComponents *components = [cal components:( kCFCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[NSDate date]];
    
    components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[[NSDate alloc] init]];
    
    //Previous
    if(index-weekStartDay<0)
    {
        self.userInteractionEnabled =  NO;
        --self.intDiffOfMonth;
        [components setMonth:([components month] + self.intDiffOfMonth)];
        
        [components setDay:1+self.intNumberOfDaysInPrev_Month-weekStartDay+index];
        NSDate *lastMonth = [cal dateFromComponents:components];
        self.selectedDate = lastMonth;
        [self setCalenderParameter:1];
        [self showWeekDays];
    }//Next
    else if(index-weekStartDay>=self.totalDaysInMonth)
    {
        self.userInteractionEnabled =  NO;
        ++self.intDiffOfMonth;
        [components setMonth:([components month] + self.intDiffOfMonth)];
        [components setDay:1+index-weekStartDay-self.totalDaysInMonth];
        NSDate *nextMonth = [cal dateFromComponents:components];
        self.selectedDate = nextMonth;
        [self setCalenderParameter:-1];
        [self showWeekDays];
    }
    else
    {
        [components setMonth:([components month] + self.intDiffOfMonth)];
        [components setDay:index - weekStartDay+1];
        NSDate *currDate = [cal dateFromComponents:components];
        self.selectedDate = currDate;
    }
    
    if(self.delegate!=nil && [(id)[self delegate] respondsToSelector:@selector(calenderDateChanged:)])
    {
        [(id)[self delegate] calenderDateChanged:self.selectedDate];
    }
}

// this Method is calling from Bottom Slider
- (void)setDateToCalender:(NSDate *)calDate
{
    // Checking if date is of current month then set self.intDiffOfMonth = 0;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:calDate];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:otherDate]) {
        //do stuff
        self.intDiffOfMonth = 0;
    }
    
    self.selectedDate = calDate;
    [self setCalenderParameter:2];
    
    
    if(self.delegate!=nil && [(id)[self delegate] respondsToSelector:@selector(calenderDateChanged:)])
    {
        [(id)[self delegate] calenderDateChanged:self.selectedDate];
    }
    
}

/*
 //
 //method to set value on calender
 //
 */
- (void)setTodayDateToCalender
{
    self.intDiffOfMonth = 0;
    self.selectedDate = [NSDate date];
    [self setCalenderParameter:0];
    
    if(self.delegate!=nil && [(id)[self delegate] respondsToSelector:@selector(calenderDateChanged:)])
    {
        [(id)[self delegate] calenderDateChanged:self.selectedDate];
    }
}

#pragma mark - Actions
/*
 //moving to next month
 */

- (void)gotoNextMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[NSDate date]];
    components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[[NSDate alloc] init]];
    
    self.userInteractionEnabled =  NO;
    ++self.intDiffOfMonth;
    [components setMonth:([components month] + self.intDiffOfMonth)];
    [components setDay:1];
    NSDate *nextMonth = [cal dateFromComponents:components];
    self.selectedDate = nextMonth;
    [self setCalenderParameter:-1];
    [self showWeekDays];
    
    if(self.delegate!=nil && [(id)[self delegate] respondsToSelector:@selector(calenderDateChanged:)])
    {
        [(id)[self delegate] calenderDateChanged:self.selectedDate];
    }
}
/*
 // previous month date
 */
- (void)gotoPrevMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[NSDate date]];
    
    components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[[NSDate alloc] init]];
    
    self.userInteractionEnabled =  NO;
    --self.intDiffOfMonth;
    [components setMonth:([components month] + self.intDiffOfMonth)];
    
    [components setDay:1];
    NSDate *lastMonth = [cal dateFromComponents:components];
    self.selectedDate = lastMonth;
    [self setCalenderParameter:1];
    [self showWeekDays];
    
    if(self.delegate!=nil && [(id)[self delegate] respondsToSelector:@selector(calenderDateChanged:)])
    {
        [(id)[self delegate] calenderDateChanged:self.selectedDate];
    }
}
@end

