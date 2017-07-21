//
//  ZYPickerBarButtonItem.swift
//  ZYPickerView
//
//  Created by zhong on 20/07/2016.
//  Copyright © 2016 zhong. All rights reserved.
//

import UIKit

class ZYPickerToolbar: UIToolbar {
    
    open var cancelButton : UIBarButtonItem?
    open var doneButton   : UIBarButtonItem?
    open var titleButton  : UIBarButtonItem?
    
    open var titltFont : UIFont = UIFont.systemFont(ofSize: 18){
        willSet {
            self.button?.titleLabel?.font = newValue
        }
    }
    
    open var titleTextColor : UIColor = .darkGray {
        willSet {
            self.button?.tintColor = newValue
        }
    }
    
    open var titleText : String = "" {
        willSet {
            button?.setTitle(newValue, for: .normal)
        }
    }
    
    fileprivate var button : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize (){
        sizeToFit()
        self.autoresizingMask = .flexibleWidth
        self.isTranslucent = true
        self.tintColor = .black
        
        let niButton = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: nil, action: nil)
        doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: nil)
        
        button = UIButton.init(type: .system)
        button?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 150, height: 44)
        button?.isEnabled = false
        button?.titleLabel?.numberOfLines = 3
        button?.backgroundColor = .clear
        button?.titleLabel?.textAlignment = .center
        button?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button?.tintColor = titleTextColor
        button?.titleLabel?.font = titltFont
        button?.setTitle(titleText, for: .normal)
        titleButton = UIBarButtonItem.init(customView: button!)
        
        self.items = [cancelButton!, niButton,titleButton!,niButton,doneButton!]
    }
    
}

























