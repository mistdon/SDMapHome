//
//  BookExtension.swift
//  SDMapHome
//
//  Created by Allen on 16/4/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImage {
    func resizeToSize(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
}

extension UIImageView{
    func setResizeImageWith(urlString: String,width:CGFloat)  {
        let url = NSURL(string: urlString)
        let key = SDWebImageManager.sharedManager().cacheKeyForURL(url) ?? ""
        if var cacheImage = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key) {
            if cacheImage.size.width > width {
                let size = CGSizeMake(width, cacheImage.size.height * (width / cacheImage.size.width))
                cacheImage = cacheImage.resizeToSize(size)
                
            }
            self.image = cacheImage
        }else{
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(url, options: SDWebImageDownloaderOptions.AllowInvalidSSLCertificates, progress: nil, completed: { (var  image, data, error, result) in
                if image != nil && image.size.width > width{
                    let size = CGSizeMake(width, image.size.height * (width / image.size.width))
                    image = image.resizeToSize(size)
                }
                self.image = image
            })
        }
    }
}
