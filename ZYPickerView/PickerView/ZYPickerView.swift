//
//  ZYPickerView.swift
//  ZYPickerView
//
//  Created by zhong on 20/07/2016.
//  Copyright © 2016 zhong. All rights reserved.
//

import UIKit
import Foundation

/// PickerViewMode
public enum ZYPickerViewStyle {
    
    case Text
    case Date
    case DateTime
    case Time
}

typealias Action<T> = (T) -> Void


class ZYPickerView: UIControl{
    

    
    var font: UIFont? = UIFont.boldSystemFont(ofSize: 16)
    var textColor : UIColor? = .darkGray
    
    
    
    var backColor : UIColor = .white {
        willSet {
            self.pickerView?.backgroundColor = newValue
        }
    }
    
    /// The pickerView mode style , default is Date
    var pickerStyle : ZYPickerViewStyle = .Date {
        didSet {
            setPickerViewStyle()
        }
    }

    /// The action when tapped done button
    var doneAction :( Action<Any> )?
    
    /// The action when tapped cancle button
    var cancleAction: (()->Void)?
    
    //MARK: -- DatePickerMode
    var selectedDate = Date(){
        willSet {
            self.datePicker?.date = newValue
        }
    }
    
    var minimumDate : Date? = nil {
        willSet {
            self.datePicker?.minimumDate = newValue
        }
    }
    
    var maximumDate:Date? = nil{
        willSet {
            self.datePicker?.maximumDate = newValue
        }
    }
    
    var minuteInterval: Int = 0 {
        willSet {
            self.datePicker?.minuteInterval = newValue
        }
    }
    
    //MARK: -- Toobar
    
    var toobarTitleFont : UIFont = UIFont.systemFont(ofSize: 18){
        willSet {
            self.toobar?.titltFont = newValue
        }
    }
    
    var toobarTitleTextColor : UIColor = .darkGray {
        willSet {
            self.toobar?.titleTextColor = newValue
        }
    }
    
    var toobarTintColor :UIColor = .white {
        willSet {
            self.toobar?.barTintColor = newValue
        }
    }
    
    var toobarTextColor :UIColor = .darkGray {
        willSet {
            self.toobar?.tintColor = newValue
        }
    }
    
    var widthsForComponents = [NSNumber]()
    var titlesForComponents = [[String]]()

    fileprivate var toobar : ZYPickerToolbar?
    fileprivate var controller : ZYPickerViewController?
    fileprivate var pickerView : UIPickerView?
    fileprivate var datePicker : UIDatePicker?
    
    fileprivate var isRangePickerView : Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init( title : String) {
        
        var rect = UIScreen.main.bounds
        rect.size.height = 216 + 44
        self.init(frame: rect)
        
        toobar = ZYPickerToolbar.init(frame: CGRect.init(x: 0, y: 0, width: rect.size.width, height: 44))
        toobar?.barStyle = .default
        toobar?.cancelButton?.target = self
        toobar?.cancelButton?.action = #selector(self.pickerCancelClicked)
        toobar?.doneButton?.target = self
        toobar?.doneButton?.action = #selector(self.pickerDoneClicked)
        toobar?.titleButton?.title = title
        toobar?.titleText = title
        toobar?.titleTextColor = self.toobarTitleTextColor
        toobar?.barTintColor = self.toobarTintColor
        toobar?.tintColor = self.toobarTextColor
        self.addSubview(toobar!)
        
        pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: (toobar?.frame.maxY)!, width: (toobar?.frame.width)!, height: 216))
        pickerView?.backgroundColor = self.backColor
        pickerView?.showsSelectionIndicator = true
        pickerView?.delegate = self
        pickerView?.dataSource = self
        self.addSubview(pickerView!)
        
        datePicker = UIDatePicker.init(frame: (pickerView?.frame)!)
        datePicker?.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
        datePicker?.backgroundColor = self.backColor
        datePicker?.datePickerMode = .date
        datePicker?.maximumDate = self.maximumDate
        datePicker?.maximumDate = self.minimumDate
        datePicker?.minuteInterval = self.minuteInterval
        datePicker?.date = self.selectedDate
        self.addSubview(datePicker!)
        
        self.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        self.frame = CGRect.init(x: 0, y: 0, width: (pickerView?.frame.width)!, height: (pickerView?.frame.maxY)!)

        self.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        toobar?.autoresizingMask = .flexibleWidth
        pickerView?.autoresizingMask = .flexibleWidth
        datePicker?.autoresizingMask = .flexibleWidth
        
        setPickerViewStyle()
    }
    
    fileprivate func setPickerViewStyle (){
        
        switch self.pickerStyle {
        case .Text:
            self.pickerView?.isHidden = false
            self.datePicker?.isHidden = true
        case .Date:
            self.pickerView?.isHidden = true
            self.datePicker?.isHidden = false
            self.datePicker?.datePickerMode = .date
        case .DateTime:
            self.pickerView?.isHidden = true
            self.datePicker?.isHidden = false
            self.datePicker?.datePickerMode = .dateAndTime
        case .Time:
            self.pickerView?.isHidden = true
            self.datePicker?.isHidden = false
            self.datePicker?.datePickerMode = .time
        //default: break
        }
    
    }
    
    fileprivate func pickerDone (){
        switch self.pickerStyle {
            
        case .Text:
            var data : [String] = []
            for x in 0..<self.titlesForComponents.count {
                guard let index = self.pickerView?.selectedRow(inComponent: x) else {
                    return
                }
                data.append(self.titlesForComponents[x][index])
            }
            doneAction?(data)
        case .Date,.DateTime,.Time:
            doneAction?((self.datePicker?.date)!)
            break
        }
    }

    @objc fileprivate func pickerCancelClicked () {
        cancleAction?()
        dismiss()
    }
    
    @objc fileprivate func pickerDoneClicked () {
        pickerDone()
        dismiss()
    }
    
    @objc fileprivate func dateChanged() {
        
    }
    
    //MARK: SHOW/HIDE
    
    func dismiss (){
        self.controller?.dismss()
    }
    
    func show () {
        
        self.controller = ZYPickerViewController.init()
        self.controller?.showPickerView(pickerView: self)
    }

}

//MARK: UIPickerViewDelegate

extension ZYPickerView : UIPickerViewDelegate, UIPickerViewDataSource {
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if isRangePickerView && pickerView.numberOfComponents == 3 {
            if component == 0 {
                pickerView.selectRow( max(pickerView.selectedRow(inComponent: 2), row), inComponent: 2, animated: true)
            }else
            if component == 2 {
                pickerView.selectRow(min(pickerView.selectedRow(inComponent: 0), row), inComponent: 0, animated: true)
            }
        }
        
        self.sendActions(for: .valueChanged)
    }
    
    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel.init()
        
        if self.font == nil {
            label.font = UIFont.boldSystemFont(ofSize: 18)
        }else{
            label.font = self.font
        }
        
        if self.textColor != nil {
            label.textColor = self.textColor
        }else{
            label.textColor = .darkGray
        }
        
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = self.titlesForComponents[component][row]
        
        return label
    }
    
    internal func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if !self.widthsForComponents.isEmpty {
            
            let width = self.widthsForComponents[component]
            if width != 0 {
                return CGFloat(width)
            }
        }
        let widths = pickerView.bounds.size.width - 20 - CGFloat( 2*(self.titlesForComponents.count - 1))
        return widths/CGFloat(self.titlesForComponents.count)
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.titlesForComponents[component].count
    }
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.titlesForComponents.count
    }
    
}
