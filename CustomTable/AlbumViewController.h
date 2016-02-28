//
//  AlbumViewController.h
//  CustomTableView
//
//  Created by Thiago Guimaraes on 2/23/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDataModel.h"
@interface AlbumViewController: UITableViewController<UITableViewDataSource, UITableViewDelegate, AlbumDataModelProtocol>


@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
