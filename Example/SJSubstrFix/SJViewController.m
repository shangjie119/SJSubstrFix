//
//  SJViewController.m
//  SJSubstrFix
//
//  Created by 494948246@qq.com on 07/10/2022.
//  Copyright (c) 2022 494948246@qq.com. All rights reserved.
//

#import "SJViewController.h"

#import "NSString+SJSubstrFix.h"
#define SJLog(format, ...) printf("%s\n", [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

@interface SJViewController ()

@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *str = @"🎊asdsd🎊asd🎊";
    NSString *str1 = [str sj_substringWithRange_validSub:NSMakeRange(1, 7)];
    NSString *str2 = [str sj_substringWithRange_validAll:NSMakeRange(1, 7)];
    SJLog(@"str1 : %@   str2 : %@", str1, str2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
