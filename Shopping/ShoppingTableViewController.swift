

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    let localRealm = try! Realm()
    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var SearchTextField: UITextField! {
        didSet {
            SearchTextField.placeholder = "무엇울 구매하실 건가요?"
            SearchTextField.borderStyle = .bezel
        }
    }
    
    var tasks: Results<ShoppingList>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchTextField.delegate = self
        
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
        
        AddButtonDesign()
        
    }
    
    //셀의 갯수 - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    //셀의 내용 - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        
        
        if tasks?[indexPath.row].checkBox == false {
            cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        if tasks?[indexPath.row].favorite == false {
            cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
        cell.contentsLabel.text = tasks[indexPath.row].shoppingContents
        
        cell.checkBoxButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
                tableView.reloadData()
            }
        }
        
    }
    
    func AddButtonDesign() {
        AddButton.backgroundColor = .opaqueSeparator
        AddButton.setTitle("추가", for: .normal)
        AddButton.tintColor = .black
    }
    
    @IBAction func AddButtonClicked(_ sender: UIButton) {
        
        let task = ShoppingList(shoppingContents: "\(SearchTextField.text ?? "")") // => Record를 추가하는 과정
        
        try! localRealm.write {
            localRealm.add(task) // => Create 하는 과정
            tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
            tableView.reloadData()
        }
        
    }
    
    @IBAction func checkBoxButtonClicked(_ sender: UIButton) {
        
        let task = tasks?[sender.tag]
        
        if task?.checkBox == true {
            try! localRealm.write {
                task?.checkBox = false
            }
        } else {
            try! localRealm.write {
                task?.checkBox = true
            }
        }
        tableView.reloadData()
        
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        
        let task = tasks?[sender.tag]
        
        if task?.favorite == true {
            try! localRealm.write {
                task?.favorite = false
            }
        } else {
            try! localRealm.write {
                task?.favorite = true
            }
        }
        tableView.reloadData()
        
        
    }
    
    
}

extension ShoppingTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let task = ShoppingList(shoppingContents: SearchTextField.text ?? "")
        
        try! localRealm.write{
            localRealm.add(task)
            tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
            tableView.reloadData()
        }
        
        SearchTextField.text = ""
        return true
    }
}
