//
//  DisplaySquareViewController.swift
//  MYSquare
//
//  Created by akif demirezen on 24/02/2018.
//  Copyright © 2018 demirezenOrganization. All rights reserved.
//

import UIKit

class DisplaySquareViewController: BaseController {
    @IBOutlet weak var tableViewOfSquare: UITableView!
    
  var dataModel = DataModel()
    fileprivate var responseData = ResponseModelData(){
        didSet{
            self.tableViewOfSquare.reloadData()
        }
    }
    public static var willSearchCity : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeWihNewData), name: NSNotification.Name(rawValue: "leftMenuData"), object: nil)
        self.indicatorShow(status: true)
        self.tableViewOfSquare.layer.cornerRadius = 15.0
        tableViewOfSquare?.register(SqauresTableViewCell.nib, forCellReuseIdentifier: SqauresTableViewCell.identifier)
        tableViewOfSquare?.delegate = self
        tableViewOfSquare?.dataSource = self
        self.dataModel.dataDelegate = self        
        self.dataModel.near = DisplaySquareViewController.willSearchCity
        self.dataModel.sendDataToService()
    }
    
    @objc func changeWihNewData(){
        self.indicatorShow(status: true)
        self.dataModel.near = DisplaySquareViewController.willSearchCity
        self.dataModel.sendDataToService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LeftViewController.comeFormLeftMenu{
            self.dataModel.near = DisplaySquareViewController.willSearchCity
            self.dataModel.sendDataToService()
        }
        else{
            PopUpDetailViewController.lat = 0.0
            PopUpDetailViewController.lng = 0.0
            PopUpDetailViewController.imageUrl = ""
            PopUpDetailViewController.rating = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
}
extension DisplaySquareViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewOfSquare.frame.height * 0.25
    }
    
    
}

extension DisplaySquareViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SqauresTableViewCell.identifier, for: indexPath) as? SqauresTableViewCell {
            cell.configureWithItem(item: self.responseData, index: indexPath.section)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return responseData.venues.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.responseData.venues[indexPath.section].rating >= 8.0{
            PopUpDetailViewController.imageStar = #imageLiteral(resourceName: "stargreen")
        }
        else if self.responseData.venues[indexPath.section].rating  >= 3.5 && self.responseData.venues[indexPath.section].rating <= 7.9 {
            PopUpDetailViewController.imageStar = #imageLiteral(resourceName: "staryellow")
        }
        else{
            PopUpDetailViewController.imageStar = #imageLiteral(resourceName: "starred")
        }
        
        PopUpDetailViewController.rating = self.responseData.venues[indexPath.section].rating
        PopUpDetailViewController.lat = self.responseData.venues[indexPath.section].lat
        PopUpDetailViewController.lng = self.responseData.venues[indexPath.section].lng
        PopUpDetailViewController.imageUrl = self.responseData.tips[indexPath.section].photoURL
        self.performSegue(withIdentifier: "segueGoToDetail", sender: nil)
    }
    
}

extension DisplaySquareViewController : DataDelegate {
    func getDataSuccessfully(isCorrect: Bool, message: String, responseModel: ResponseModelData) {
        self.indicatorShow(status: false)
        if isCorrect{
            self.responseData = responseModel
        }
        else{
            showAlert("Aradığınız Şehirde Bir Mekan Bulunamadı", { _ in
               self.performSegue(withIdentifier: "segueGoToMainPAge", sender: nil)
            })
        }
    }
}

