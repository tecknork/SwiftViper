//
//  TravelModel.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation

//TravelModel
struct TravelModel {
    
    let id: Int
    let logo: String
    let price: String
    let departureTime: String
    let arrivalTime: String
    let numberOfStops : Int
   
    var photoUrl: URL {
        return logoUrl()
    }
    
    var duration :String{
        return getDuration()
    }
    
    
    var arrivalDate: Date{
        
        return getDate(arrivalTime)
        
    }
    
    var departureDate: Date{
        
        return getDate(departureTime)
    }

    var durationDate: Date{
        
        return getDate(getDuration())
    }
    
    private func getDate(_ time :String) -> Date
    {
        let dateFormatter = DateFormatter();
        dateFormatter.timeStyle = .short;
        dateFormatter.dateStyle = .none;
        dateFormatter.dateFormat = "HH:mm";
        guard let depDate = dateFormatter.date(from: time) else {
            return Date()
        }
        return depDate
    }
    
    
    
    // GetDurationFrom Depaurture and Arrival Date
    
    private func getDuration() -> String{
//        let dateFormatter = DateFormatter();
//        dateFormatter.timeStyle = .short;
//        dateFormatter.dateStyle = .none;
//        dateFormatter.dateFormat = "HH:mm";
//        
//        guard let depDate = dateFormatter.date(from: departureTime) else {
//            return "Invalid Date"
//        }
//        guard let arrDate = dateFormatter.date(from: arrivalTime) else {
//            return "Invalid Date"
//        }
        
        let date = Calendar.current.dateComponents([.minute,.hour],from: departureDate , to:arrivalDate)
        
        return "" + String(date.hour!) + ":" + String(date.minute!)
        
    }
    
    
    private func logoUrl(size: String = "63") -> URL {
        
        let newString = logo.replacingOccurrences(of: "{size}", with: "63")
        return URL(string: newString)!
    }
    
    
    
    
    
}
