//
//  RealmModel.swift
//  TrendMedia
//
//  Created by 윤여진 on 2022/08/22.
//

import UIKit
import RealmSwift

class ShoppingList: Object {
    
    @Persisted var checkBox: Bool //제목(필수)
    @Persisted var shoppingContents: String //내용(필수)
    @Persisted var favorite: Bool //즐겨찾기(필수)
  
    //PK(primary key) : Int, UUID(16byte), ObjectID(12byte)
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(shoppingContents: String) {
        self.init()
        self.shoppingContents = shoppingContents
        self.checkBox = false
        self.favorite = false
    }
    
    
}
