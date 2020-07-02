//
//  CityDataTableViewCell.swift
//  DemoIOSProject
//
//  Created by Virant Porwal on 30/06/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CityDataTableViewCell: BaseCell {
    
    var cityModel: CityModel? {
        didSet{
            setupCityImage()
            titleLable.text = cityModel?.title ?? "NA"
            cityTitleDetailedLabel.text = cityModel?.description ?? "NA"
        }
    }
    // To show image on table view cell
    let cityImageView:CustomImageView = {
        let img = CustomImageView()
        img.image = UIImage(named: "sample.jpg")
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius =  2
        img.clipsToBounds = true
        return img
    }()
    // To show title on table view cell
    let titleLable:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // To show description on table view cell
    let cityTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .purple
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(cityImageView)
        self.contentView.addSubview(titleLable)
        self.contentView.addSubview(cityTitleDetailedLabel)
        
        cityImageView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:20).isActive = true
        cityImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        cityImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        cityImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        titleLable.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:20).isActive = true
        titleLable.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:88).isActive = true
        titleLable.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        
        cityTitleDetailedLabel.topAnchor.constraint(equalTo:self.titleLable.bottomAnchor , constant:1).isActive = true
        cityTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,  constant:88).isActive = true
        cityTitleDetailedLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-12).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //To Load images on cell from server or chache 
    func setupCityImage(){
        
        if let cityImageUrl = cityModel?.image {
            cityImageView.loadImageUsingUrlString(urlString: cityImageUrl)
        }else{
            cityImageView.image = UIImage(named: "sample.jpg")
        }
    }
}
