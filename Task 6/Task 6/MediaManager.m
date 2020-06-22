//
//  MediaManager.m
//  Task 6
//
//  Created by Антон Потапчик on 6/22/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "MediaManager.h"
#import <Photos/Photos.h>

@interface MediaManager ()

@end

@implementation MediaManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)downloadAsset:(PHAsset *)asset toURL:(NSURL *)url completion:(void (^)(void))completion
{
    if (asset.mediaType == PHAssetMediaTypeImage && (asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive))
    {
        PHLivePhotoRequestOptions *options = [PHLivePhotoRequestOptions new];
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestLivePhotoForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeAspectFill options:options resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
            if ([info objectForKey:PHImageErrorKey] == nil)
            {
                NSData *livePhotoData = [NSKeyedArchiver archivedDataWithRootObject:livePhoto requiringSecureCoding:NO error:nil];
                if ([[NSFileManager defaultManager] createFileAtPath:url.path contents:livePhotoData attributes:nil])
                {
                    NSLog(@"downloaded live photo:%@", url.path);
                    completion();
                }
            }
        }];
    }
    else if (asset.mediaType == PHAssetMediaTypeImage)
    {
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            if ([info objectForKey:PHImageErrorKey] == nil
                && [[NSFileManager defaultManager] createFileAtPath:url.path contents:imageData attributes:nil])
            {
                NSLog(@"downloaded photo:%@", url.path);
                completion();
            }
        }];
    }
    else if (asset.mediaType == PHAssetMediaTypeVideo)
    {
        PHVideoRequestOptions *options = [PHVideoRequestOptions new];
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestExportSessionForVideo:asset options:options exportPreset:AVAssetExportPresetHighestQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
            if ([info objectForKey:PHImageErrorKey] == nil)
            {
                exportSession.outputURL = url;

                NSArray<PHAssetResource *> *resources = [PHAssetResource assetResourcesForAsset:asset];
                for (PHAssetResource *resource in resources)
                {
                    exportSession.outputFileType = resource.uniformTypeIdentifier;
                    if (exportSession.outputFileType != nil)
                        break;
                }

                [exportSession exportAsynchronouslyWithCompletionHandler:^{
                    if (exportSession.status == AVAssetExportSessionStatusCompleted)
                    {
                        NSLog(@"downloaded video:%@", url.path);
                        completion();
                    }
                }];
            }
        }];
    }
}

@end
