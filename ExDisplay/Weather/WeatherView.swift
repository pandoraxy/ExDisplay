//
//  WeatherView.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    lazy var locationImage: UIImageView = UIImageView.init(frame: CGRectZero)
    lazy var locationLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var tempLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var weatherImage: UIImageView = UIImageView.init(frame: CGRectZero)
    lazy var weatherLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var carWashIndexLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var carWashIndexZsLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var carWashIndexDesLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var PMLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var PMNumLabel: UILabel = UILabel.init(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "homeWeather-backgroundImage")!)
        layoutWeather(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutWeather(frame: CGRect) {
        self.addSubview(locationImage)
        self.addSubview(locationLabel)
        self.addSubview(tempLabel)
        self.addSubview(weatherImage)
        self.addSubview(weatherLabel)
        self.addSubview(carWashIndexLabel)
        self.addSubview(carWashIndexZsLabel)
        self.addSubview(carWashIndexDesLabel)
        self.addSubview(PMLabel)
        self.addSubview(PMNumLabel)
        
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        let locationImageContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 42.0)
        let locationImageContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 9.0)
        let locationImageContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 13.0)
        let locationImageContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 10.0)
        let locationImageContrains: NSArray = [locationImageContrainTop, locationImageContrainWidth, locationImageContrainHeight, locationImageContrainLeading]
        self.addConstraints(locationImageContrains as! [NSLayoutConstraint])
        locationImage.image = UIImage(named: "homeWeather-location")
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        let locationLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Leading, relatedBy: .Equal, toItem: locationImage, attribute: .Leading, multiplier: 1.0, constant: 15.0)
        let locationLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 5.0)
        let locationLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20.0)
        let locationLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0)
        let locationLabelContrains: NSArray = [locationLabelContrainTop, locationLabelContrainWidth, locationLabelContrainHeight, locationLabelContrainLeading]
        self.addConstraints(locationLabelContrains as! [NSLayoutConstraint])
        locationLabel.font = UIFont.systemFontOfSize(13.0)
        locationLabel.text = "定位中..."
        locationLabel.textColor = UIColor.whiteColor()
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        let tempLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 20.0)
        let tempLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 20.0)
        let tempLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0)
        let tempLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: -40.0)
        let tempLabelContrains: NSArray = [tempLabelContrainTop, tempLabelContrainWidth, tempLabelContrainHeight, tempLabelContrainLeading]
        self.addConstraints(tempLabelContrains as! [NSLayoutConstraint])
        tempLabel.font = UIFont.systemFontOfSize(70.0)
        tempLabel.text = "--"
        tempLabel.textAlignment = .Center
        tempLabel.textColor = UIColor.whiteColor()
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        let weatherImageContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10.0)
        let weatherImageContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 120.0)
        let weatherImageContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 15.0)
        let weatherImageContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 22.0)
        let weatherImageContrains: NSArray = [weatherImageContrainTop, weatherImageContrainWidth, weatherImageContrainHeight, weatherImageContrainLeading]
        self.addConstraints(weatherImageContrains as! [NSLayoutConstraint])
        weatherImage.image = UIImage(named: "homeWeather-cloudy")
        
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        let weatherLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 35.0)
        let weatherLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 112.0)
        let weatherLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 29.0)
        let weatherLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 155.0)
        let weatherLabelContrains: NSArray = [weatherLabelContrainTop, weatherLabelContrainWidth, weatherLabelContrainHeight, weatherLabelContrainLeading]
        self.addConstraints(weatherLabelContrains as! [NSLayoutConstraint])
        weatherLabel.font = UIFont.systemFontOfSize(20.0)
        weatherLabel.text = "--"
        weatherLabel.textColor = UIColor.whiteColor()
        weatherLabel.textAlignment = .Center
        
        PMLabel.translatesAutoresizingMaskIntoConstraints = false
        let PMLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10.0)
        let PMLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 145.0)
        let PMLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 29.0)
        let PMLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0)
        let PMLabelContrains: NSArray = [PMLabelContrainTop, PMLabelContrainWidth, PMLabelContrainHeight, PMLabelContrainLeading]
        self.addConstraints(PMLabelContrains as! [NSLayoutConstraint])
        PMLabel.font = UIFont.systemFontOfSize(20.0)
        PMLabel.text = "PM2.5"
        PMLabel.textColor = UIColor.whiteColor()
        
        PMNumLabel.translatesAutoresizingMaskIntoConstraints = false
        let PMNumLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Leading, relatedBy: .Equal, toItem: PMLabel, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        let PMNumLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 145.0)
        let PMNumLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 26.0)
        let PMNumLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0)
        let PMNumLabelContrains: NSArray = [PMNumLabelContrainTop, PMNumLabelContrainWidth, PMNumLabelContrainHeight, PMNumLabelContrainLeading]
        self.addConstraints(PMNumLabelContrains as! [NSLayoutConstraint])
        PMNumLabel.font = UIFont.systemFontOfSize(25.0)
        PMNumLabel.text = "--"
        PMNumLabel.textColor = UIColor.whiteColor()
        PMNumLabel.textAlignment = .Center
        
        carWashIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        let carWashIndexLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10.0)
        let carWashIndexLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 175.0)
        let carWashIndexLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 26.0)
        let carWashIndexLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0)
        let carWashIndexLabelContrains: NSArray = [carWashIndexLabelContrainTop, carWashIndexLabelContrainWidth, carWashIndexLabelContrainHeight, carWashIndexLabelContrainLeading]
        self.addConstraints(carWashIndexLabelContrains as! [NSLayoutConstraint])
        carWashIndexLabel.font = UIFont.systemFontOfSize(20.0)
        carWashIndexLabel.text = "洗车指数："
        carWashIndexLabel.textColor = UIColor.whiteColor()
        
        carWashIndexZsLabel.translatesAutoresizingMaskIntoConstraints = false
        let carWashIndexZsLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Leading, relatedBy: .Equal, toItem: carWashIndexLabel, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        let carWashIndexZsLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 175.0)
        let carWashIndexZsLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 26.0)
        let carWashIndexZsLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0)
        let carWashIndexZsLabelContrains: NSArray = [carWashIndexZsLabelContrainTop, carWashIndexZsLabelContrainWidth, carWashIndexZsLabelContrainHeight, carWashIndexZsLabelContrainLeading]
        self.addConstraints(carWashIndexZsLabelContrains as! [NSLayoutConstraint])
        carWashIndexZsLabel.font = UIFont.systemFontOfSize(20.0)
        carWashIndexZsLabel.text = "--"
        carWashIndexZsLabel.textColor = UIColor.whiteColor()
        carWashIndexZsLabel.textAlignment = .Center
        
        carWashIndexDesLabel.translatesAutoresizingMaskIntoConstraints = false
        let carWashIndexDesLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 13.0)
        let carWashIndexDesLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 202.0)
        let carWashIndexDesLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 70.0)
        let carWashIndexDesLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 175.0)
        let carWashIndexDesLabelContrains: NSArray = [carWashIndexDesLabelContrainTop, carWashIndexDesLabelContrainWidth, carWashIndexDesLabelContrainHeight, carWashIndexDesLabelContrainLeading]
        self.addConstraints(carWashIndexDesLabelContrains as! [NSLayoutConstraint])
        carWashIndexDesLabel.font = UIFont.systemFontOfSize(14.0)
        carWashIndexDesLabel.numberOfLines = 0
        carWashIndexDesLabel.textColor = UIColor.whiteColor()
    }
}
