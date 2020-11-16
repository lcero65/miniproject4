import SwiftUI

struct BookmarkView: View {
    
    @ObservedObject  var bookmarkView = ArticleViewModel()
    @Binding var isCompact: Bool
    
    private var bookmark: [Article]{
        bookmarkView.bookmark
    }
    
    var body: some View {
        
        List {
            ForEach(bookmark) { bookmark in
                NavigationLink(
                    destination: DetailView(article: bookmark)
                        .navigationBarItems(trailing:
                                                Button(action: {
                                                    if bookmarkView.bookmarkExists(bookmark){
                                                        bookmarkView.removeBookmark(bookmark)
                                                    } else {
                                                        bookmarkView.addBookmark(bookmark)
                                                    }
                                                })
                                                {
                                                    if bookmarkView.bookmarkExists(bookmark){
                                                        Image(systemName: "bookmark.fill")
                                                    }
                                                    else{
                                                        Image(systemName: "bookmark")
                                                    }
                                                }
                        ))
                {
                    BookmarkRow(bookmark: bookmark, isCompact: $isCompact)
                        
                        .padding(1)
                }
            }.onDelete(perform: bookmarkView.deleteBookmark)
        }
        
    }
    
    
}


