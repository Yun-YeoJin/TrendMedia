

import UIKit

class BucketlistTableViewController: UITableViewController {

    var list = ["범죄도시2", "탑건", "비상선언"]
    
    @IBOutlet weak var usefTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        list.append("마녀2")
        list.append("미니언즈")
       
    }
    //셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //셀의 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketlistTableViewCell", for: indexPath) as! BucketlistTableViewCell //as! 타입캐스팅
        
        cell.titleLabel.text = list[indexPath.row]
        cell.titleLabel.font = .boldSystemFont(ofSize: 15)
        
        
        return cell
    }
    
    // 편집이 가능한 셀로 만들어준다.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 우측 스와이프 디폴트 기능: commit editingStyle (위 canEditRowAt을 return true로 해줘야 사용 가능)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
       // tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
        }
    }

//    //카카오톡 숨김/차단 기능
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//
//    //카카오톡 즐겨찾기 핀고정
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
    
    //reloadData() 이용
    @IBAction func userTextfieldReturn(_ sender: UITextField) {
        
        list.append(sender.text!)
        // 가장 중요한 코드!!!!!!
        tableView.reloadData()
        
       // tableView.reloadSections(IndexSet(), with: <#T##UITableView.RowAnimation#>)
       // tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
//        tableView.numberOfRows(inSection: <#T##Int#>)
//        tableView.cellForRow(at: IndexPath)
        
    }
    
}
