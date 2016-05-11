//
//  WebServiceHelper.swift
//  Boozehound
//
//  Created by MAC-186 on 12/21/15.
//  Copyright © 2015 MoveoApps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class WebServiceHelper: NSObject
{

    typealias SuccessHandler = (JSON) -> Void
    typealias FailureHandler = (NSError) -> Void
    var afManager: Alamofire.Manager!
    // MARK: - Helper Methods
    
    class func getWebServiceCall(strURL : String, isShowLoader : Bool, success : SuccessHandler, failure : FailureHandler){
        
        if isShowLoader == true {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
        }
        
        Alamofire.request(.GET, strURL).responseJSON { (resObj) -> Void in
            print(resObj)
            if resObj.result.isSuccess {
                let resJson = JSON(resObj.result.value!)
                
                if isShowLoader == true {
                    if PKHUD.sharedHUD.isVisible {
                        PKHUD.sharedHUD.hide(animated: true, completion: nil)
                    }
                }
                
                success(resJson)
            }
            if resObj.result.isFailure {
                let error : NSError = resObj.result.error!
                
                if isShowLoader == true {
                    if PKHUD.sharedHUD.isVisible {
                        PKHUD.sharedHUD.hide(animated: true, completion: nil)
                    }
                }
                
                failure(error)
            }
        }
        
                
    }
    
    class func getWebServiceCall(strURL : String, params : [String : AnyObject]?, isShowLoader : Bool, success : SuccessHandler, failure : FailureHandler){
        
        if isShowLoader == true {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
        }
        
        Alamofire.request(.GET, strURL, parameters: params, encoding: ParameterEncoding.URL, headers: ["PC-API-KEY" : Constants.APIKEY]).responseJSON { (resObj) -> Void in
            print(resObj)
            if resObj.result.isSuccess {
                let resJson = JSON(resObj.result.value!)
                
                if isShowLoader == true {
                    if PKHUD.sharedHUD.isVisible {
                        PKHUD.sharedHUD.hide(animated: true, completion: nil)
                    }
                }
                
                success(resJson)
            }
            if resObj.result.isFailure {
                let error : NSError = resObj.result.error!
                
                if isShowLoader == true {
                    if PKHUD.sharedHUD.isVisible {
                        PKHUD.sharedHUD.hide(animated: true, completion: nil)
                    }
                }
                
                failure(error)
            }
        }
    }
    
    class func postWebServiceCall(strURL : String, activityMessage : String, params : [String : AnyObject]?, isShowLoader : Bool, success : SuccessHandler, failure : FailureHandler)
    {
        if isShowLoader == true
        {
            PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "", subtitle: activityMessage)
            PKHUD.sharedHUD.show()
        }
        
        let manager = Alamofire.Manager.sharedInstance
        manager.request(.POST, strURL, parameters: params, encoding: ParameterEncoding.JSON, headers: ["PC-API-KEY" : Constants.APIKEY]).responseJSON { (resObj) -> Void in
            print(resObj)
            
            if resObj.result.isSuccess
            {
                let resJson = JSON(resObj.result.value!)
                
                if isShowLoader == true
                {
                    if PKHUD.sharedHUD.isVisible
                    {
                        PKHUD.sharedHUD.hide(animated: false, completion: nil)
                    }
                }
                
                success(resJson)
            }
            
            if resObj.result.isFailure
            {
                let error : NSError = resObj.result.error!
                
                if isShowLoader == true
                {
                    if PKHUD.sharedHUD.isVisible
                    {
                        PKHUD.sharedHUD.hide(animated: false, completion: nil)
                    }
                }
                
                failure(error)
            }
        }
    }
    
    class func postWebServiceCallWithImage(strURL : String, activityMessage : String, image : UIImage!, params : [String : AnyObject]?, isShowLoader : Bool, success : SuccessHandler, failure : FailureHandler) {
        
        if isShowLoader == true
        {
            PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "", subtitle: activityMessage)
            PKHUD.sharedHUD.show()
        }
        
        let manager = Alamofire.Manager.sharedInstance
        manager.upload(.POST, strURL, headers: ["PC-API-KEY" : Constants.APIKEY], multipartFormData: {
            multipartFormData in
            
            if let _image = image {
                if let imageData = UIImageJPEGRepresentation(_image, 0.5) {
                    multipartFormData.appendBodyPart(data: imageData, name: "userimage", fileName: NSDate.timeIntervalSinceReferenceDate().description+".jpg", mimeType: "image/jpg")
                }
            }
            
            for (key, value) in params! {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                    case .Success(let upload, _, _):
                        upload.responseJSON { (response) -> Void in
                            
                            if response.result.isSuccess
                            {
                                let resJson = JSON(response.result.value!)
                                
                                if isShowLoader == true
                                {
                                    if PKHUD.sharedHUD.isVisible
                                    {
                                        PKHUD.sharedHUD.hide(animated: false, completion: nil)
                                    }
                                }
                                
                                success(resJson)
                            }
                            
                            if response.result.isFailure
                            {
                                let error : NSError = response.result.error!
                                
                                if isShowLoader == true
                                {
                                    if PKHUD.sharedHUD.isVisible
                                    {
                                        PKHUD.sharedHUD.hide(animated: false, completion: nil)
                                    }
                                }
                                
                                failure(error)
                            }
                            
                        }
                    case .Failure(let encodingError):
                        if isShowLoader == true
                        {
                            if PKHUD.sharedHUD.isVisible
                            {
                                PKHUD.sharedHUD.hide(animated: false, completion: nil)
                            }
                        }
                        
                        let error : NSError = encodingError as NSError
                        failure(error)
                }
        })
    }
}

