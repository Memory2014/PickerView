//
//  ViewController.swift
//  ZYPickerView
//
//  Created by zhong on 20/07/2016.
//  Copyright © 2016 zhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPicker(_ sender: Any) {
        
        let view = ZYPickerView.init(title: "select ")
        
//        view.toobarTitleTextColor = .red
//        view.toobarTitleFont = UIFont.systemFont(ofSize: 20)
//        view.toobarTintColor = UIColor.orange
//        view.toobarTextColor = .white
//        view.pickerStyle = .Text
//        view.textColor = .green
//        view.font = UIFont.systemFont(ofSize: 25)
        
        view.pickerStyle = .Text
        view.widthsForComponents = [40,40,50]
        view.titlesForComponents = [["1","2","3"],["one","two","three","four","five"],["😀","😃","🙂","😜","😊"]]
        
        view.doneAction = { date in
            print(date)
        }
        
        view.show()
    }
    
    
    @IBAction func showDatePicker(_ sender: Any) {
        
        let view = ZYPickerView.init(title: "select date")

        view.pickerStyle = .Date
        view.minimumDate = Date()
        print(Date())

        view.doneAction = { date in
            print(date)
        }
        
        view.show()
        
    }
    
}

