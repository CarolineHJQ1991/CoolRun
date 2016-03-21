//
//  CRLoginViewController.m
//  CoolRun
//
//  Created by Caroline.H on 3/20/16.
//  Copyright © 2016 Caroline.H. All rights reserved.
//

#import "CRLoginViewController.h"

@interface CRLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswdField;

@end

@implementation CRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImageView *leftVN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    leftVN.contentMode = UIViewContentModeCenter;
    leftVN.frame = CGRectMake(0, 0, 55, 20);
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameField.leftView = leftVN;
    
    UIImageView *leftVP = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock"]];
    leftVP.contentMode = UIViewContentModeCenter;
    leftVP.frame = CGRectMake(0, 0, 55, 20);
    self.userPasswdField.leftViewMode = UITextFieldViewModeAlways;
    self.userPasswdField.leftView = leftVP;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
