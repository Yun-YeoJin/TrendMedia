

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
        
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
        
        AddButtonDesign()
        
        AddButton.addTarget(self, action: #selector(AddButtonClicked), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents")
        
        
    }
    
    //셀의 갯수 - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    //셀의 내용 - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.contentsLabel.text = tasks[indexPath.row].shoppingContents
        
        return cell
    }
    
    @IBAction func AddButtonClicked(_ sender: UIButton) {
        
        let task = ShoppingList(shoppingContents: "\(SearchTextField.text ?? "")") // => Record를 추가하는 과정
        
        try! localRealm.write {
            localRealm.add(task) // => Create 하는 과정
            print("Realm Succeed")
            self.dismiss(animated: true)
        }
        
        tableView.reloadData()
        
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
}
