//
//  ListViewAssembly.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation


class ListViewAssemby{
    
    
    static let sharedInstance = ListViewAssemby()
    
    
    func configure(_ viewController:ListViewController)
    {
       let DataManager = NetworkManager()
        let Interactor = ListViewInteractor()
        let presenter = ListViewPresenter()
        let router = ListViewRouting()
        router.viewController = viewController;
        presenter.router = router
        presenter.view = viewController
        Interactor.presenter = presenter
        viewController.presenter = presenter
        presenter.Interactor = Interactor
        Interactor.DataManager = DataManager
        
    }
    
}
