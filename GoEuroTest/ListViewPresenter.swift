//
//  ListViewPresenter.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation
import UIKit


protocol ListViewPresenterInput:ListViewControllerOutput,ListViewInteractorOutput
{
    
}


// Presenter
class ListViewPresenter :ListViewPresenterInput{
    weak var view: ListViewControllerInput!
    var router :ListViewRoutingInput!
    var data: [TravelModel]!
    var cache:NSCache = NSCache<NSURL, AnyObject>();
    
    var Interactor:ListViewInteractorInput!
    
    func FetchData(_ type :TravelType)
    {
        
        Interactor.fetchResultsFromService(type)
        
    }
    
    func SortData(_ type: TravelType , sortby: SortOrder , orderby:ComparisonResult)
    {
        Interactor.SortResults(type, sortby: sortby, orderby: orderby)
        
    }
    
    func showResult(_ data:[TravelModel])
    {
        self.data = data;
        self.view.displayFetechedResults(data);
        
    }

    func showServiceError(_ error:String)
    {
         self.view.displayErrorView(_errorMessage: error)
    }
    
    
    func goToDetailPage(){
        
        self.router.navigateToDetail()
        
    }
    
    func getDataCount() -> Int
    {
        return self.data.count;
    }
    
    func getDataAtIndex(_ index: NSIndexPath) -> TravelModel
    {
         return self.data[index.row];
        
    }
    
//    func getImage(_ url:URL)-> UIImage
//    {
//        if let img = cache.object(forKey: url as NSURL as NSURL) {
//                    self.imgLogo.image = img as? UIImage;
//                } else {
//                    DataCenter().downloadLogo(_url: travelInfo.provider_logo) { (url, _img) in
//                        if let img = _img {
//                            self.imgLogo.image = img;
//                            self.cache.setObject(img, forKey: url as NSString);
//                        }
//                    }
//                }
//    }
    
    
    
}
