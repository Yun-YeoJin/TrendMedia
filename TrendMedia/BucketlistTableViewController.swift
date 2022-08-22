

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {
    
    
    static let identifier = "BucketlistTableViewController"
    
    //1. 프로퍼티 생성
    var textFieldPlaceholder: String?
    //옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유는?
    //Placeholder 자체가 옵셔널이라면?
    //하지만 String Interpolation이라면?
    
    
    //list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신!
    var list = [Todo(title: "범죄도시2", done: true),Todo(title: "비상선언", done: false),Todo(title: "탑건", done: true)] {
        didSet{
            //tableView.reloadData()
            printContent("list가 변경됨! \(list), \(oldValue)")
        }
    }
    
    @IBOutlet weak var usefTextField: UITextField!{
        didSet{
            usefTextField.textAlignment = .center
            usefTextField.font = .boldSystemFont(ofSize: 22)
            usefTextField.textColor = .lightGray
            print("텍스트필드 didset")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usefTextField.text = ""
        usefTextField.placeholder = textFieldPlaceholder
        
        navigationItem.title = "버킷리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    //셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //셀의 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifier, for: indexPath) as! BucketlistTableViewCell //as! 타입캐스팅
        
        cell.titleLabel.text = list[indexPath.row].title
        cell.titleLabel.font = .boldSystemFont(ofSize: 15)
        
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonClicked), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        return cell
    }
    
    
    
    @objc func checkboxButtonClicked(sender: UIButton) {
        print("\(sender.tag) 버튼이 클릭되었따")
        
        // 배열 인덱스를 찾아서 done을 바꿔야한다! 그리고 테이블뷰 갱신 해야 한다
        list[sender.tag].done = !list[sender.tag].done
        
        // tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        //        if list[sender.tag].done {
        //            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        //            list[sender.tag].done = false
        //        } else {
        //            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        //            list[sender.tag].done = true
        //        }
        
        
        // 재사용 셀 오류 확인 코드
        
        // sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        
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
    
    
    
    //reloadData() 이용
    @IBAction func userTextfieldReturn(_ sender: UITextField) {
        
        
        //list.append(sender.text!)
        
        list.append(Todo(title: "마녀2", done: true))
        tableView.reloadData()
        
        //        // 2번 방법
        //        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
        //            list.append(value)
        //            tableView.reloadData()
        //        } else {
        //            // 토스트 메시지 띄우기
        //        }
        //
        //        // 3번 방법
        //        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count)
        //        else { // 만약 문제가 있다면 return
        //            return
        //        }
        
        
        // 1번 방법
        //        list.append(sender.text!)
        //        tableView.reloadData()
        
        // tableView.reloadSections(IndexSet(), with: )
        // tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        //        tableView.numberOfRows(inSection: <#T##Int#>)
        //        tableView.cellForRow(at: IndexPath)
        
    }
    
}
