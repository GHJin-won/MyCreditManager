//
//  main.swift
//  MyCreditManager
//
//  Created by KellyChui on 2023/04/21.
//

import Foundation

var students: [Student] = []

struct Student {
    var name: String
    var subject: [String: String] = [: ]
}

let scoreDict: [String: Double] = ["A+": 4.5, "A": 4, "B+": 3.5, "B": 3, "C+": 2.5, "C": 2, "D+": 1.5, "D": 1, "F": 0]

func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    let studentName = readLine()!
    if studentName == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    } else {
        if students.firstIndex(where: { $0.name == studentName }) != nil {
            print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            students.append(Student(name: studentName))
            print("\(studentName) 학생을 추가했습니다.")
        }
    }
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    let studentName = readLine()!
    if let idx = students.firstIndex(where: { $0.name == studentName }) {
        students.remove(at: idx)
        print("\(studentName) 학생을 삭제하였습니다.")
    } else {
        print("\(studentName) 학생을 찾지 못했습니다.")
    }
}

func changeScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    let command = readLine()!.split(separator: " ").map { String($0) }
    if command.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if let idx = students.firstIndex(where: { $0.name == command[0] } ) {
        if students[idx].subject[command[1]] == nil {
            students[idx].subject[command[1]] = command[2]
        } else {
            students[idx].subject[command[1]]! = command[2]
        }
        print("\(command[0]) 학생의 \(command[1]) 과목이 \(command[2])로 추가(변경)되었습니다.")
    } else {
        print("\(command[0]) 학생을 찾지 못했습니다.")
    }
}

func deleteScore() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    let command = readLine()!.split(separator: " ").map { String($0) }
    if command.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if let idx = students.firstIndex(where: { $0.name == command[0] } ) {
        students[idx].subject.removeValue(forKey: command[1])
        print("\(command[0]) 학생의 \(command[1]) 과목의 성적이 삭제되었습니다.")
    } else {
        print("\(command[0]) 학생을 찾지 못했습니다.")
    }
}

func viewAvg() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    let studentName = readLine()!
    if studentName == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if let idx = students.firstIndex(where: { $0.name == studentName } ) {
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
        print("\(studentName) 학생을 찾지 못했습니다.")
    }
}

func endLoop() {
    print("프로그램을 종료합니다...")
}

func mainLoop() {
    while true {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        let input = readLine()!
        switch input {
        case "1":
            addStudent()
        case "2":
            deleteStudent()
        case "3":
            changeScore()
        case "4":
            deleteScore()
        case "5":
            viewAvg()
        case "X":
            endLoop()
            return
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}

mainLoop()
