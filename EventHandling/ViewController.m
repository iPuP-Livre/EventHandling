//
//  ViewController.m
//  EventHandling
//
//  Created by Jérémy Lagrue on 08/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-	(void)viewDidLoad 
{
    _aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _aButton.frame = CGRectMake(20.0, 30.0, 120.0, 30.0);
    [_aButton setTitle:@"Touche moi !" forState:UIControlStateNormal];
    [_aButton setTitle:@"Encore ?" forState:UIControlStateSelected];
    [_aButton addTarget:self action:@selector(buttonHandleMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_aButton];
    
    _aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20.0, 80.0, 94.0, 27.0)];
    [_aSwitch addTarget:self action:@selector(switchHandleMethod:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_aSwitch];
    
    _aSlider = [[UISlider alloc] initWithFrame:CGRectMake(20.0, 130.0, 150.0, 20.0)];
    _aSlider.minimumValue = 0.0;
    _aSlider.maximumValue = 100.0;
    [_aSlider addTarget:self action:@selector(sliderHandleMethod:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_aSlider];
    
    _aLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 170.0, 150.0, 20.0)];
    [_aLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_aLabel];
    
    _aTextField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 200.0, 150.0, 30.0)];
    [_aTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [_aTextField setPlaceholder:@"Entre un chiffre"];
    [_aTextField setDelegate:self];
    [_aTextField setKeyboardType:UIKeyboardTypeDefault];
    [_aTextField setClearsOnBeginEditing:YES];
    [self.view addSubview:_aTextField];
    
    [super viewDidLoad];
}
// Méthode pour gérer les événements du bouton
-	(void) buttonHandleMethod:(id)sender 
{
    NSLog(@"bouton cliqué !");
    UIButton *theButton = (UIButton*)sender;
    [theButton setSelected:![theButton isSelected]];
}
// Méthode pour gérer les événements du switch
-	(void) switchHandleMethod:(id)sender 
{
    UISwitch *theSwitch = (UISwitch*)sender;
    [_aButton setSelected:theSwitch.on];
}
// Méthode pour gérer les événements du slider
-	(void) sliderHandleMethod:(id)sender 
{
    UISlider *theSlider = (UISlider*)sender;
    
    NSString *stringToPlace = [NSString stringWithFormat:@"%.2f", theSlider.value];
    [_aLabel setText:stringToPlace];
    [_aTextField setPlaceholder:stringToPlace];
}
// Méthode pour gérer les événements du textField
-	(BOOL) textFieldShouldReturn:(UITextField *)textField 
{
    if (textField == _aTextField)
    {
        NSString *floatRegEx = @"[0-9]{1,}+[0-9.]{0,}"; 
        NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", floatRegEx];
        BOOL stringMatchingFloat = [floatTest evaluateWithObject:textField.text];
        
        if (stringMatchingFloat) 
        {
            [_aSlider setValue:[textField.text floatValue] animated:YES];
            
            NSString *stringToPlace = [NSString stringWithFormat:@"%.2f", _aSlider.value];
            [_aLabel setText:stringToPlace];
            [_aTextField setPlaceholder:stringToPlace];
            
            [_aTextField resignFirstResponder];
        }
        else 
        {
            [_aTextField setText:@""];
        }
    }
    return YES;    
}
@end
