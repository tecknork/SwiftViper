//
//  NetworkManager.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation
import UIKit

protocol FetchDataProtocol : class{
    
    func fetchDataFromApi(type:TravelType , closure: @escaping (NSError?, [TravelModel]?)->Void) -> Void
    func downloadLogo(url: String, closure:@escaping (String, UIImage?)->Void) -> Void
}

//protocol ImageDownloadProtocol :class {
//    
//    func downloadLogo(url: String, closure:@escaping (String, UIImage?)->Void) -> Void
//    
//}

class NetworkManager :FetchDataProtocol {
    
    struct MetaData {
        static let id = "id"
        static let logo = "provider_logo"
        static let price = "price_in_euros"
        static let depTime = "departure_time"
        static let arrTime = "arrival_time"
        static let stops = "number_of_stops"
        
    }
    
    func fetchDataFromApi(type:TravelType , closure: @escaping (NSError?, [TravelModel]?)->Void) -> Void{
        
        let request = URLRequest(url: type.Url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error fetching data: \(error)")
                closure(error as NSError?, nil)
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : AnyObject]]
        
                let TravelData: [TravelModel] = jsonData.map({ (travel) -> TravelModel in
                    
                    let id = travel[MetaData.id] as? Int ?? 0
                    let logo = travel[MetaData.logo] as? String ?? ""
                    let price :String
                    switch type{
                    case .Air:
                         price = travel[MetaData.price] as? String ?? ""

                    case .Bus,.Train:
                        let object = travel[MetaData.price] as? Double ?? 0
                         price = String(object)
                    }
                    
                    let depTime = travel[MetaData.depTime] as? String ?? ""
                    let arrTime = travel[MetaData.arrTime] as? String ?? ""
                    let stops = travel[MetaData.stops] as? Int ?? 0
                    
                    let data = TravelModel(id: id, logo: logo, price: price  , departureTime: depTime, arrivalTime: arrTime, numberOfStops: stops)
                    return data
                    
                })
                
                closure(nil,TravelData)
                
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                closure(error, nil)
                return
            }
        }
        task.resume()
    }
    
    
    
    func downloadLogo(url: String, closure:@escaping (String, UIImage?)->Void) ->Void {
        guard let Url = URL(string: url) else {
            closure(url, nil);
            return;
        }
        do {
            let imgData = try Data(contentsOf: Url)
            if let img = UIImage(data: imgData) {
                closure(url, img);
            } else {
                closure(url, nil);
            }
        } catch let error as NSError {
            print("Error parsing JSON: \(error)")
            
        }
    }
    
    
}
