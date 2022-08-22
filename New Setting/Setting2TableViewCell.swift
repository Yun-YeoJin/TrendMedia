
import UIKit

class Setting2TableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    /// 셀에 데이터를 넣어주는 역할
    /// - Parameter :
    /// - data : 영화정보가 들어있음
    /// - name: 사용자 닉네임
    /// - age : 사용자 나이

    func configureCell(data: Movie) //구조체로 받겠다.
    {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = data.title
        DateLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        overviewLabel.text = data.overview
        overviewLabel.numberOfLines = 0
    }
}
