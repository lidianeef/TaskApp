//
//  ViewController.swift
//  TaskApp
//
//  Created by Lidiane Ferreira on 07/10/22.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var cell: UITableView!
    
    var toDoArray = [
        ToDo(title: "Comprar verduras"),
        ToDo(title: "Marcar médico"),
        ToDo(title: "Fazer as unhas")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startEditing(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBSegueAction func toDoViewController(_ coder: NSCoder) -> NewToDoViewController? {
        let vc = NewToDoViewController(coder: coder)
        
        if let indexpath =  tableView.indexPathForSelectedRow {
            let currentToDo = toDoArray[indexpath.row]
            vc?.toDo = currentToDo
        }
        
        vc?.delegate = self
        vc?.presentationController?.delegate = self
        
        return vc
    }
    
}

//MARK: - Table View Delegate

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        

        let action = UIContextualAction(style: .normal, title: "Feito") {action, view, complete in
            
            
            let currentToDo = self.toDoArray[indexPath.row].completeToggled()
            self.toDoArray[indexPath.row] = currentToDo
            

            let newCell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            newCell.set(checked: currentToDo.isComplete)
            
            complete(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}


//MARK: - Table View Data Source

extension ViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        cell.delegate = self
        
        let currentToDo = toDoArray[indexPath.row]
        cell.set(title: currentToDo.title, checked: currentToDo.isComplete)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            toDoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        
        let toDoArrayEditing = toDoArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(toDoArrayEditing, at: destinationIndexPath.row)
    }
    
}

//MARK: - Check Table View Cell Delegate

extension ViewController: CheckTableViewCellDelegate {
    
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedStade checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let currentToDo = toDoArray[indexPath.row]
        let newCurrentToDo = ToDo(title: currentToDo.title, isComplete: currentToDo.isComplete)
        
        toDoArray[indexPath.row] = newCurrentToDo
    }
}

//MARK: - extension View Controller Delegate

extension ViewController: ToDoViewControllerDelegate {
    
    func newToDoViewController(_ vc: NewToDoViewController, didSaveToDo: ToDo) {
    
        dismiss(animated: true) {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                self.toDoArray[indexPath.row] = didSaveToDo
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }else {
                
                self.toDoArray.append(didSaveToDo)
                self.tableView.insertRows(at: [IndexPath(row: self.toDoArray.count-1, section: 0)], with: .automatic)
            }
        }
    }
}


extension ViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
     
        if let indexPath = tableView.indexPathForSelectedRow {
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
