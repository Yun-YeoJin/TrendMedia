

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
    
    var tasks: Results<ShoppingList>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchTextField.delegate = self
        
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
        
        AddButtonDesign()
        
        navigationItem.title = "쇼핑목록"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.star"), primaryAction: nil, menu: sortButtonClicked())
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "백업/복구", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func backupButtonClicked() {
        guard let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "BackupViewController") as? BackupViewController else {return}
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sortButtonClicked() -> UIMenu {
        
        let sortContents = UIAction(title: "가나다순", image: UIImage(systemName: "abc")) { _ in
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
        }
        let sortCheckBox = UIAction(title: "체크순", image: UIImage(systemName: "checkmark.square.fill")) { _ in
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "checkBox")
        }
        let sortFavorite = UIAction(title: "즐겨찾기순", image: UIImage(systemName: "star.fill")) { _ in
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "favorite")
        }
        
        let menu = UIMenu(title: "목록 정렬하기", identifier: nil, options: .destructive, children: [sortContents, sortCheckBox, sortFavorite])
        
        return menu
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
            cell.userImageView.image = UIImage(systemName: "tortoise.fill")
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            cell.userImageView.image = UIImage(systemName: "hare.fill")
        }
        
        cell.userImageView.tintColor = .black
        cell.contentsLabel.text = tasks[indexPath.row].shoppingContents
        cell.checkBoxButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "ShoppingListDetailViewController") as? ShoppingListDetailViewController else {return}
      
        self.present(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
            }
        }
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "수정하기") { action, view, completionHandler in
            
            try! self.localRealm.write {
                self.localRealm.create(ShoppingList.self, value: ["objectID": self.tasks[indexPath.row].objectID, "shoppingContents": "여기에 수정되는 내용이 들어갑니다."], update: .modified)
            }
            
            self.tasks = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
        }
        
        return UISwipeActionsConfiguration(actions: [edit])
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
        }
        
        SearchTextField.text = ""
        return true
    }
}
