import UIKit

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todoTableView: UITableView!
    
    var todos: [String] = ["Go to sleep at 9", "Do chores", "Do exercise"]
    
    var name: String = "Name Transfered?"
    var exp: Int = 0
    var level: Int = 0
    var curve: [Int] = [0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if name == "" {
            nameLabel.text = "Unnamed"
        }
        else {
            nameLabel.text = name
        }
        updateStats()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.rowHeight = 60
    }
    
    func updateStats() {
        level = 0;
        if exp > 4500 {
            exp = 4500
        }
        for point in curve {
            if exp >= point {
                level += 1
            }
        }
        
        levelLabel.text = "Level \(String(level))"
        
        if exp == 4500 {
            expLabel.text = "EXP: \(String(exp))/4500"
        }
        else {
            expLabel.text = "EXP: \(String(exp))/\(String(curve[level]))"
        }
        
    }
    
    
    @IBAction func GainEXPButton(_ sender: Any) {
        exp += 50
        updateStats()
    }
    
    
    @IBAction func addTodo(_ sender: Any) {
        
        let todoAlert = UIAlertController(title: "Add Todo", message: "Add a new todo", preferredStyle: .alert)
        
        todoAlert.addTextField()
        
        let addTodoAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTodo = todoAlert.textFields![0]
            self.todos.append(newTodo.text!)
            self.todoTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        todoAlert.addAction(addTodoAction)
        todoAlert.addAction(cancelAction)
        
        present(todoAlert, animated: true, completion: nil)
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        
        cell.todoLabel.text = todos[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        
        if cell.isChecked == false {
            cell.checkmarkImage.image = UIImage(named: "checkmark.png")
            cell.isChecked = true
            exp += 50
            updateStats()
        }
        else {
            cell.checkmarkImage.image = nil
            cell.isChecked = false
            exp -= 50
            updateStats()
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            todoTableView.reloadData()
        }
    }
    
}
