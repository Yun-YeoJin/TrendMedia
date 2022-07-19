

import UIKit

//CaseIteralbe: 프로토콜, 배열처럼 열거형을 활용할 수 있는 특성
enum SettingOptions: Int, CaseIterable {
    case total, personal, others // 섹션(index: 3개)

var sectionTitle: String {
    switch self {
    case .total: return "전체 설정"
    case .personal: return "개인 설정"
    case .others: return "기타"
    }
}
    var rowTitle: [String] {
        switch self {
        case .total: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others: return ["고객센터/도움말"]
        }
    }
    
}

class SecondTableViewController: UITableViewController {
    
    
//    var 전체설정 = ["공지사항", "실험실", "버전 정보"]
//    var 개인설정 = ["개인/보안", "알림", "채팅", "멀티프로필"]
//    var 기타 = ["고객센터/도움말"]

//    enum NewSection: Int {
//        case number0
//        case number1
//        case number2
//    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // Section의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    // Cell의 헤더 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return SettingOptions.allCases[section].sectionTitle
        
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
        
        
        return SettingOptions.allCases[section].rowTitle.count
        
        
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
    // 전체 설정, 개인 설정, 기타
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell")!
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        
        return cell
        
//        if indexPath.section == 0 {
//
//            if indexPath.row == 0 {
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[0]
//            } else if indexPath.row == 1 {
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[1]
//            } else if indexPath.row == 2{
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[2]
//            }
//         } else if indexPath.section == 1 {
//            if indexPath.row == 0 {
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[0]
//            } else if indexPath.row == 1 {
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[1]
//            } else if indexPath.row == 2{
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[2]
//            } else if indexPath.row == 2{
//                cell.textLabel?.text = SettingOptions.allCases[0].rowTitle[3]
//            }
//        } ... 이하 생략

    }
    
   // 셀에 대한 높이를 지정 (옵션, 빈도 높은) (feat, tabelView, rowHeight)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

 

  
