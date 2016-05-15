//
//  EventCustomCell.h
//  SunriseSample
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCustomCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *eventTitle;
@property(nonatomic,strong) IBOutlet UILabel *eventTime;
@property(nonatomic,strong) IBOutlet UILabel *eventDesc;
@property(nonatomic,strong) IBOutlet UIView *eventTimeContainerView;
@property(nonatomic,strong) IBOutlet UIImageView *eventImage;

-(void)setEventDetail:(NSDictionary*)dictEventDetail;

@end
