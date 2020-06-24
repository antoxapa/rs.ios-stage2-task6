//
//  MediaManager.m
//  Task 6
//
//  Created by Антон Потапчик on 6/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "MediaManager.h"
#import <Photos/Photos.h>
#import "MediaObject.h"


@interface MediaManager ()
@end

@implementation MediaManager

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)downloadAsset:(PHAsset *)asset completion:(void (^)(MediaObject *object))completion
{
//    if (asset.mediaType == PHAssetMediaTypeImage && (asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive))
//    {
//        PHLivePhotoRequestOptions *options = [PHLivePhotoRequestOptions new];
//        options.networkAccessAllowed = YES;
//        [[PHImageManager defaultManager] requestLivePhotoForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeAspectFill options:options resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
//            if ([info objectForKey:PHImageErrorKey] == nil)
//            {
//
//                completion();
////                NSData *livePhotoData = [NSKeyedArchiver archivedDataWithRootObject:livePhoto requiringSecureCoding:NO error:nil];
//
////                if ([[NSFileManager defaultManager] createFileAtPath:url.path contents:livePhotoData attributes:nil])
////                {
////                    NSLog(@"downloaded live photo:%@", url.path);
////                    completion();
////                }
//            }
//        }];
//    }
//    else
        if (asset.mediaType == PHAssetMediaTypeImage)
    {
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;

        [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
//            NSLog(@"image");
        
            UIImage *image = [UIImage imageWithData:imageData];
            NSString *objectName = [asset valueForKey:@"filename"];
            NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
            NSString *objectType = @"Image";
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
            NSString *creationDate = [df stringFromDate:asset.creationDate];
            NSString *modificationDate = [df stringFromDate:asset.creationDate];
            NSString *objectSize = [NSString stringWithFormat:@"%lux%lu", asset.pixelHeight, asset.pixelWidth];
            
            MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
            completion(imageObject);
        }];
    }
    else if (asset.mediaType == PHAssetMediaTypeVideo)
    {
        PHVideoRequestOptions *videoOptions = [PHVideoRequestOptions new];
//        options.networkAccessAllowed = YES;
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
        
            UIImage *image = [UIImage imageWithData:imageData];
            NSString *objectName = [asset valueForKey:@"filename"];
            NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
            NSString *objectType = @"Video";
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
            NSString *creationDate = [df stringFromDate:asset.creationDate];
            NSString *modificationDate = [df stringFromDate:asset.creationDate];
            NSString *objectSize = [NSString stringWithFormat:@"%lux%lu", asset.pixelHeight, asset.pixelWidth];
            
            MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
            completion(imageObject);
        }];
        
        
//        [[PHImageManager defaultManager]requestPlayerItemForVideo:asset options:videoOptions resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
//            AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
////            player.currentItem.
//
//        }];
        
//        [[PHImageManager defaultManager]requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
//            if ([info objectForKey:PHImageErrorKey] == nil)
//            {
//
//
//            }
//        }];
//        [[PHImageManager defaultManager] requestExportSessionForVideo:asset options:options exportPreset:AVAssetExportPresetHighestQuality resultHandler:^(AVAssetExportSession *exportSession, NSDictionary *info) {
//            if ([info objectForKey:PHImageErrorKey] == nil)
//            {
//                exportSession.outputURL = url;
//
//                NSArray<PHAssetResource *> *resources = [PHAssetResource assetResourcesForAsset:asset];
//                for (PHAssetResource *resource in resources)
//                {
//                    exportSession.outputFileType = resource.uniformTypeIdentifier;
//                    if (exportSession.outputFileType != nil)
//                        break;
//                }
//
//                [exportSession exportAsynchronouslyWithCompletionHandler:^{
//                    if (exportSession.status == AVAssetExportSessionStatusCompleted)
//                    {
//                        NSLog(@"downloaded video:%@", url.path);
//                        completion();
//                    }
//                }];
//            }
//        }];
    } else if(asset.mediaType == PHAssetMediaTypeAudio) {
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
        
            UIImage *image = [UIImage imageNamed:@"audio"];
            NSString *objectName = [asset valueForKey:@"filename"];
            NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
            NSString *objectType = @"Audio";
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
            NSString *creationDate = [df stringFromDate:asset.creationDate];
            NSString *modificationDate = [df stringFromDate:asset.creationDate];
            NSString *objectSize = [NSString stringWithFormat:@"%lux%lu", asset.pixelHeight, asset.pixelWidth];
            
            MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
            completion(imageObject);
        }];
    } else if(asset.mediaType == PHAssetMediaTypeUnknown) {
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
        
            UIImage *image = [UIImage imageNamed:@"other"];
            NSString *objectName = [asset valueForKey:@"filename"];
            NSString *objectDuration = @"";
            NSString *objectType = @"Other";
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
            NSString *creationDate = [df stringFromDate:asset.creationDate];
            NSString *modificationDate = [df stringFromDate:asset.creationDate];
            NSString *objectSize = @"";
            
            MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
            completion(imageObject);
        }];
    }
}

@end
