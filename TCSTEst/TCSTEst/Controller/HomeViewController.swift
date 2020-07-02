//
//  ViewController.swift
//  DemoIOSProject
//
//  Created by Virant Porwal on 30/06/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import UIKit
import Foundation


class HomeViewController: UIViewController{
    
    enum Const {
        static let heightForRow: CGFloat = 110
    }
    
    let cityViewModel =  CityViewModel()
    let cityDataTableView = UITableView()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching city Data....")
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Home"
        cityViewModel.delegate = self
        view.backgroundColor = .red
        
        setupTableView()
        loadArticles()
    }
    
    func setupTableView(){
        
        view.addSubview(cityDataTableView)
        cityDataTableView.translatesAutoresizingMaskIntoConstraints = false
        cityDataTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        cityDataTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        cityDataTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        cityDataTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        cityDataTableView.dataSource = self
        cityDataTableView.delegate = self
        
        cityDataTableView.register(CityDataTableViewCell.self, forCellReuseIdentifier: "cityCell")
        cityDataTableView.addSubview(self.refreshControl)
        
        
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        loadArticles()
    }
    private func loadArticles() {
        cityViewModel.getCityDetailsInVeiwModel()
    }
    
    func calculateHeight(indexPath: IndexPath) -> CGFloat
    {
        
        let messageString  = cityViewModel.cityModel[indexPath.row].description ?? "NA"
        
        let attributes : [NSAttributedString.Key  : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 15.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: self.view.frame.width - 80 - 20, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
}

extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.cityModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityDataTableViewCell
        cell.cityModel = cityViewModel.cityModel[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height  = calculateHeight(indexPath: indexPath )
        if height > 55.0{
            return height + 50.0
        }
        return Const.heightForRow
    }
}


extension HomeViewController : CityViewModelProtocol{
    func didUpdateCityDetails(cityDetail: CityDetailModel) {
        DispatchQueue.main.async {
            self.cityDataTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func didUpdateCityTitle(cityTitle: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = cityTitle
        }
    }
}
