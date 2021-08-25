//
//  ViewController.swift
//  MoveInSync
//
//  Created by Sai Reddy on 24/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var employees = [Employee]()
    var employeeManager = EmployeeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        employeeManager.delegate = self
        employeeManager.performRequest()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
}
extension ViewController: EmployeeDelegate {
    func didEmployee(_ employeeManager: EmployeeManager, employee: Employee) {
        DispatchQueue.main.async {
            self.employees.append(employee)
            self.tableView.reloadData()
        }
           
//            print(self.employees)
        
    }
    
    func didFailError(error: Error) {
        print(error)
    }
    
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.employeeName.text = employees[indexPath.row].employee_name
        print(employees[indexPath.row].employee_name)
        return cell
    }
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            destination.employeeName = employees[(tableView.indexPathForSelectedRow?.row)!].employee_name
        }
//        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
}
