//
//  EmployeeManager.swift
//  MoveInSync
//
//  Created by Sai Reddy on 25/08/21.
//

import Foundation

protocol EmployeeDelegate {
    func didEmployee(_ employeeManager: EmployeeManager, employee: EmployeeData)
    func didFailError(error: Error)
}

struct EmployeeManager{
    let demoURL = "https://dummy.restapiexample.com/api/v1/employees"
    
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
    
    func parseJSON(_ employeeData: Data) -> EmployeeData? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(EmployeeData.self, from: employeeData)
            return decodedData
            
        } catch{
            delegate?.didFailError(error: error)
            return nil
        }
    }
}
