//
//  DetailView.swift
//  NA-lxc2877-3
//
//  Created by Lamia Cero on 05/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI


struct DetailView: View {
    
    var article: Article
    @ObservedObject  var articleView = ArticleViewModel()
    
    var body: some View {
        
        ScrollView{
            
            HStack{
                WebImage(url: article.imageUrl)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .aspectRatio(contentMode: .fit)
                    .offset(y: -50)
                    .padding(.bottom, -50)
                
            }
            HStack(spacing: 20){
                HStack{
                    Image(systemName: "pencil")
                    Text("\(article.author ?? "N/A")")
                        .foregroundColor(.secondary)
                }
                HStack{
                    Image(systemName: "star")
                    Text(String(article.rating))
                        .foregroundColor(.secondary)
                }
                HStack{
                    Image(systemName: "eye")
                    Text(String(article.views))
                        .foregroundColor(.secondary)
                }
                
            }
            
            VStack{
                Text(article.source)
                    .font(.title)
                
                Text(article.title)
                    .font(.title3)
                    .fontWeight(.black)
                    .padding(.vertical)
                
                Text(article.content)
                    //  .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.black)
                    .padding(.vertical)
                Spacer()
                VStack{
                    Link("\(article.url)", destination: URL(string: "\(article.url)")!)
                    
                }
                
                
            }
            
        }
    }
    
    
}
