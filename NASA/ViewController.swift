//
//  ViewController.swift
//  NASA
//
//  Created by Eashir Arafat on 11/5/16.
//  Copyright © 2016 Eashir Arafat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apods: [APOD] = []
    var APODDate = Date()
    var dateFormatter = DateFormatter()
    
    var day = Int()
    var month = Int()
    var year = Int()
    
    @IBOutlet weak var APODDatePicker: UIDatePicker!
    @IBOutlet weak var APODDescription: UILabel!
    @IBOutlet weak var APODImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        APODDescription.text = String(describing: APODDate)
        
        APIRequestManager.manager.getData(endPoint: "https://api.nasa.gov/planetary/apod?api_key=oDOOyNKr9DxBksVZro3Xpjv9ol2JA3btQzzK77ff&date=\(year)-\(month)-\(day)") { (data: Data?) in
            if let validData = data,
                let validAPODs = APOD.apods(from: validData) {
                self.apods = validAPODs
                DispatchQueue.main.async {
                    self.view.setNeedsDisplay()
                }
            }
        }
        print(apods)
       

    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
   
    
    func getDate () {
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: APODDate)
        
        year =  components.year!
        month = components.month!
        day = components.day!
        
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
       
        APODDate = sender.date
        sender.datePickerMode = UIDatePickerMode.date
        dateFormatter.dateFormat = "dd MM yyyy"
        getDate()
   
//        print(APODDate)
//        
//        print(year)
//        print(day)
//        print(month)
       

        
        
        
        getDate()
        for eachAPOD in apods {
            APODDescription.text = eachAPOD.name
        }
        
    }

}

