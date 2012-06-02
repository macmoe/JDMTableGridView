//
//  JDMTableGridViewController.m
//  TableGrid
//
//  Created by Jeff Morris on 6/1/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "JDMTableGridViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface JDMTableGridViewController ()
@property (nonatomic,retain) JDMTableGridView *tableGridView;
@property int columns;
@property int rows;
@end

@implementation JDMTableGridViewController

@synthesize tableGridView;
@synthesize columns;
@synthesize rows;

////////////////////////////////////////////////////////////////////////////////////////////////
// Private

- (UILabel*)createLabelWithSize:(CGSize)size withText:(NSString*)text andColor:(UIColor*)color {
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)] autorelease];
    [lbl setText:text];
    [lbl setTextAlignment:UITextAlignmentCenter];
    [lbl setBackgroundColor:color];
    [lbl setNumberOfLines:2];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [lbl setFont:[UIFont systemFontOfSize:8.0f]];
        [lbl setMinimumFontSize:8.0f];
    } else {
        [lbl setFont:[UIFont systemFontOfSize:16.0f]];
        [lbl setMinimumFontSize:10.0f];
    }
    [[lbl layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[lbl layer] setBorderWidth:1.0f];
    return lbl;
}

- (void)addRow:(id)sender {
    [self setRows:[self rows]+1];
//    [[self tableGridView] insertLeftCellForRow:[self rows]-1];
    [[self tableGridView] reload];
}

- (void)delRow:(id)sender {
    [self setRows:[self rows]-1];
    if ([self rows]<0) [self setRows:0];
//    [[self tableGridView] deleteLeftCellForRow:[self rows]];
    [[self tableGridView] reload];
}

- (void)addCol:(id)sender {
    [self setColumns:[self columns]+1];
//    [[self tableGridView] deleteHeaderForColumn:[self columns]-1];
    [[self tableGridView] reload];
}

- (void)delCol:(id)sender {
    [self setColumns:[self columns]-1];
    if ([self columns]<0) [self setColumns:0];
//    [[self tableGridView] deleteHeaderForColumn:[self columns]];
    [[self tableGridView] reload];
}

////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
    [tableGridView release];
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Table Grid Demo"];
    
    [self setColumns:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? 15 : 20];
    [self setRows:(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? 15 : 20];
    
    NSArray *toolBarItems = [NSArray arrayWithObjects:
                             [[[UIBarButtonItem alloc] initWithTitle:@"+ Row" style:UIBarButtonItemStyleBordered target:self action:@selector(addRow:)] autorelease],
                             [[[UIBarButtonItem alloc] initWithTitle:@"- Row" style:UIBarButtonItemStyleBordered target:self action:@selector(delRow:)] autorelease],
                             [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                             [[[UIBarButtonItem alloc] initWithTitle:@"+ Col" style:UIBarButtonItemStyleBordered target:self action:@selector(addCol:)] autorelease],
                             [[[UIBarButtonItem alloc] initWithTitle:@"- Col" style:UIBarButtonItemStyleBordered target:self action:@selector(delCol:)] autorelease],
                             nil];
    [self setToolbarItems:toolBarItems animated:YES];
    [[self navigationController] setToolbarHidden:NO];
    
    [self setTableGridView:[[[JDMTableGridView alloc] initWithFrame:self.view.bounds] autorelease]];
    [[self tableGridView] setTableGridDelegate:self];
    [[self tableGridView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [[self view] addSubview:[self tableGridView]];
    
//    [[self tableGridView] allowBouncing:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////
// TableGridViewDelegate

- (NSInteger)numberOfColumns {
    return [self columns];
}

- (NSInteger)numberOfRows {
    return [self rows];
}

- (CGSize)sizeOfHeaderCell {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        return CGSizeMake(25,35);
    }
    return CGSizeMake(50,75);
}

- (CGSize)sizeOfLeftCell {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        return CGSizeMake(50,25);
    }
    return CGSizeMake(100,50);
}

- (UIView *)topLeftFloaterViewForTableGridView:(JDMTableGridView *)tgv {
    return [self createLabelWithSize:CGSizeMake(25,25) withText:@"TL.Header" andColor:[UIColor darkGrayColor]];
}

- (UIView *)tableGridView:(JDMTableGridView *)tgv viewForHeaderForColumn:(NSInteger)col {
    return [self createLabelWithSize:CGSizeMake(25,25) withText:[NSString stringWithFormat:@"%d",col] andColor:[UIColor redColor]];
}

- (UIView *)tableGridView:(JDMTableGridView *)tgv viewForLeftCellForRow:(NSInteger)row {
    return [self createLabelWithSize:CGSizeMake(25,25) withText:[NSString stringWithFormat:@"%d",row] andColor:[UIColor orangeColor]];
}

- (UIView *)tableGridView:(JDMTableGridView *)tgv viewForCellWithIndex:(CGPoint)index {
    return [self createLabelWithSize:CGSizeMake(25,25) withText:[NSString stringWithFormat:@"%0.0f,%0.0f",index.x,index.y] andColor:[UIColor whiteColor]];
}

// Optional methods for TableGridViewDelegate

- (CGFloat)heightOfFooterCell {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        return 25.0f;
    }
    return 50.0f;
}

- (UIView *)bottomLeftFloaterViewForTableGridView:(JDMTableGridView *)tgv {
    return [self createLabelWithSize:CGSizeMake(25,25) withText:@"BL.Header" andColor:[UIColor greenColor]];
}

- (UIView *)tableGridView:(JDMTableGridView *)tgv viewForFooterForColumn:(NSInteger)col {
    return [self createLabelWithSize:CGSizeMake(25,25) withText:[NSString stringWithFormat:@"%d",col] andColor:[UIColor yellowColor]];
}

@end
