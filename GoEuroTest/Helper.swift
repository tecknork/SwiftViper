//
//  Helper.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 19/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    
   func formatPriceLabel(_ amount:String) -> NSMutableAttributedString?
    {
        
        guard let amount = Double( amount) else {
            return nil
        }
        let digitsFont: UIFont = UIFont(name: "Gilroy-Light", size: 17)!
        let decimalFont: UIFont = UIFont(name: "Gilroy-Light", size: 12)!
        
        let formatter = NumberFormatter();
        formatter.numberStyle = .currency;
        formatter.decimalSeparator = ".";
        formatter.currencySymbol = "€";
        formatter.minimumFractionDigits = 2;
        formatter.maximumFractionDigits = 2;
        
        guard let amountString = formatter.string(from: NSNumber(value: amount)) else {
            return nil;
        }
        let strt = amountString.characters.count - 2;
        let end = 2;
        
        let attrString:NSMutableAttributedString = NSMutableAttributedString(string: amountString);
        attrString.addAttribute(NSFontAttributeName, value: digitsFont, range: NSRange(location: 0, length: amountString.characters.count));
         attrString.addAttribute(NSFontAttributeName, value: decimalFont, range: NSRange(location: strt, length: end));
        
//        attrString.addAttributes([NSFontAttributeName:decimalFont, NSBaselineOffsetAttributeName:7], range: NSRange(location: strt, length: end));
        return attrString;
    }
    
    
    
    
    
}
