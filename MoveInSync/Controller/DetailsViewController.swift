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
        Salary.text = "Salary: $\(employeeSalary!)"
        Age.text = "Age: \(employeeAge!) years"
        
        // Do any additional setup after loading the view.
    }

}
