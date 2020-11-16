//
//  ArticleViewModel.swift
//  NA-lxc2877-2
//
//  Created by Lamia Cero on 20/10/2020.
//
import Foundation
import Combine

class ArticleViewModel: ObservableObject{
    @Published private(set) var articleData: [Article]? = nil
    @Published private(set) var bookmark: [Article] = []
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        retrieveData()
    }
 
    public func bookmarkExists(_ article : Article) -> Bool {
        bookmark.contains(where: {$0.id == article.id})
    }
    
    public func addBookmark(_ article: Article){
        bookmark.append(article)
    }
  
    public func removeBookmark(_ article: Article){
        if let index = bookmark.firstIndex(where: { $0.id == article.id })
        {
            bookmark.remove(at: index)
            
        }
    }
    public func deleteBookmark(at offsets: IndexSet){
        bookmark.remove(atOffsets: offsets)
    }
    
    func retrieveData() {
        guard let url = URL(string: "https://70o99.mocklab.io/news") else {
            return
        }
        
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: [Article].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { self.articleData = $0 })
            .store(in: &cancellable)
        
        
    }
}

