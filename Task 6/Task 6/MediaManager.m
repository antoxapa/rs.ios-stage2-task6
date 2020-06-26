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

- (void)downloadAsset:(PHAsset *)asset completion:(void (^)(MediaObject *object))completion
{
    if (asset.mediaType == PHAssetMediaTypeImage)
    {
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        if (@available(iOS 13, *)) {
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
                NSString *objectSize = [NSString stringWithFormat:@"%lux%lu", (unsigned long)asset.pixelHeight,  (unsigned long)asset.pixelWidth];
                
                MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
                completion(imageObject);
            }];
        } else {
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage *result, NSDictionary *info) {
                
                UIImage *image = result;
                NSString *objectName = [asset valueForKey:@"filename"];
                NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
                NSString *objectType = @"Image";
                
                NSDateFormatter* df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
                NSString *creationDate = [df stringFromDate:asset.creationDate];
                NSString *modificationDate = [df stringFromDate:asset.creationDate];
                NSString *objectSize = [NSString stringWithFormat:@"%lux%lu",  (unsigned long)asset.pixelHeight,  (unsigned long)asset.pixelWidth];
                
                MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
                completion(imageObject);
            }];
        }
    }
    else if (asset.mediaType == PHAssetMediaTypeVideo)
    {
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        if (@available(iOS 13, *)) {
            [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                NSString *objectName = [asset valueForKey:@"filename"];
                NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
                NSString *objectType = @"Video";
                
                NSDateFormatter* df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
                NSString *creationDate = [df stringFromDate:asset.creationDate];
                NSString *modificationDate = [df stringFromDate:asset.creationDate];
                NSString *objectSize = [NSString stringWithFormat:@"%lux%lu",  (unsigned long)asset.pixelHeight,  (unsigned long)asset.pixelWidth];
                
                MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
                completion(imageObject);
            }];
        } else {
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *result, NSDictionary *info) {
                UIImage *image = result;
                NSString *objectName = [asset valueForKey:@"filename"];
                NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
                NSString *objectType = @"Video";
                
                NSDateFormatter* df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
                NSString *creationDate = [df stringFromDate:asset.creationDate];
                NSString *modificationDate = [df stringFromDate:asset.creationDate];
                NSString *objectSize = [NSString stringWithFormat:@"%lux%lu",  (unsigned long)asset.pixelHeight,  (unsigned long)asset.pixelWidth];
                
                MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
                completion(imageObject);
            }];
        }
    } else if(asset.mediaType == PHAssetMediaTypeAudio) {
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        if (@available(iOS 13, *)) {
            [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, CGImagePropertyOrientation orientation, NSDictionary *info) {
                
                UIImage *image = [UIImage imageNamed:@"audio"];
                NSString *objectName = [asset valueForKey:@"filename"];
                NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
                NSString *objectType = @"Audio";
                
                NSDateFormatter* df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
                NSString *creationDate = [df stringFromDate:asset.creationDate];
                NSString *modificationDate = [df stringFromDate:asset.creationDate];
                NSString *objectSize = @"";
                
                MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
                completion(imageObject);
            }];
        } else {
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(1000, 1000) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *result, NSDictionary *info) {
                UIImage *image = [UIImage imageNamed:@"audio"];
                NSString *objectName = [asset valueForKey:@"filename"];
                NSString *objectDuration = [NSString stringWithFormat:@"%f",asset.duration];
                NSString *objectType = @"Audio";
                
                NSDateFormatter* df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
                NSString *creationDate = [df stringFromDate:asset.creationDate];
                NSString *modificationDate = [df stringFromDate:asset.creationDate];
                NSString *objectSize = @"";
                
                MediaObject *imageObject = [[MediaObject alloc]initWithInfo:image objectName:objectName objectDuration:objectDuration objectType:objectType creationDate:creationDate modificationDate:modificationDate objectSize:objectSize];
                completion(imageObject);
            }];
        }
    } else if(asset.mediaType == PHAssetMediaTypeUnknown) {
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.networkAccessAllowed = YES;
        
        if (@available(iOS 13, *)) {
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
        } else {
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *result, NSDictionary *info) {
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
}

@end
