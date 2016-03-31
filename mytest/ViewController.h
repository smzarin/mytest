//
//  ViewController.h
//  mytest
//
//  Created by sied zarrinsaray on 3/30/16.
//  Copyright © 2016 sied zarrinsaray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *acronymText;
@property (strong, nonatomic) IBOutlet UILabel *acronymData;
- (IBAction)acronymButton:(id)sender;

@end

