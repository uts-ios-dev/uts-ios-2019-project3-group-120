import UIKit

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks: [String] = ["Go to sleep at 9", "Do chores", "Do exercise"]
    
    var name: String = "Name Transfered?"
    var exp: Int = 0
    var level: Int = 0
    var curve: [Int] = [0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Displays name on label
        if name == "" {
            nameLabel.text = "Unnamed"
        }
        else {
            nameLabel.text = name
        }
        updateStats()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.rowHeight = 60
    }
    
    // Determines level from exp amount and displays the amount of exp required to reach the next level
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
    
    
    @IBAction func addExp(_ sender: Any) {
        exp += 50
        updateStats()
    }
    
    // Shows an alert when the add task button is tapped, with a single text field and a add and cancel button
    @IBAction func addTask(_ sender: Any) {
        
        let taskAlert = UIAlertController(title: "Add Task", message: "Add a new task", preferredStyle: .alert)
        
        taskAlert.addTextField()
        
        let addTaskAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTask = taskAlert.textFields![0]
            self.tasks.append(newTask.text!)
            self.taskTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        taskAlert.addAction(addTaskAction)
        taskAlert.addAction(cancelAction)
        
        present(taskAlert, animated: true, completion: nil)
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskLabel.text = tasks[indexPath.row]
        
        return cell
    }
    
    // Marks a task as done when it is tapped, or, if it is already done, marks it as undone. Done tasks give 50 exp while they are done
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell
        
        if cell.isDone == false {
            cell.checkmarkImage.image = UIImage(named: "checkmark.png")
            cell.isDone = true
            exp += 50
            updateStats()
        }
        else {
            cell.checkmarkImage.image = nil
            cell.isDone = false
            exp -= 50
            updateStats()
        }
        
    }
    
    // Remove tasks permanently (locked in done) without losing exp
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            taskTableView.reloadData()
        }
    }
    
}
