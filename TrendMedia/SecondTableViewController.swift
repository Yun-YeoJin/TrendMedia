

import UIKit

class SecondTableViewController: UITableViewController {
    
    
    var 전체설정 = ["공지사항", "실험실", "버전 정보"]
    var 개인설정 = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var 기타 = ["고객센터/도움말"]

    enum NewSection: Int {
        case number0
        case number1
        case number2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    // 섹션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // Cell의 헤더 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        
        switch section {
        case NewSection.number0.rawValue: return "전체 설정"
        case NewSection.number1.rawValue: return "개인 설정"
        case NewSection.number2.rawValue: return "기타"
        default: return "nothing"
        }

//        if section == 0 {
//            return "전체 설정"
//        } else if section == 1 {
//                return "개인 설정"
//            } else if section == 2 {
//                return "기타"
//            } else {
//                return "헤더"
//            }
        
    
        }
    
    
    
    // 1. 셀의 갯수(필수) / numberOfRowsInsection
    // 전체 설정 3개 / 개인 설정 4개 / 기타 1개
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
        case NewSection.number0.rawValue: return 3
        case NewSection.number1.rawValue: return 4
        case NewSection.number2.rawValue: return 1
        default: return 0
        }
        
//        if section == 0 { // 전체 설정
//            return 3
//        } else if section == 1{ // 개인 설정
//            return 4
//        } else if section == 2{ // 기타
//            return 1
//        } else {
//            return 0
//        }
    
    }

    // 2. 셀의 디자인과 데이터(필수) / cellForRowAt
    // 전체 설정, 개인 선절, 기타
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell")!
        
        if indexPath.section == 0 {
            
        cell.textLabel?.text = 전체설정[indexPath.row]
        cell.textLabel?.textColor = .systemMint
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            
        } else if indexPath.section == 1{
            cell.textLabel?.text = 개인설정[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            
        } else if indexPath.section == 2{
            cell.textLabel?.text = 기타[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        return cell
    }

    
}

 

  
