//
//  AddViewController.swift
//  MoveInSync
//
//  Created by Sai Reddy on 25/08/21.
//
import UIKit
import Foundation

class AddViewController: UIViewController {
    
    //POST REQUEST HAS NOT BEEN IMPLEMENTED AS THE API's POST LINK IS NOT WORKING

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var ne = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        salaryTextField.delegate = self
        ageTextField.delegate = self
        let tapG = UITapGestureRecognizer(target: self, action: #selector(AddViewController.handleTap))
        view.addGestureRecognizer(tapG)
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(){
        print("Handle Tap")
        view.endEditing(true)
    }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
//        print("Name is \(nameTextField.text!) and salary is \(salaryTextField.text!) and age is \(ageTextField.text!)")
        if let name = nameTextField.text, let sal = Int(salaryTextField.text ?? "0" ), let age = Int(ageTextField.text ?? "0"){
            
            let new = Employee(id: ViewController.employees.count, employee_name: name, employee_salary: sal, employee_age: age)
            ViewController.employees.append(new)
            
            guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/create") else{
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.timeoutInterval = 20
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "name": name,
                "salary": sal,
                "age": age,
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let response = try JSONDecoder().decode(POST.self, from: data)
                    print("SUCCESS\(response)")
                }
                catch{
                    print(error)
                }
            }
            
            task.resume()

        }
//        print(ViewController.employees)
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
}

extension AddViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
