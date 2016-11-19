//
//  ListViewRouting.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation

protocol ListViewRoutingInput: class {
    func navigateToDetail()
    
}

class ListViewRouting:ListViewRoutingInput{
    
    weak var viewController :ListViewController!

    
    func navigateToDetail(){
        
    }
    
    
}
