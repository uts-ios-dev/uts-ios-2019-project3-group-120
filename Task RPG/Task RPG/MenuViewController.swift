import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        name.delegate = self
    }
    
    // Sets the name of the user in the task view from the text entered in the text field in this view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start" {
            let destination = segue.destination as! TaskViewController
            destination.name = name.text!
        }
    }

}

