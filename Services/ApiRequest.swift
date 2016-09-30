//
//  ApiRequest.swift
//  AppyStoreBLZ
//
//  Created by Shelly on 01/08/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import Alamofire

class ApiRequest: NSObject {
    let utilityObj = Utility()
    //Getting the info plist
    let infoPlist = NSBundle.mainBundle().infoDictionary
    
    let header = [
        "X_APPY_IMEI" : "353368070301951",
        "X_APPY_USERID" : "290903782",
        "X_APPY_UTYPE" : "O",
        "X_APPY_UserAgent" : "Mozilla/5.0 (Linux; Android 5.0.2; Panasonic ELUGA Switch Build/LRX22G; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/51.0.2704.81 Mobile Safari/537.36",
        "X_APPY_ANDROID_ID" : "97493b2405dcfbcf",
        "X_APPY_VERSION" : "7",
        "X_APPY_API_KEY" : "gh610rt23eqwpll",
        "X_APPY_DEVICE_WIDTH" : "1794",
        "X_APPY_DEVICE_HEIGHT" : "1080",
        "X_APPY_CAMPAIGN_ID" : "8700441600",
        "X_APPY_PCP_ID" : "999"
        ]
    
    func mFetchCategoryList() {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET, "\(url)method=getCategoryList&content_type=videos&limit_start=0&age=1.5&incl_age=5", headers: header)
                .responseJSON { response in
                    
                    let APIresponseObj = APIResponse()
                    APIresponseObj.mParseCategoryDetails(response.result.value as! [String : AnyObject])
            }
        }
    }
    
    //method to fetch sub category list
    func mFetchSubCategoryList(c_Id : Int,p_Id : Int,offset : Int) {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET, "\(url)method=getContentList&content_type=videos&limit=20&offset=\(offset)&catid=\(c_Id)&pcatid=\(p_Id)&age=1.5&incl_age=5", headers: header)
                .responseJSON { response in
                    if(response.result.value != nil){
                        
                        let APIresponseObj = APIResponse()
                        APIresponseObj.mParseSubCategoryDetails(response.result.value as! [String : AnyObject])
                    }
                    else{
                        print("Error")
                    }
            }
        }
    }
    
    //method to fetch search details list
    func mFetchSearchDetails(controllerObj : PController,keyword : String , offset : Int)  {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET, "\(url)method=search&keyword=\(keyword)&content_type=videos&limit=12&offset=\(offset)&age=1&incl_age=6", headers: header)
                .responseJSON { response in
                    if(response.result.value != nil){
                        let APIresponseObj = APIResponse()
                        APIresponseObj.mParseSearchCategoryList(controllerObj,response: response.result.value as! [String : AnyObject])
                    }
                    else{
                        print("Error")
                    }
            }
        }
    }
    //method to fetch parent categories
    func mFetchParentCategories(controllerObj : Controller) {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET, "\(url)method=getParentingCategories", headers: header)
                .responseJSON { response in
                    
                    let APIresponseObj = APIResponse()
                    APIresponseObj.mParseParentCategories(controllerObj, response :response.result.value as! [String : AnyObject])
            }
        }
    }
    //method to fetch parenting sub categories
    func mFetchSubParentingCategories(c_Id : Int,p_Id : Int,offset : Int) {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET,
                "\(url)method=getParentingVideos&content_type=videos&limit=20&offset=\(offset)&catid=\(c_Id)&pcatid=\(p_Id)",
                headers: header)
                .responseJSON { response in
                    if(response.result.value != nil){
                        let APIresponseObj = APIResponse()
                        APIresponseObj.mParseParentSubCategoryDetails(response.result.value as! [String : AnyObject])
                    }
                    else{
                        
                        print("Error")
                    }
            }
        }
    }
    
    //method to fetch avatar list
    func mFetchAvatarList() {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET,"\(url)method=getAvatarList",headers: header)
                .responseJSON { response in
                    if(response.result.value != nil){
                        let APIresponseObj = APIResponse()
                        APIresponseObj.mParseAvatarList(response.result.value as! [String : AnyObject])
                    }
                    else{
                        
                        print("Error")
                    }
            }
        }
    }
    
    //method to Register a child
    func mRegisterChild(name: String , dob: String , avatarId: Int) {
        if self.utilityObj.isinternetAvailable(){
            //getting url from info.plist
            let url = infoPlist!["Web_Url"] as! String
            
            Alamofire.request(.GET,"\(url)method=register&child_name=\(name)&child_dob=\(dob)&child_avtarid=\(avatarId)",headers: header)
                .responseJSON { response in
                    if(response.result.value != nil){
                        let APIresponseObj = APIResponse()
                        APIresponseObj.mRegistrationRespone(response.result.value as! [String : AnyObject])
                    }
                    else{
                        
                        print("Error")
                    }
            }
        }
    }
}
