//
//  ShoppingListDetailViewController.swift
//  TrendMedia
//
//  Created by 윤여진 on 2022/08/25.
//

import UIKit

import SnapKit
import Then


class ShoppingListDetailViewController: UIViewController {

    
    let userImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.image = UIImage(systemName: "tortoise.fill")
        $0.tintColor = .black
    }
    
    let shoppingLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "제목이 여기에 표시됩니다!!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(userImageView)
        view.addSubview(shoppingLabel)
        
        
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(200).multipliedBy(1)
        }
        
        shoppingLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(50)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(44)
        }
    }
    
    
        

        
        
}
    
