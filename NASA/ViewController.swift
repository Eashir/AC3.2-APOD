//
//  ViewController.swift
//  NASA
//
//  Created by Eashir Arafat on 11/5/16.
//  Copyright © 2016 Eashir Arafat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apods: APOD?
    var APODDate = Date()
    var dateFormatter = DateFormatter()
    
    var day = Int()
    var month = Int()
    var year = Int()
    
    @IBOutlet weak var APODTitle: UILabel!
    @IBOutlet weak var APODDatePicker: UIDatePicker!
    @IBOutlet weak var APODDescription: UITextView!
    @IBOutlet weak var APODImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAndSetDate()
        let endpointDate = "https://api.nasa.gov/planetary/apod?api_key=oDOOyNKr9DxBksVZro3Xpjv9ol2JA3btQzzK77ff&date=\(year)-\(month)-\(day)"
        APIRequestManager.manager.getData(endPoint: endpointDate) { (data: Data?) in
            
            if  let validAPODS = APOD.apods(from: data!) {
                self.apods = validAPODS
            }
            
            
            DispatchQueue.main.async {
                        self.APODTitle.text = self.apods?.title
                        self.APODDescription.text = self.apods?.description
            }
        }
            
            
    }
        
        
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
  
   
    
    func getAndSetDate () {
        
        APODDate = APODDatePicker.date
        APODDatePicker.datePickerMode = UIDatePickerMode.date
        dateFormatter.dateFormat = "dd MM yyyy"
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.day,.month,.year], from: APODDate)
     
        
        year =  components.year!
        month = components.month!
        day = components.day!
        
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
       
       
        self.viewDidLoad()
        
        
        
      
        
        
        
    }

}

