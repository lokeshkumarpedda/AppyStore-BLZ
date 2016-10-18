//
//  Utility.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 06/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import ReactiveKit
import Alamofire
import AVKit
import AVFoundation
import SystemConfiguration
import AlamofireImage


class Utility: NSObject {
    
    var mVideoPlayer : AVPlayer!
    var mPlayerViewController : AVPlayerViewController!
    let imageCache = AutoPurgingImageCache()
    var backgroundMusicPlayer: AVAudioPlayer?

    //fetch image from string url
    func fetchImage(url : String) -> Operation<UIImage, NSError> {
        return Operation { observe in
            let request = Alamofire.request(.GET, NSURL(string: "")!).response { request, response, data, error in
                if data != nil {
                    observe.next(UIImage(data: data!)!)
                    observe.success()
                }
                else {
                    observe.next(UIImage(named: "Video-Icon-crop.png")!)
                    observe.success()
                }
            }
            return BlockDisposable {
                //request.cancel()
            }
        }
    }
    
    func mBindCollectionViewCell(cell : CollectionViewCell , subCategory : SubCategorylist) {
        let blank = UIImage(named: "loading_img")
        cell.VideoImageView.image = blank
        let image = subCategory.imageUrl
        
        //setting layout for image view inside cell
        cell.VideoImageView.image = UIImage(named: "angry_birds_space_image_rectangular_box")
        cell.VideoImageView.layer.cornerRadius = 8
        cell.VideoImageView.clipsToBounds = true
        cell.VideoImageView.layer.borderWidth = 2
        cell.VideoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        //setting video duration
        if subCategory.duration.value != ""{
            let duration = Int(subCategory.duration.value)
            if duration != nil{
                let sec = duration!%60 < 10 ? "0\(duration!%60)" : "\(duration!%60)"
                let min = duration!/60 < 10 ? "0\(duration!/60)" : "\(duration!/60)"
                cell.VideoDurationLabel.text = "\(min) : \(sec)"
                cell.VideoDurationLabel.backgroundColor = UIColor(patternImage: UIImage(named: "videos_categories_play__tranparent_box")!)
            }
        }

        //activity indicator
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.color = UIColor.whiteColor()
        
        cell.VideoLabel.text = subCategory.title.value
        cell.imgUrl = image
        
        //checking image is in cache or not
        if let cachedImage = imageCache.imageWithIdentifier(image!){
            cell.VideoImageView.image = cachedImage
        }
        else{
            Alamofire.request(NSURLRequest(URL: NSURL(string: image!)!)).responseImage{
                response in
                if let img = response.result.value{
                    self.imageCache.addImage(img, withIdentifier: image!)
                    if cell.imgUrl == image{
                        cell.VideoImageView.image = img
                    }
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    //method to bind collection view cell and view model
    func mBindTo(cell : CollectionViewCell , list : SubCategorylist) {
        list.title.bindTo(cell.VideoLabel)
        
        cell.activityIndicator.startAnimating()
        Alamofire.request(.GET, NSURL(string: list.imageUrl!)!).response { request, response, data, error in
            if data != nil {
                if cell.imgUrl == list.imageUrl {
                    cell.VideoImageView.image = UIImage(data: data!)
                    cell.VideoImageView.layer.cornerRadius = 5.0;
                }
                cell.activityIndicator.hidden = true
                cell.activityIndicator.stopAnimating()
            }
        }
    }

    //method to check internet connection
    func isinternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
    }
    
    //For activity indicator display and animation
    func showActivityIndicator(activity : UIActivityIndicatorView , view : UIView) -> UIActivityIndicatorView{
        //customizing activity indicator
        activity.frame = CGRectMake(0, 0, 50, 50)
        activity.center = view.center
        activity.activityIndicatorViewStyle = .White
        activity.clipsToBounds = true
        activity.hidesWhenStopped = true
        view.addSubview(activity)
        
        return activity
    }
  }
