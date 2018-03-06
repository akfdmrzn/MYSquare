//
//  DataModel.swift
//  MYSquare
//
//  Created by akif demirezen on 23/02/2018.
//  Copyright © 2018 demirezenOrganization. All rights reserved.
//

import UIKit


protocol  DataDelegate : class{
    func getDataSuccessfully(isCorrect: Bool, message : String,responseModel: ResponseModelData)
}
class DataModel: ConnectionDelegate {
    
    var postConnection = PostConnection()
    var dataDelegate : DataDelegate?
    var responseModel = ResponseModelData()
    var near : String = "Istanbul"
    
    init() {
        //Default olarak boş ise istanbul aratılacak
    
        self.postConnection.delegate = self
        
    }
    
    func sendDataToService(){
        let data = ["":""
            ] as [String : Any]
        postConnection.makePostConnection(url: "https://api.foursquare.com/v2/venues/explore?near=\(self.near)&client_id=OHGWECPEM05T3MDYTVDCUSOGFPHITZ5IBMWBTI1RJGD3JA5Y&client_secret=3IDI3LBMGASE5I4XT4TXMZI3DTQTNVMM0T4IIXCZEIG5Q3BS&v=20182302", postParams: data, httpMethod: .get)
    }
    func getDataFromService(jsonData : AnyObject){
        let json = jsonData as AnyObject
        var venueList : [ResponseModelVenue] = []
        var tipsList : [ResponseModelTips] = []
        var venueListAbove9 : [ResponseModelVenue] = []
        
        let meta = (json["meta"] as AnyObject)
            if let statusCode = meta["code"] as? Int {
               
                if statusCode == 200 {
                    //TRUE
                    if let groups = (json["response"] as AnyObject)["groups"] as? [AnyObject] {
                        for group in groups{
                            if let items = group["items"] as? [AnyObject] {
                                for item in items{
                                    //TIPS
                                     var isAddedPhoto : Bool = false
                                    if let tips = item["tips"] as? [AnyObject] {
                                        let tipsModel = ResponseModelTips()
                                        for tip in tips{
                                            if let photoUrl = tip["photourl"] as? String{
                                                tipsModel.photoURL = photoUrl
                                            }
                                            if tipsModel.photoURL != ""{
                                                isAddedPhoto = true
                                                tipsList.append(tipsModel)
                                            }
                                        }
                                    }
                                    //VENUE
                                     if let venue = item["venue"] as AnyObject? {
                                        let venueModel = ResponseModelVenue()
                                            if let name = venue["name"] as? String {
                                                venueModel.name = name
                                            }
                                            if let rating = venue["rating"] as? Double {
                                                venueModel.rating = rating
                                            }
                                            if let contact = venue["contact"] as AnyObject? {
                                                if let phone = contact["phone"] as? String {
                                                    venueModel.phone = phone
                                                }
                                            }
                                            if let location = venue["location"] as AnyObject? {
                                                if let address = location["address"] as? String {
                                                    venueModel.address = address
                                                }
                                                if let lat = location["lat"] as? Double {
                                                    venueModel.lat = lat
                                                }
                                                if let lng = location["lng"] as? Double {
                                                    venueModel.lng = lng
                                                }
                                            }
                                        if isAddedPhoto{
                                            venueList.append(venueModel)
                                            if LeftViewController.comeFormLeftMenu{
                                                if venueModel.rating >= 9.0{
                                                    venueListAbove9.append(venueModel)
                                                }
                                                else{
                                                    tipsList.removeLast()
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                  
                                }
                                if LeftViewController.comeFormLeftMenu{
                                self.responseModel.venues = venueListAbove9
                                }
                                else{
                                self.responseModel.venues = venueList
                                }
                                
                                self.responseModel.tips = tipsList
                            }
                        }
                    }
                    self.dataDelegate?.getDataSuccessfully(isCorrect: true, message : "",responseModel: self.responseModel)
                    return
                }
                else{
                    //ELSE
                    self.dataDelegate?.getDataSuccessfully(isCorrect: false, message : "Aradığınız Özelliklere Göre Bir Mekan Bulamadık",responseModel: self.responseModel)
                }
            }
             return
        }
    func getError(errMessage : String){
        self.dataDelegate?.getDataSuccessfully(isCorrect: false, message : "İnternet Bağlantınızda Bir Problem Oluşmuş Olabilir.Lütfen Daha Sonra Tekrar Deneyin",responseModel: self.responseModel)
        
        }
    }

