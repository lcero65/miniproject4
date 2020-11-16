    //
    //  Category.swift
    //
    //  Created by Lamia Cero.
    //
    
    import Foundation
    import SwiftUI
    
    enum Category: Int, CustomStringConvertible, Codable {
        case technology = 1
        case gaming = 2
        case apple = 3
        case entertainment = 4
        case iOS = 5
        case sport = 6
        
        var description: String {
            switch self {
            case .technology:
                return "Technology"
            case .gaming:
                return "Gaming"
            case .apple:
                return "Apple"
            case .entertainment:
                return "Entertainment"
            case .iOS:
                return "iOS"
            case .sport:
                return "Sport"
            }
        }
        
        
    }
    extension Category{
        var color: UIColor{
            switch self {
            case .technology:
                return .blue
            case .gaming:
                return .red
            case .apple:
                return .gray
            case .entertainment:
                return .orange
            case .iOS:
                return .blue
            case .sport:
                return .purple
            }
        }
        
        var image: UIImage{
            switch self {
            case .technology:
                return UIImage(named: "technology") ?? UIImage(imageLiteralResourceName: "/")
            case .gaming:
                return UIImage(named: "gaming") ?? UIImage(imageLiteralResourceName: "/")
            case .apple:
                return UIImage(named: "apple") ?? UIImage(imageLiteralResourceName: "/")
            case .entertainment:
                return UIImage(named: "entertainment") ?? UIImage(imageLiteralResourceName: "/")
            case .iOS:
                return UIImage(named: "ios") ?? UIImage(imageLiteralResourceName: "/")
            case .sport:
                return UIImage(named: "sport") ?? UIImage(imageLiteralResourceName: "/")
            }
        }
        
    }
