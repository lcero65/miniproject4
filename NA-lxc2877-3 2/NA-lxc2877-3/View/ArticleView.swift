import SwiftUI


struct ArticleView: View {
    
    @ObservedObject  var articleView = ArticleViewModel()
    @Binding var isCompact: Bool
    
    private var artData: [Article]{
        return articleView.articleData ?? []
    }
    
    var body: some View {
        List {
            ForEach(artData)
            { article in
                NavigationLink(
                    destination: DetailView(article: article)
                        .navigationBarItems(trailing:
                                                Button(action: {
                                                    if articleView.bookmarkExists(article){
                                                        articleView.removeBookmark(article)
                                                    } else {
                                                        articleView.addBookmark(article)
                                                    }
                                                })
                                                {
                                                    if articleView.bookmarkExists(article){
                                                        Image(systemName: "bookmark.fill")
                                                    }
                                                    else{
                                                        Image(systemName: "bookmark")
                                                    }
                                                }
                        )) {
                    ArticleRow(article:article, isCompact: $isCompact)
                        
                        .padding(1)
                }
            }
        }
        .navigationBarItems(trailing:
                                Button(action: {
                                    isCompact.toggle()
                                }){
                                    Text(isCompact ? "non-compact" : "compact")
                                }
        )
    }
}



