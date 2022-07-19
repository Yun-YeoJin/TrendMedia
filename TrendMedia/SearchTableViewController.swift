

import UIKit

class SearchTableViewController: UITableViewController {
     
    
    var MovieList = ["범죄도시2", "어벤져스", "해리포터와 죽음의 성물", "비상선언", "겨울왕국"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }
    //셀의 갯수 - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieList.count
    }
    
    //셀의 내용 - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.titleLabel.text = MovieList[indexPath.row]
        cell.titleLabel.font = .boldSystemFont(ofSize: 17)
        cell.MoiveImage.image = UIImage(systemName: "person.fill")
        
        cell.DateLabel.text = Date().description
        cell.DateLabel.font = .boldSystemFont(ofSize: 12)
        
        cell.descriptionLabel.text = "영화소개"
        cell.descriptionLabel.font = .systemFont(ofSize: 12)
        
        return cell
    }
}

