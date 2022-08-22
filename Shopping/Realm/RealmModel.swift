//
//  RealmModel.swift
//  TrendMedia
//
//  Created by 윤여진 on 2022/08/22.
//

import UIKit
import RealmSwift

class ShoppingList: Object {
    
    @Persisted var shoppingContents: String
    @Persisted var checkBox: Bool
    @Persisted var favorite: Bool
  
    //PK(primary key) : Int, UUID(16byte), ObjectID(12byte)
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(shoppingContents: String) {
        self.init()
        self.shoppingContents = shoppingContents
        self.checkBox = false
        self.favorite = false
    }
    
    
}
