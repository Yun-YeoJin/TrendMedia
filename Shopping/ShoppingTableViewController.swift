

import UIKit

class ShoppingTableViewController: UITableViewController {



    
 
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var SearchTextField: UITextField! {
        didSet {
            SearchTextField.placeholder = "무엇울 구매하실 건가요?"
            SearchTextField.borderStyle = .bezel
        }
    }
    
    var ShoppingList = ["그립톡 구매하기", "사이다 구매하기", "아이패드 케이스 구매하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AddButtonDesign()
        
        ShoppingList.append("양말 구매하기")
       
    }
    //셀의 갯수 - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingList.count
    }
    //셀의 내용 - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell //as! 타입캐스팅
        
        cell.contentsLabel.text = ShoppingList[indexPath.row]
        cell.contentsLabel.font = .boldSystemFont(ofSize: 13)
        
        // 짝수행 / 홀수행 나누기
        if indexPath.row % 2 == 0 {
        cell.checkBoxImageView.image = UIImage(systemName: "checkmark.square.fill")
        } else if indexPath.row % 2 == 1{
            cell.checkBoxImageView.image = UIImage(systemName: "checkmark.square")
        }
       
        cell.checkBoxImageView.tintColor = .black
        
        return cell
    }
    
    // 편집이 가능한 셀로 만들어준다. - canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 우측 스와이프 디폴트 기능: commit editingStyle (위 canEditRowAt을 return true로 해줘야 사용 가능)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //배열 삭제 후 테이블뷰 갱신
            ShoppingList.remove(at: indexPath.row)
            tableView.reloadData()
            

        }
    }

    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func AddButtonClicked(_ sender: UIButton) {
    
    }
    
   
    @IBAction func TextFieldDone(_ sender: UITextField) {
    
        ShoppingList.append(sender.text!)
        // 가장 중요한 코드!!!!!!
        tableView.reloadData()
    
}
    
    func AddButtonDesign() {
        AddButton.backgroundColor = .opaqueSeparator
        AddButton.setTitle("추가", for: .normal)
        AddButton.tintColor = .black
    }
}
