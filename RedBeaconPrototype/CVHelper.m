//
//  CVHelper.m
//  tipGrabber
//
//  Created by sadmin on 2/17/13.
//  Copyright (c) 2013 Terry Lewis II. All rights reserved.
//

#import "CVHelper.h"
#import "CVCell.h"

@implementation CVHelper

-(id)init{
    self = [super init];
    if(self)
    {
       
    }
    return self;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    

    return self.localProducts.allKeys.count;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CVCell * cell = [collectionView
                                   dequeueReusableCellWithReuseIdentifier:@"collectionCellId" forIndexPath:indexPath];
    //Cell Id is declared in the user interface
    
    if(cell == nil)
    {
        NSLog(@" Cell Doesn't exist ");
    }

    cell.icon.backgroundColor = [UIColor lightGrayColor];
    cell.icon.alpha = 0.9;
    
    
    //getting information about icon from json file.
        NSString * imgName = [[self.localProducts objectForKey:@""]objectForKey:@"icon"];
        UIImage * img = [UIImage imageNamed:imgName];
        if(img)
        {
            cell.icon.image = img;
        }
        else{
            NSLog(@"Error. Icon for this cell doesn't exist");
        }
    return cell;
}


@end
