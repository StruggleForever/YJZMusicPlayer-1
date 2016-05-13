//
//  TableViewController.m
//  YJZMusicPlayer
//
//  Created by 颜镜圳 on 16/5/12.
//  Copyright © 2016年 颜镜圳. All rights reserved.
//

#import "TableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TableViewCell.h"

@interface TableViewController ()

@property (strong, nonatomic) MPMusicPlayerController *musicPlayer;
@property (strong, nonatomic) NSMutableArray *musicArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.musicPlayer = [MPMusicPlayerController systemMusicPlayer];
    [self getMusicListFromMusicLibrary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MPMediaItemCollection *)getMusicListFromMusicLibrary {
    MPMediaQuery *mediaQueue = [MPMediaQuery songsQuery];
    // 申明一个Collection便于下面给MusicPlayer赋值
    MPMediaItemCollection *mediaItemCollection;
    if (mediaQueue.items.count == 0) {
        return 0;
    } else {
        //获取本地音乐库文件
        self.musicArray= [NSMutableArray array];
        for(MPMediaItem *item in mediaQueue.items) {
            [self.musicArray addObject:item];
            NSLog(@"%@",item.title);
        }
        
        // 将音乐信息赋值给musicPlayer
        mediaItemCollection = [[MPMediaItemCollection alloc] initWithItems:[self.musicArray copy]];
        [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    }
    
    return mediaItemCollection;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"musicListCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    MPMediaItem *item = self.musicArray[indexPath.row];
    NSString *musicName = [item valueForKey:MPMediaItemPropertyTitle];
    NSString *musicSinger = [item valueForKey:MPMediaItemPropertyAlbumArtist];
    // 专辑图片
    MPMediaItemArtwork *artwork= [item valueForKey:MPMediaItemPropertyArtwork];
    UIImage *image=[artwork imageWithSize:CGSizeMake(100, 100)];
    
    cell.musicImageView.image = image;
    cell.musicTitleLabel.text = musicName;
    cell.musicSingerLabel.text = musicSinger;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
