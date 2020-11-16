
import SwiftUI
import SDWebImageSwiftUI

struct ArticleRow: View {
    
    var article: Article
    @Binding var isCompact: Bool
    
    var body: some View {
        if(isCompact){
            HStack() {
                VStack(alignment: .leading){
                    Text(article.title)
                        .frame(height:20)
                    Text(article.content)
                        .frame(height: 30)
                        .font(.subheadline)
                }.frame(maxWidth: .infinity)
                .padding(1)
                WebImage(url: article.imageUrl)
                    .resizable()
                    .placeholder {
                        Rectangle().fill(Color.clear)
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            }
        }
        else{
            
            HStack() {
                VStack(alignment: .leading){
                    WebImage(url: article.imageUrl)
                        .resizable()
                        .placeholder {
                            Rectangle().fill(Color.clear)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .cornerRadius(10)
                    Text(article.title)
                        .frame(height:20)
                    
                }.frame(maxWidth: .infinity)
                .padding(1)
                
            }
            
        }
        
    }
    
}

