//
//  Project.swift
//  My skills
//
//  Created by iMac on 29.01.2022.
//

struct Project {
    let title: String
    let description: String
    
    var fullDescription: String {
        "\(title). \(description)"
    }
}

extension Project {
    static func getProjectsList() -> [Project] {
        var projects: [Project] = []
        
        for projectCase in ProjectDescription.allCases {
            let project = Project(
                title: projectCase.projectData.title,
                description: projectCase.projectData.description
            )
            projects.append(project)
        }
        return projects
    }
}

enum ProjectDescription: CaseIterable {
    case trafficLights,
         quiz
    
    var projectData: Project {
        switch self {
        case .trafficLights:
            return Project(title: "Светофор", description: "Переключаем цвета на светофоре")
        case .quiz:
            return Project(title: "Квиз", description: "Узнай, какое ты животное!")
        }
    }
}
