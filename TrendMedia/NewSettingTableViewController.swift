

import UIKit

class NewSettingTableViewController: UITableViewController {

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
    // 재사용 매커니즘
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt", indexPath)

        if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            cell.textLabel?.text = "2번 인덱스 섹션의 텍스트"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            
            // 행의 색상 바꾸기 (홀수번, 짝수번) == indexPath.row % 2 == 0, 1
            if indexPath.row % 2 == 0 {
                cell.imageView?.image = UIImage(systemName: "star")
                cell.backgroundColor = .lightGray
            } else {
                cell.imageView?.image = UIImage(systemName: "star.fill")
                cell.backgroundColor = .systemMint
            }
            
            // 삼항 연산자 이용
            cell.imageView?.image = indexPath.row % 2 == 0 ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .systemMint
            
            
            return cell
        } else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewSettingCell")!

        if indexPath.section == 0 {
        cell.textLabel?.text = friends[indexPath.row]
        cell.textLabel?.textColor = .systemMint
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)

        } else if indexPath.section == 1{
            cell.textLabel?.text = "index1 Text"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        }
        return cell
    }

    
}
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // if indexPath == [0,0]
        if indexPath.section == 0 && indexPath.row == 0{
            return 400
        } else {
            return 44
        }
    }

}
