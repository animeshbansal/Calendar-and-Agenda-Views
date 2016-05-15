//
//  ViewController.h
//  SunriseSample
//
//  Created by animesh on 5/15/16.
//  Copyright © 2016 animesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalenderView.h"
@interface ViewController : UIViewController <CalenderViewDelegate>
{
    CalenderView *viewCalender;
    
}
@end

