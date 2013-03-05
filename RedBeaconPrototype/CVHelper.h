//
//  CVHelper.h
//  tipGrabber
//
//  Created by sadmin on 2/17/13.
//  Copyright (c) 2013 Terry Lewis II. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVHelper : NSObject <UICollectionViewDataSource,UICollectionViewDelegate>
    @property(nonatomic,strong)NSArray * products;
    @property(nonatomic,strong)NSDictionary* localProducts;

@end
