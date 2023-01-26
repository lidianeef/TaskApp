//
//  ToDo.swift
//  TaskApp
//
//  Created by Lidiane Ferreira on 07/10/22.
//

import Foundation

struct ToDo {
    let title: String
    let isComplete: Bool
    
    init (title: String, isComplete: Bool = false) {
        self.title = title
        self.isComplete = isComplete
    }
    func completeToggled() -> ToDo {
        return ToDo(title: title, isComplete: !isComplete)
    }
    
}
