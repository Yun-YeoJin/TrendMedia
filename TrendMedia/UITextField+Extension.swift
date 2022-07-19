
import Foundation
import UIKit

extension UITextField {
    //extension안에서는 메서드만 쓸 수 있다!!
    
    //extension에서는 프로퍼티들은 못함.
    //EX) let placeholder = "이메일을 입력해주세요."
    
    func borderColor() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .bezel
    }
    
}
