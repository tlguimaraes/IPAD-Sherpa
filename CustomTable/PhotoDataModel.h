//
//  AlbumDataModel.h
//  AlbumNodeApp
//
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sherpa.h"

@protocol PhotoDataModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface PhotoDataModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) Sherpa *sherpa;
@property (nonatomic, weak) id<PhotoDataModelProtocol> delegate;

- (void)downloadItems;

@end
