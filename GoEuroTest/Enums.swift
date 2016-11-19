//
//  Enums.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation



enum TravelType {
    
    case Air
    case Bus
    case Train
    
    
    //Coolest Swift Method
    var description : String {
        get {
            switch(self) {
            case .Air:
                return "Flight"

            case .Bus:
                return "Bus"
                
            case .Train:
                return "Train"
            }
        }
    }
    
    
    var Url : URL {
        get {
            switch(self) {
            case .Air:
                return URL(string: "https://api.myjson.com/bins/w60i")!
            case .Bus:
               return URL(string: "https://api.myjson.com/bins/37yzm")!
                
            case .Train:
                return URL(string: "https://api.myjson.com/bins/3zmcy")!
            }
        }
    }
    
    
}



enum SortOrder {
    
    case Departure
    case Arrival
    case Duration
    
    
    
}
