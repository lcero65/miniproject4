//
//  NewsStandViewModel.swift
//  NA-lxc2877-2
//
//  Created by Lamia Cero on 20/10/2020.
//

import Foundation
import Combine

class NewsStandViewModel: ObservableObject {
    @Published public var newsData: [NewsStand] = []
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        retrieveData()
    }
    
    func retrieveData() {
        guard let url = URL(string: "https://70o99.mocklab.io/newsstand") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: [NewsStand].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { self.newsData = $0 })
            .store(in: &cancellable)
        
        
    }
}

