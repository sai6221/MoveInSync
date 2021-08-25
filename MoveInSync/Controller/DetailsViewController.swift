//
//  DetailsViewController.swift
//  MoveInSync
//
//  Created by Sai Reddy on 25/08/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Salary: UILabel!
    @IBOutlet weak var Age: UILabel!
    
    
    var employeeName: String? = nil
    var employeeSalary: Int? = nil
    var employeeAge: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Name.text = employeeName
        Salary.text = "$\(employeeSalary)"
        Age.text = "\(employeeAge) years"
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
