//
//  APOD.swift
//  NASA
//
//  Created by Eashir Arafat on 11/5/16.
//  Copyright © 2016 Eashir Arafat. All rights reserved.
//

import Foundation

enum APODModelParseError: Error {
    case response,title,description,imageURL,mediaType
}

class APOD {
    var title: String
    var description: String
    var imageURL: String
    var mediaType: String
    
    init(title: String, description: String, imageURL: String, mediaType: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.mediaType = mediaType
        
    }
    
    
    
    static func apods(from data:Data) -> APOD? {
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String: String] = jsonData as? [String: String]
                else { throw APODModelParseError.response }
            
            guard let description = response["explanation"]
                else { throw APODModelParseError.description }
            
            
            guard let title = response["title"]
                else { throw APODModelParseError.title }
            
            guard let mediaType = response["media_type"]
                else { throw APODModelParseError.mediaType }
            
            guard let url = response["url"]
                else { throw APODModelParseError.imageURL }


            
            let validAPOD: APOD = APOD(title: title,
                                       description: description,
                                       imageURL: url,
                                       mediaType: mediaType
                                      )
            return validAPOD
            
            
        }
        
        catch 	{
            print("Unknown Error")
        }
        
       return nil
    }
}
