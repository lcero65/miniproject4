//
//  ContentView.swift
//  NA-lxc2877-2
//
//  Created by Lamia Cero on 20/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit


struct ContentView: View {
    
    @ObservedObject private var newsStandView = NewsStandViewModel()
    @ObservedObject private var articleView = ArticleViewModel()
    
    @State private var isCompact: Bool = false
    @State private var mapState: MapView.MapState? = nil
    
    struct MapSelection{
        var name: String
        var map: MKMapType
    }
    
    @State var mapStyle = [MapSelection(name: "Standard", map: .standard),MapSelection(name: "Hybrid", map: .hybridFlyover), MapSelection(name: "Satelite", map: .satellite)]
    
    @State private var segment = 0
    
    private var newData: [NewsStand]{
        newsStandView.newsData
    }
    
    var body: some View {
        TabView{
            NavigationView {
                ArticleView(articleView: articleView, isCompact: $isCompact)
                    .navigationBarTitle("News").accentColor(.black)
                    
                    .padding(1)
            }.tabItem{
                Image(systemName: "waveform.path.ecg")
                Text("News")
            }
            
            
            .tag(0)
            NavigationView {
                BookmarkView(bookmarkView : articleView, isCompact: $isCompact)
                    .navigationBarTitle("Bookmark").accentColor(.black)
            }.tabItem{
                Image(systemName: "bookmark")
                Text("Bookmark")
            }
            .tag(1)
            
            NavigationView {
                VStack{
                    Picker(selection: $segment, label: Text("")){
                        ForEach(0..<mapStyle.count){ i in
                            Text(self.mapStyle[i].name).tag(i)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    MapView(data: $newsStandView.newsData,
                            mapState: $mapState, type: mapStyle[segment].map)
                        .edgesIgnoringSafeArea(.all)
                }
            }                    .navigationBarTitle("News Stands").accentColor(.black)
            
            .tabItem{
                Image(systemName: "location")
                Text("News stands")
            }
            .tag(2)
        }
        
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


