//
//  APOD.swift
//  NASA
//
//  Created by Eashir Arafat on 11/5/16.
//  Copyright © 2016 Eashir Arafat. All rights reserved.
//

import Foundation

enum APODModelParseError: Error {
    case results(json:Any)
    case name
}
class APOD {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    
    
    static func apods(from data:Data) -> [APOD]? {
        var apodsToReturn: [APOD]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let results: [String: AnyObject] = jsonData as? [String: AnyObject],
            let explanations = results["explanation"] else {
                throw APODModelParseError.results(json: jsonData)
            }
            
            apodsToReturn?.append(explanations as! APOD)
            
        }
        
        catch let APODModelParseError.results(json: json) {
            print(" Error with Apod or results \(json)")
        }
        
        catch  {
            print("Unknown parsing error")
        }
        
        return apodsToReturn
    }
}
