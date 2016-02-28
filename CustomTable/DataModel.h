//
//  DataModel.h
//  DataNodeApp
//
//  Created by Thiago Guimaraes on 11/10/15.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DataModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface DataModel : NSObject <NSURLConnectionDataDelegate>

 
@property (nonatomic, weak) id<DataModelProtocol> delegate;

- (void)downloadItems;

@end
