//
//  AttributesViewController.m
//  Attributes
//
//  Created by David Hoelzer on 2/23/13.
//  Copyright (c) 2013 EnclaveForensics. All rights reserved.
//

#import "AttributesViewController.h"

@interface AttributesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation AttributesViewController

-(void)addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mAS = [self.messageLabel.attributedText mutableCopy];
        [mAS addAttributes:attributes range:range];
        self.messageLabel.attributedText = mAS;
    }
    
}

-(void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.messageLabel.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}

- (IBAction)changeAttribute:(id)sender {
    UIButton *selection = sender;
    NSString *change = [[selection attributedTitleForState:UIControlStateNormal] string];

    if ([change isEqualToString:@"Underline"]) {
        [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)} ];
    }
    if ([change isEqualToString:@"No Underline"])
    {
        [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)} ];
    }
}

- (IBAction)changeSelectedWordColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{ NSForegroundColorAttributeName : sender.backgroundColor}];
}


-(NSArray *)wordList
{
    NSArray *wordList = [[self.messageLabel.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([wordList count])
    {
        return wordList;
    } else {
        return @[@""];
    }
}

-(NSString *)selectedWord
{
    return [self wordList][(int)self.selectedWordStepper.value];
}

- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList] count] - 1;
    self.selectedWordLabel.text = [self selectedWord];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSelectedWord];
}


@end
