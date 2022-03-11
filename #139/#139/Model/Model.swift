//
//  Model.swift
//  #139
//
//  Created by Lan Ran on 2022/3/8.
//

import Foundation


struct UserDataResopse :Codable {
    
    var results : [Result]
    
    struct Result: Codable{
        var gender:String
        var email:String
        var cell:String
        
        
        var name : Names
        var picture:  Picture
        
        struct Names: Codable{
            var title:String
            var first:String
            var last:String
            
        }
        
        struct Picture: Codable{
            var large:String
        }
    }
    
}




