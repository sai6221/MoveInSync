//
//  EmployeeManager.swift
//  MoveInSync
//
//  Created by Sai Reddy on 25/08/21.
//

import Foundation

protocol EmployeeDelegate {
    func didEmployee(_ employeeManager: EmployeeManager, employee: Employee)
    func didFailError(error: Error)
}

struct EmployeeManager{
    let demoURL = "https://dummy.restapiexample.com/api/v1/employee/1"
    
    var delegate: EmployeeDelegate?
    
    func performRequest(){
        //1. create URL
        if let url = URL(string: demoURL){
            //2. Create URL session
            
            let session = URLSession(configuration: .default)
            
            //3. Give session task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailError(error: error!)
                    return
                }
                if let safeData = data{
                    if let employee = self.parseJSON(safeData){
                        self.delegate?.didEmployee(self, employee: employee)
                    }
                }
            }
            
            //4. Resume task
            task.resume()
            
        }
    }
    
    func parseJSON(_ employeeData: Data) -> Employee? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(EmployeeData.self, from: employeeData)
//            let employees = []
            let id = decodedData.data.id
            let employee_name = decodedData.data.employee_name
            let employee_salary = decodedData.data.employee_salary
            let employee_age = decodedData.data.employee_age
            let profile_image = decodedData.data.profile_image
            
            let employee = Employee(id: id, employee_name: employee_name, employee_salary: employee_salary, employee_age: employee_age, profile_image: profile_image)
            return employee
            
        } catch{
            delegate?.didFailError(error: error)
            return nil
        }
    }
}
