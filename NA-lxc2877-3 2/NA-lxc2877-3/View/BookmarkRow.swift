//
//  BookmarkRow.swift
//  NA-lxc2877-3
//
//  Created by Lamia Cero on 01/11/2020.
//
import SwiftUI
import SDWebImageSwiftUI

struct BookmarkRow: View {
    
    var bookmark: Article
    @Binding var isCompact: Bool
    
    var body: some View {
        if(isCompact){
            HStack() {
                VStack(alignment: .leading){
                    Text(bookmark.title)
                        .frame(height:20)
                    Text(bookmark.content)
                        .frame(height: 30)
                        .font(.subheadline)
                }.frame(maxWidth: .infinity)
                .padding(1)
                WebImage(url: bookmark.imageUrl)
                    .resizable()
                    .placeholder {
                        Rectangle().fill(Color.clear)
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            }
        }    else{
            HStack() {
                VStack(alignment: .leading){
                    WebImage(url: bookmark.imageUrl)
                        .resizable()
                        .placeholder {
                            Rectangle().fill(Color.clear)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .cornerRadius(10)
                    Text(bookmark.title)
                        .frame(height:20)
                    
                }.frame(maxWidth: .infinity)
                .padding(1)
                
            }
        }
    }
}


