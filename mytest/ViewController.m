//
//  ViewController.m
//  mytest
//
//  Created by sied zarrinsaray on 3/30/16.
//  Copyright © 2016 sied zarrinsaray. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import <malloc/malloc.h>

@interface ViewController ()

@end

@implementation ViewController
static NSString * const acronymURLString = @"http://www.nactem.ac.uk/software/acromine/";
MBProgressHUD * HUD;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _acronymData.text = _acronymText.text;
  
    return YES;
    
}

- (IBAction)acronymButton:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"%@dictionary.py?sf=%@", acronymURLString, _acronymText.text];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.label.text = @"Doing funky stuff...";
    HUD.detailsLabel.text = @"Just relax";
    HUD.mode = MBProgressHUDModeAnnularDeterminate;

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //Make the request
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *meanings = [(NSDictionary *) responseObject[0] objectForKey:@"lfs"];
        NSLog(@"count=%d", meanings.count);
        NSString *meaningsString = @"";
        
        //Go through the array and show meanings
        for(int i = 0; i < meanings.count; i++)
        {
            meaningsString = [meaningsString stringByAppendingFormat:@"%@\n", [meanings[i] objectForKey:@"lf"]];
        }
        
        //show it
        _acronymData.text = meaningsString;
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _acronymData.text = [NSString  stringWithFormat: @"Error: unable to get response, Error =%@", error];
    }];
    [operation start];

    [HUD showWhileExecuting:@selector(doSomeFunkyStuff) onTarget:self withObject:nil animated:YES];
}

- (void)doSomeFunkyStuff {
    float progress = 0.0;
    
    while (progress < 1.0) {
        progress += 0.01;
        HUD.progress = progress;
        usleep(50000);
    }
}
@end
