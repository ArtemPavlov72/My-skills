//
//  Question.swift
//  My skills
//
//  Created by Artem Pavlov on 04.02.2022.
//

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "My favorite dish?",
                type: .singe,
                answers: [
                    Answer(title: "Potatoes", degreeOfFamiliarity: .familiar),
                    Answer(title: "Pasta", degreeOfFamiliarity: .relative),
                    Answer(title: "Cabbage", degreeOfFamiliarity: .withOutMeting),
                    Answer(title: "Sishi", degreeOfFamiliarity: .friend)
                ]
            ),
            Question(
                title: "My hobbies are:",
                type: .multiple,
                answers: [
                    Answer(title: "Renovation", degreeOfFamiliarity: .friend),
                    Answer(title: "Collecting vinil", degreeOfFamiliarity: .relative),
                    Answer(title: "Boxing", degreeOfFamiliarity: .withOutMeting),
                    Answer(title: "Cinema", degreeOfFamiliarity: .familiar)
                ]
            ),
            Question(
                title: "How many years have I been driving the same car?",
                type: .ranged,
                answers: [
                    Answer(title: "1 year", degreeOfFamiliarity: .withOutMeting),
                    Answer(title: "2 years", degreeOfFamiliarity: .familiar),
                    Answer(title: "6 years", degreeOfFamiliarity: .friend),
                    Answer(title: "10 years", degreeOfFamiliarity: .relative)
                ]
            )
        ]
    }
}

enum ResponseType {
    case singe, multiple, ranged
}

struct Answer {
    let title: String
    let degreeOfFamiliarity: Familiarity
}

enum Familiarity: String {
    case withOutMeting = "are not acquainted",
         familiar = "familiar",
         friend = "friends",
         relative = "relatives"
    
    var definition: String {
        switch self {
        case .withOutMeting:
            return "No no, I,m not John..."
        case .familiar:
            return "Basically, I figured it out"
        case .friend:
            return "You're definitely not following me?"
        case .relative:
            return "I think I need to rethink my pedigree!"
        }
    }
}
