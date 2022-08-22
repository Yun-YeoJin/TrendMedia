
import UIKit

class ShoppingTableViewCell: UITableViewCell {


    @IBOutlet weak var ShoppingContents: UIView! {
        didSet {
            self.backgroundColor = .opaqueSeparator
        }
    }
    
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!

    

    
}
