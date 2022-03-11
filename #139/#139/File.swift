//
//  File.swift
//  #139
//
//  Created by Lan Ran on 2021/10/4.
//

import Foundation

struct allData:Codable{
    var results:[normalData]
}


struct normalData:Codable{
    var gender:String
    var email:String
    var picture:Picture
    var name: Name
    var location: Location
    
}
struct Location:Codable{
    var coordinates : Coordinates
    
}
struct Coordinates:Codable{
    
    var latitude:String
    var longitude:String
}
struct Name:Codable{
    var first:String
    var last:String
}

struct Picture:Codable{
    var large:URL
    var thumbnail:URL
}
