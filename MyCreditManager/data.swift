//
//  data.swift
//  MyCreditManager
//
//  Created by KellyChui on 2023/04/21.
//

import Foundation

struct Student {
    var name: String
    var subject: [String: String] = [: ]
}

struct Data {
    var students: [Student] = []
    
    mutating func addStudent(name: String) -> Bool {
        if students.firstIndex(where: { $0.name == name }) != nil {
            return false
        } else {
            students.append(Student(name: name))
            return true
        }
    }
    
    mutating func deleteStudent(name: String) -> Bool {
        if let idx = students.firstIndex(where: { $0.name == name }) {
            students.remove(at: idx)
            return true
        } else {
            return false
        }
    }
    
    mutating func changeScore(name: String, subject: String, score: String) -> Bool {
        if let idx = students.firstIndex(where: { $0.name == name } ) {
            if students[idx].subject[subject] == nil {
                students[idx].subject[subject] = score
            } else {
                students[idx].subject[subject]! = score
            }
            return true
        } else {
            return false
        }
    }
    
    mutating func deleteScore(name: String, subject: String) -> Bool {
        if let idx = students.firstIndex(where: { $0.name == name } ) {
            students[idx].subject.removeValue(forKey: subject)
            return true
        } else {
            return false
        }
    }
    
    mutating func showAvg() {
        
    }
}
