//
//  CalenderView.m
//  SunriseSample
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CalenderViewDelegate <NSObject>

@optional

/**
 * Delegate method return selected Calender date
 *
 * @param calDate  user get seleted date of calender
 *
 */
- (void)calenderDateChanged:(NSDate *)calDate;
@end

@interface CalenderView : UIView


//setting fonts of calender text
@property(nonatomic, strong)  UIFont*                fontOfCalender;


//selected date of calender
@property(nonatomic, strong)  NSDate *               selectedDate; //default seleted date is Today date

// selected date image
// CalRedTile added
@property(nonatomic, strong)  UIImageView*           imgViewDateSelecter;

//Animation Type
// default Animation : pageUnCurl
@property(nonatomic, strong)  NSString*              animationName;



// showing month and year on button in future
@property(nonatomic, strong)  UIButton*              month_YearButton;

// delegate method
//@property(nonatomic, weak) id <CalenderViewDelegate> delegate;
@property(nonatomic, assign) __unsafe_unretained id <CalenderViewDelegate>delegate;




/**
 * Designing of calender components and calender
 *
 * Components include
 //Used image view to show Selected date
 //month_YearButton to show current month with year
 *
 */
-(void)designingOfCalender;


/**
 * set font of Calender
 *
 */
- (void)setFontOfCalender:(UIFont *)font;



/**
 * Set week days @"S", @"M", @"T", @"W", @"T", @"F", @"S",
 *
 * Defult color is black for Sunday red
 *
 */
- (void)showWeekDays;

/**
 * Designing of Calender when ever user change month Set Calender method called to designe calender with dates
 *
 *@param intMonth  previous month 1, Current month 0  , next month = -1
 *
 * Animation used defualt pageUnCurl
 *
 */

- (void)setCalenderParameter:(NSInteger)intMonth;



/**
 * set date on calender to highlight or to show events on calender
 *
 * @param calDate  user pass particular date (NSDate  type )
 *
 */
- (void)setDateToCalender:(NSDate *)calDate;


/**
 * To identify First Week Day
 *
 * @param arbitraryDate
 *
 * 1 = Sunday, 2 = Monday
 *
 */

- (NSInteger)firstWeekDayNumberOfDate:(NSDate *)arbitraryDate;


/**
 * user can customize today date
 *
 */
- (void)setTodayDateToCalender;


@end




