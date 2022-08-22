
import UIKit
import Foundation

struct Movie {
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
}

class user {
     init(name: String, age: Int, rate: Double, gender: Bool) {
        self.name = name
        self.age = age
        self.rate = rate
        self.gender = gender
    }
    
    var name: String
    var age: Int
    var rate: Double
    var gender: Bool
    
}
