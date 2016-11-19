//
//  ListViewController.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import UIKit

protocol ListViewControllerOutput{
     func FetchData(_ type :TravelType)
     func goToDetailPage()
     func SortData(_ type: TravelType , sortby: SortOrder , orderby:ComparisonResult)
    func getDataCount() -> Int
    func getDataAtIndex(_ index: NSIndexPath) ->TravelModel
     //func setUpCell()
//    func getImage(_ url:URL)-> UIImage
}

protocol ListViewControllerInput :class{
    
     func displayFetechedResults(_ result:[TravelModel])
     func displayErrorView(_errorMessage:String)
    
    
}


class ListViewController: UIViewController,ListViewControllerInput {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var DepartureView: UIView!
    @IBOutlet weak var DepartureImage: UIImageView!
    
    @IBOutlet weak var ArrivalView: UIView!
   
    @IBOutlet weak var ArrivalImage: UIImageView!
    
    @IBOutlet weak var DurationView: UIView!
    @IBOutlet weak var DurationImage: UIImageView!
    
    var presenter:ListViewControllerOutput!
    
    var type :TravelType!
    
    var currentSort: SortOrder = .Departure
 //   var currentOrderBy:ComparisonResult = .orderedDescending
    override func viewDidLoad() {
        super.viewDidLoad()
       
         RequestResult()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func awakeFromNib() {
        ListViewAssemby.sharedInstance.configure(self)
    }
    
    
    func RequestResult()
    {
        presenter.FetchData(type)
        
        
    }
    
    //Presenter resturn with results
    func displayFetechedResults(_ result:[TravelModel])
    {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
         DispatchQueue.main.async {
            self.tableView.reloadData()

        }
       
        //let refreshAlert = UILA
    }
    
    
    //show Error
    
    func displayErrorView(_errorMessage:String)
    {
        
    }

    
    func goToDetailPage()
    {
        presenter.goToDetailPage()
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
       // self.navigationController?.title = type.description
       
        self.navigationItem.title = type.description
        
    }

    
    
    
    @IBAction func DepatureAction(_ sender: Any) {
        
        
        self.currentSort = .Departure
         let image = UIImage(named: "bottomarrow")
        if(self.DepartureImage.image == image)
        {
            presenter.SortData(self.type, sortby: self.currentSort, orderby: .orderedAscending)
            
            
            self.DepartureImage.image = UIImage(named: "toparrow")
        }
        else{
            
            presenter.SortData(self.type, sortby: self.currentSort, orderby: .orderedDescending)
            
            
            self.DepartureImage.image = UIImage(named: "bottomarrow")
        }
          self.toggleView(.Departure)
    }
    
    @IBAction func ArrivalAction(_ sender: Any) {
        
        self.currentSort = .Arrival
        let image = UIImage(named: "bottomarrow")

        if(self.ArrivalImage.image == image)
        {
            presenter.SortData(self.type, sortby: self.currentSort, orderby: .orderedAscending)
            
            
            self.ArrivalImage.image = UIImage(named: "toparrow")
        }
        else{
            
            presenter.SortData(self.type, sortby: self.currentSort, orderby: .orderedDescending)
            
            
            self.ArrivalImage.image = UIImage(named: "bottomarrow")
        }
        self.toggleView(.Arrival)
        
    }
    
    @IBAction func DurationAction(_ sender: Any) {
        self.currentSort = .Duration
        
        let image = UIImage(named: "bottomarrow")
        
        if(self.DurationImage.image == image)
        {
            presenter.SortData(self.type, sortby: self.currentSort, orderby: .orderedAscending)
            
            
            self.DurationImage.image = UIImage(named: "toparrow")
        }
        else{
            
            presenter.SortData(self.type, sortby: self.currentSort, orderby: .orderedDescending)
            
            
            self.DurationImage.image = UIImage(named: "bottomarrow")
        }
        self.toggleView(.Duration)
        
    }

    
    private func toggleView( _ sortType:SortOrder )
    {
        switch sortType {
        case .Arrival:
            self.ArrivalImage.isHidden=false
            self.DepartureImage.isHidden=true
            self.DurationImage.isHidden=true
        
        case .Departure:
            self.ArrivalImage.isHidden=true
            self.DepartureImage.isHidden=false
            self.DurationImage.isHidden=true
            
        case .Duration:
            self.ArrivalImage.isHidden=true
            self.DepartureImage.isHidden=true
            self.DurationImage.isHidden=false
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension ListViewController:UITableViewDelegate,UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return presenter.getDataCount();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let errorAlert = UIAlertController(title: ErrorTitle, message: ErrorMessage, preferredStyle: .alert)
        
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(errorAlert, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TravelTableViewCell"
        let cell :TravelTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TravelTableViewCell
        
        let data = presenter.getDataAtIndex(indexPath as NSIndexPath);
        
        cell.setUpData(data);
        
       // cell.setUpData(value.Name)
        // Adding the right informations
        
        // Returning the cell
        return cell

    }
    
    
    
}
