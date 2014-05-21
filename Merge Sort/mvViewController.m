//
//  mvViewController.m
//  Merge Sort
//
//  Created by Matthew Voss on 5/21/14.
//  Copyright (c) 2014 matt. All rights reserved.
//

#import "mvViewController.h"

@interface mvViewController ()

@end

@implementation mvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *numbers = [NSMutableArray new];
    
    //create an array of random numbers
    for (int i = 0; i < 100; i++) {
        [numbers addObject:[NSNumber numberWithInt:arc4random_uniform(10000)]];
    }
    
    NSLog(@"%@", numbers);
    
    //send the array to be sorted and get the results
    NSArray *sortedNumbers = [self mergeSort:numbers];
    
    NSLog(@"%@", sortedNumbers);
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)mergeSort:(NSArray *)unsortedArray
{
    //if there is only one item in array return it, it is sorted
    if ([unsortedArray count] < 2)
    {
        return unsortedArray;
    }
    
    //the midway point in the current unsorted array
    int middle = ([unsortedArray count] / 2);
    
    /*  created the ranges that will be used when you split the     */
    /*  current array in half for sorting                           */
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
    
    //creat the subarrays to be sorted
    NSArray *rightArr = [unsortedArray subarrayWithRange:right];
    NSArray *leftArr = [unsortedArray subarrayWithRange:left];
    
    //sort them merge the created subarrays
    return [self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr
{
    //a new array to hold the results of the merging of the two arrays
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    //index of item in array
    int right = 0;
    int left = 0;
    
    //test to make sure the index isnt beyond bounds
    while (left < [leftArr count] && right < [rightArr count])
    {
        //test to see which value is less and then add it to the array and incrament the corrisponding index
        if ([[leftArr objectAtIndex:left] integerValue] < [[rightArr objectAtIndex:right] integerValue])
        { [result addObject:[leftArr objectAtIndex:left++]]; }
        else
        { [result addObject:[rightArr objectAtIndex:right++]]; }
    }
    
    //create the ranges for any parts left in the current unmerged arrays
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    
    //create an array from the arrays left overs
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    
    //if the arrays have objects add them to the merged array and returnb
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}
@end
