//
//  CheckTableViewCell.swift
//  TaskApp
//
//  Created by Lidiane Ferreira on 07/10/22.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject {
    func checkTableViewCell (_ cell: CheckTableViewCell, didChangeCheckedStade checked: Bool)
}

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    
    weak var delegate: CheckTableViewCellDelegate?
    
    @IBAction func checked(_ sender: CheckBox) {
        updateChecked()
        delegate?.checkTableViewCell(self, didChangeCheckedStade: checkBox.checked)
    }
    
    func set(title: String, checked: Bool) {
        label.text = title
        set(checked: checked)
    }

    func set(checked: Bool){
        checkBox.checked = checked
        updateChecked()
    }
    
    
   private func updateChecked() {
        let attributtedString = NSMutableAttributedString(string: label.text!)
        
        if checkBox.checked {
            attributtedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributtedString.length-1))
        } else {
            attributtedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributtedString.length-1))
        }
        
        label.attributedText = attributtedString
    }
    
    
}
