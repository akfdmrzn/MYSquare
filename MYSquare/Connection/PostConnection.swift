//
//  PostConnection.swift
//  Swift3ServiceConnection
//
//  Created by Mac on 2.12.2016.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import Alamofire
class PostConnection
{
    
    var delegate : ConnectionDelegate?
    
    func makePostConnection( url: String ,postParams : Parameters, httpMethod : HTTPMethod)
    {
       
        
        Alamofire.request(url, method: .get, parameters: postParams)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    //print(retrivedResult)
                    //         success(brandTags)
                    break
                case .failure(let errorGiven):
                  /*  print(errorGiven)
                    print(String(data: response.data!, encoding: String.Encoding.utf8) ?? "")*/
                    break
                }
                if let json = response.result.value {
                    
                    self.delegate?.getDataFromService(jsonData:  json as AnyObject)
                }
            })
        
            
        }
        
    }
    
    

