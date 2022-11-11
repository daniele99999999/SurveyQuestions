//  
//  QuestionList.swift
//

import Foundation

public struct QuestionList {
    public struct Item: Codable {
        public let id: Int
        public let question: String
    }
}

extension QuestionList.Item: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

