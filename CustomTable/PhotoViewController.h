//
//  PhotoViewController.h
//  CustomTableView
//
//  Created by Thiago Guimaraes on 2/23/16.
//  Copyright (c) 2015 ThiagoGuimaraes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDataModel.h"
#import "Sherpa.h"
@interface PhotoViewController: UITableViewController<UITableViewDataSource, UITableViewDelegate, PhotoDataModelProtocol>
@property (strong, nonatomic) IBOutlet UITableView *listTableViewPhoto;
@property (nonatomic, strong) Sherpa *sherpa;



@end
