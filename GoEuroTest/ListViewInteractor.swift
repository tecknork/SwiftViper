//
//  ListViewInteractor.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation

protocol ListViewInteractorInput:class {
    
    func fetchResultsFromService(_ type :TravelType)
    func SortResults(_ type: TravelType , sortby: SortOrder , orderby:ComparisonResult)
    
    
}

protocol ListViewInteractorOutput:class {
    
     func showResult(_ data:[TravelModel])
     func showServiceError(_ error:String)
     func goToDetailPage()
    
}


class ListViewInteractor:ListViewInteractorInput{
    
   weak var presenter: ListViewInteractorOutput!
   var DataManager: FetchDataProtocol!
   //var data: [TravelModel]!
    
    func fetchResultsFromService(_ type :TravelType){
        
        DataManager.fetchDataFromApi(type: type){
            (error, travelData) in
            if travelData != nil {
                
            self.presenter.showResult(travelData!)
                self.UpdateSingleton( type,model: travelData!)
                print(travelData!);
            
            } else if let error = error {
                print (error);
               self.presenter.showServiceError(error.localizedDescription)
                
            }

        
            }
    
    }
    
    
    
    func SortResults(_ type: TravelType , sortby: SortOrder , orderby:ComparisonResult){
        
        var model : [TravelModel];
        
        switch type {
        case .Air:
            model = GoEuroSingleton.sharedInstance.AirModel
        case .Bus:
           model = GoEuroSingleton.sharedInstance.BusModel
        case .Train:
           model = GoEuroSingleton.sharedInstance.TravelModel
        }

        
        
        switch sortby {
        case .Arrival:
            SortByArrivalDate(model,ordertype: orderby)
        case .Departure:
            SortByDepartureDate(model,ordertype: orderby)
        case .Duration:
            SortByDurtion(model,ordertype: orderby)
        
            }
        
    }
    
    
    
    
    
    
    private func SortByArrivalDate(_ model: [TravelModel] , ordertype :ComparisonResult ){
        
         let result = model.sorted(by: { $0.arrivalDate.compare($1.arrivalDate) == ordertype})
        
         self.presenter.showResult(result)
        
    
    }
    private func SortByDepartureDate(_ model: [TravelModel], ordertype :ComparisonResult ){
        
        let result = model.sorted(by: { $0.departureDate.compare($1.departureDate) == ordertype})
        
        self.presenter.showResult(result)
        
    }
    
    
    private func SortByDurtion(_ model:[TravelModel], ordertype: ComparisonResult)
    {
        let result = model.sorted(by: { $0.durationDate.compare($1.durationDate) == ordertype})
        
        self.presenter.showResult(result)
        
    }
    
    
    private func UpdateSingleton( _ type : TravelType , model:[TravelModel])
    {
                
        switch type {
        case .Air:
            GoEuroSingleton.sharedInstance.AirModel = model
        case .Bus:
            GoEuroSingleton.sharedInstance.BusModel = model
        case .Train:
            GoEuroSingleton.sharedInstance.TravelModel = model
        }
        
    }
    
    
    
    
    
}
