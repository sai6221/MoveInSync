//
//  ViewController.swift
//  MoveInSync
//
//  Created by Sai Reddy on 24/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var employees: [Employee] = []
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
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "barSegue", sender: self)
    }
    
    @IBAction func refreshPressed(_ sender: UIBarButtonItem) {
        self.tableView.reloadData()
//        print(ViewController.employees)
    }
}
extension ViewController: EmployeeDelegate {
    func didEmployee(_ employeeManager: EmployeeManager, employee: EmployeeData) {
        DispatchQueue.main.async {
            ViewController.employees = employee.data
            self.tableView.reloadData()
        }
        
    }
    
    func didFailError(error: Error) {
        print(error)
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.employeeName.text = ViewController.employees[indexPath.row].employee_name
        cell.detailDescription.text = "Tap in, to get details of \(ViewController.employees[indexPath.row].employee_name)"
        return cell
    }
    
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue"{
            if let destination = segue.destination as? DetailsViewController{
                destination.employeeName = ViewController.employees[(tableView.indexPathForSelectedRow?.row)!].employee_name
                destination.employeeSalary = ViewController.employees[(tableView.indexPathForSelectedRow?.row)!].employee_salary
                destination.employeeAge = ViewController.employees[(tableView.indexPathForSelectedRow?.row)!].employee_age
            }
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
