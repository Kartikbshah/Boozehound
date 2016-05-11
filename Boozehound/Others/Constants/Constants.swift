//
//  Constants.swift
//  Boozehound
//
//  Created by MAC-186 on 2/5/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import Foundation

class Constants {
    
    // MARK: - User Types
    
    static let UserTypeBoozehound       = "Boozehound" //2
    static let UserTypeBartender        = "Bartender" //1
    
    static let UserTypeBoozehoundValue  = "2"
    static let UserTypeBartenderValue   = "1"
    
    // MARK: - Font constants
    
    static let FontDosisBold            = "Dosis-Bold"
    static let FontDosisExtraBold       = "Dosis-ExtraBold"
    static let FontDosisExtraLight      = "Dosis-ExtraLight"
    static let FontDosisLight           = "Dosis-Light"
    static let FontDosisMedium          = "Dosis-Medium"
    static let FontDosisRegular         = "Dosis-Regular"
    static let FontDosisSemiBold        = "Dosis-SemiBold"
    
    // MARK: - Device Type
    
    static let DeviceType               = 1 //iOS
    
    // MARK: - Web Services
    
    static let BaseURL                  = "http://e2msol.com/boozehound/api/Webservices/"
    static let APIKEY                   = "d8qmeR2iOIBoQFi6oA2nB8GbEi088Wsw"
    static let URL_Country_State        = BaseURL + "getcountrystate"
    static let URL_Register_Step1       = BaseURL + "registerstep1"
    static let URL_Register_Step2       = BaseURL + "registerstep2"
    static let URL_Login                = BaseURL + "login"
    static let URL_ForgotPassword       = BaseURL + "forgotpassword"
    
    // MARK: - Alert Messages
    
    static let NO_NETWORK               = "No Internet Connection"
    static let ERROR_MESSAGE            = "Something went wrong, please try again."
    static let NO_USERNAME              = "Please enter username."
    static let NO_EMAIL                 = "Please enter email."
    static let NO_EMAIL_USERNAME        = "Please enter email or username."
    static let NO_PASSWORD              = "Please enter password."
    static let NO_CONFIRM_PASSWORD      = "Please enter confirm password."
    static let NO_VALID_EMAIL           = "Please enter valid email address."
    static let PASSWORD_NOT_MATCH       = "Password and confirm password does not match."
    
    // MARK: - Activity Messages
    
    static let Fetch                    = "Fetching..."
    static let Load                     = "Loading..."
    static let Register                 = "Registering..."
    static let Login                    = "Authenticating..."
    static let Update                   = "Updating..."
    static let Save                     = "Saving..."
    static let Wait                     = "Waiting..."
    
}