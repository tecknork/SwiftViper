//
//  ListViewRouting.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation
//Routing
protocol ListViewRoutingInput: class {
    func navigateToDetail()
    
}
//Routing
class ListViewRouting:ListViewRoutingInput{
    
    weak var viewController :ListViewController!

    
    func navigateToDetail(){
        viewController.showDetailError()
    }
    
    
}
