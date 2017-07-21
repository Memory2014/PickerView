//
//  ZYPickerViewController.swift
//  ZYPickerView
//
//  Created by zhong on 20/07/2016.
//  Copyright © 2016 zhong. All rights reserved.
//

import UIKit

class ZYPickerViewController: UIViewController, UIGestureRecognizerDelegate ,UIApplicationDelegate {
    
    private var pickerView = ZYPickerView()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    override func loadView() {
        view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.handleTapFrom))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func handleTapFrom( recognizer : UITapGestureRecognizer) {
        
        if recognizer.state == .ended {
            dismss()
        }
    }
    
    open func showPickerView ( pickerView : ZYPickerView) {
        self.pickerView = pickerView
        
        guard var topController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        while ((topController.parent) != nil) {
            topController = topController.parent!
        }
        
        topController.view.endEditing(true)
        
        var pickerViewFrame = pickerView.frame
        
        do {
            pickerViewFrame.origin.y = self.view.bounds.size.height
            pickerView.frame = pickerViewFrame
            self.view.addSubview(pickerView)
        }
        
        do {
            self.view.frame = CGRect.init(x: 0, y: 0, width: topController.view.bounds.size.width, height: topController.view.bounds.size.height)
            self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            topController.addChildViewController(self)
            topController.view.addSubview(self.view)
        }

        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, UIViewAnimationOptions(rawValue: UInt(7<<16))], animations: {
            
            self.view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
            
            pickerViewFrame.origin.y = self.view.bounds.size.height - pickerViewFrame.size.height
            pickerView.frame = pickerViewFrame
            
        }, completion: { completed in
            
        })
    }
    

    
    func dismss() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
            self.view.backgroundColor = .clear
            var pickerViewFrame = self.pickerView.frame
            pickerViewFrame.origin.y = self.view.bounds.size.height
            self.pickerView.frame = pickerViewFrame
            
        }, completion: { completed in
            
            self.pickerView.removeFromSuperview()
            self.willMove(toParentViewController: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    
    // MAKR: <UIGestureRecognizerDelegate>
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if self.pickerView.frame.contains(touch.location(in: self.pickerView)) {
            return false
        }
        return true
    }

}
