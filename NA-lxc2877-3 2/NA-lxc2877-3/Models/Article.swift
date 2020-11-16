//
//  Article.swift
//
//  Created by Andrej Saric.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let imageUrl: URL?
    let url: URL
    let author: String?
    let publishedAt: Date
    let source: String
    let views: Int
    let rating: Int
    let relatedArticles: [Int]
    let category: Category
}
