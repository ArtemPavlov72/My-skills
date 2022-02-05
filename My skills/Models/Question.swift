//
//  Question.swift
//  My skills
//
//  Created by iMac on 04.02.2022.
//

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Мое любимое блюдо?",
                type: .singe,
                answers: [
                    Answer(title: "Картошечка", degreeOfFamiliarity: .familiar),
                    Answer(title: "Макароны", degreeOfFamiliarity: .relative),
                    Answer(title: "Капуста", degreeOfFamiliarity: .withOutMeting),
                    Answer(title: "Суши", degreeOfFamiliarity: .friend)
                ]
            ),
            Question(
                title: "Мои увлечения - это:",
                type: .multiple,
                answers: [
                    Answer(title: "Ремонт", degreeOfFamiliarity: .friend),
                    Answer(title: "Винил", degreeOfFamiliarity: .relative),
                    Answer(title: "Бокс", degreeOfFamiliarity: .withOutMeting),
                    Answer(title: "Кино", degreeOfFamiliarity: .familiar)
                ]
            ),
            Question(
                title: "Сколько лет я езжу на одной машине?",
                type: .ranged,
                answers: [
                    Answer(title: "1 год", degreeOfFamiliarity: .withOutMeting),
                    Answer(title: "2 года", degreeOfFamiliarity: .familiar),
                    Answer(title: "6 лет", degreeOfFamiliarity: .friend),
                    Answer(title: "10 лет", degreeOfFamiliarity: .relative)
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
    case withOutMeting = "не знакомы",
         familiar = "знакомые",
         friend = "друзья",
         relative = "родственники"
    
    var definition: String {
        switch self {
        case .withOutMeting:
            return "Нет нет, Пашей я никогда не был..."
        case .familiar:
            return "В принципе, я догадывался об этом"
        case .friend:
            return "Ты точно не следишь за мной?"
        case .relative:
            return "Кажется, мне стоит пересмотреть свое древо!"
        }
    }
}
