//
//  EventCustomCell.m
//  SunriseSample
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//

#import "EventCustomCell.h"

@implementation EventCustomCell
@synthesize eventDesc;
@synthesize eventTime;
@synthesize eventTitle;
@synthesize eventTimeContainerView;
@synthesize eventImage;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEventDetail:(NSDictionary*)dictEventDetail{
    eventTitle.text = @"Event Title";
    eventDesc.text = @"This is demo description";
    eventTime.text = @"2:00 PM";
    UIFont *font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    
    float widthIs =
    [eventTime.text
     boundingRectWithSize:CGSizeMake(1000, self.eventTimeContainerView.frame.size.height)
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:font}
     context:nil]
    .size.width;
    
    self.eventTimeContainerView.frame = CGRectMake(self.frame.size.width-widthIs-20,  self.eventTimeContainerView.frame.origin.y, widthIs+10,  self.eventTimeContainerView.frame.size.height);
    
    self.eventTimeContainerView.layer.cornerRadius = 10.0f;
    self.eventTimeContainerView.layer.masksToBounds = YES;
    self.eventTitle.frame = CGRectMake(5, 0, self.eventTimeContainerView.frame.size.width-10, self.eventTimeContainerView.frame.size.height);
    
    self.eventImage.layer.cornerRadius = 25.0f;
    self.eventImage.layer.masksToBounds = YES;
    
    self.eventImage.image = [UIImage imageNamed:@"eventImage1.png"];

}
@end
