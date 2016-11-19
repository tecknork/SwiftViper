//
//  TravelTableViewCell.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 19/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import UIKit
import QuartzCore
import SDWebImage
import UIImageColors



class TravelTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var Stops: UILabel!
    @IBOutlet weak var Duration: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var corneroutline: UIView!
    @IBOutlet weak var priceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.masksToBounds = false;
        self.mainView.layer.shadowOffset =  CGSize( width: 0, height:5)
        self.mainView.layer.borderWidth = 1.0;
        self.mainView.layer.borderColor = UIColor(white: 0.98, alpha: 1.0).cgColor;
        self.mainView.backgroundColor = UIColor.white
        self.mainView.layer.shadowRadius = 5;
        self.mainView.layer.shadowOpacity = 0.2;
        self.mainView.layer.cornerRadius = 5.0;
        
        self.priceView.layer.cornerRadius = 5.0;
       // self.corneroutline.layer.cornerRadius = 5.0;
        
        
        let path = UIBezierPath(roundedRect:self.corneroutline.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 5, height:  5))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.corneroutline.layer.mask = maskLayer
        
        
        
//        self.mainView.layer.shadowPath = UIBezierPath.init(cgPath: self.mainView.bounds as! CGPath)
    
        
        // Initialization code
    }
    


    func setUpData(_ data:TravelModel)  {
      
        self.Duration.text = data.duration + "h"
        
        self.durationLabel.text = data.departureTime + " - " + data.arrivalTime  + (data.arrivalDate.compare(data.departureDate) == .orderedAscending ? " ( +1 )" :"")
        self.Stops.text = data.numberOfStops == 0 ? "Direct" : data.numberOfStops >  1 ? "\(data.numberOfStops) Stop" :   "\(data.numberOfStops) Stops"
        
        self.priceLabel.attributedText = Helper().formatPriceLabel(data.price)
        
        self.providerImage.sd_setImage(with: data.photoUrl as URL) { (image, error, cache, url) in
            self.providerImage.image = image
            let colors = self.providerImage.image?.getColors()
            self.corneroutline.backgroundColor = colors?.primaryColor             
            UIView.animate(withDuration: 0.2, animations: {
                self.providerImage.alpha = 1.0
            })
        }
        
        
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
