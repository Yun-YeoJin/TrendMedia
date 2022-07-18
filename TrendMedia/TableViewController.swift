
import UIKit

class TableViewController: UITableViewController {

    var friends = ["뽀로로", "신데렐라", "올라프", "스노기","모구리", "고래밥"]

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    // 섹션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // Cell의 헤더 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
                return "즐겨찾기"
            } else if section == 2 {
                return "친구 100명"
            } else {
                return "헤더"
            }
        }


// Cell의 푸터 설정
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "푸터"
//    }

    // 1. 셀의 갯수(필수) / numberOfRowsInsection
    // ex) 카톡 100명 > 셀 100개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 { // 생일인 친구
            return friends.count
        } else if section == 1{ // 즐겨찾기
            return 2
        } else if section == 2{ // 친구 100명
            return 10
        } else {
            return 0
        }

    }

    // 2. 셀의 디자인과 데이터(필수) / cellForRowAt
    // ex) 카톡 이름, 프로필 사진, 상태 메시지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!

        if indexPath.section == 0 {

//            if indexPath.row == 0 {
//                cell.textLabel?.text = friends[indexPath.row]
//            } else if indexPath.row == 1 {
//                cell.textLabel?.text = friends[indexPath.row]
//            } else if indexPath.row == 2 {
//                cell.textLabel?.text = friends[indexPath.row]
//            }
        cell.textLabel?.text = friends[indexPath.row]
        cell.textLabel?.textColor = .systemMint
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)

        } else if indexPath.section == 1{
            cell.textLabel?.text = "index1 Text"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)

        } else if indexPath.section == 2{
            cell.textLabel?.text = "index2 Text"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        }
        return cell
    }

    
}
