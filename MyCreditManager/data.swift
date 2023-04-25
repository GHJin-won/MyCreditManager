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

enum Grade: String {
    case aP = "A+"
    case a = "A"
    case bP = "B+"
    case b = "B"
    case cP = "C+"
    case c = "C"
    case dP = "D+"
    case d = "D"
    case f = "F"
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
    
    mutating func viewAvg(name: String) {
        if let idx = students.firstIndex(where: { $0.name == name } ) {
            let subjects = students[idx].subject
            let avg = subjects.values.map { scoreDict[$0]! }.reduce(0) { $0 + $1 } / Double(subjects.count)
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.numberStyle = .decimal
            subjects.keys.map { print("\($0): \(subjects[$0]!)") }
            if let formatted = formatter.string(for: avg) {
                print("평점 : \(formatted)") //
            }
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    
    mutating func showAvg() {
        
    }
}
