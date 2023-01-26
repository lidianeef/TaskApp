//
//  NewToDoViewController.swift
//  TaskApp
//
//  Created by Lidiane Ferreira on 12/10/22.
//

import UIKit

protocol ToDoViewControllerDelegate: AnyObject { 
    func newToDoViewController(_ vc: NewToDoViewController, didSaveToDo: ToDo)
}

class NewToDoViewController: UIViewController {
  
    @IBOutlet weak var textField: UITextField!
    var toDo: ToDo?
    
    weak var delegate: ToDoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = toDo?.title

    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let currentToDo = ToDo(title: textField.text!)
        
        delegate?.newToDoViewController(self, didSaveToDo: currentToDo)
    }
    
}
