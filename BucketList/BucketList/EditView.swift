//
//  EditView.swift
//  BucketList
//
//  Created by George Solorio on 9/23/20.
//

import SwiftUI
import MapKit

struct EditView: View {
   
   enum LoadingState {
      case loading, loaded, failed
   }
   
   @State private var loadingState = LoadingState.loading
   @State private var pages = [Page]()
   @Environment(\.presentationMode) var presentationMode
   @ObservedObject var placemark: MKPointAnnotation
   
    var body: some View {
      NavigationView {
         Form {
            Section {
               TextField("Place name", text: $placemark.wrappedTitle)
               TextField("Description", text: $placemark.wrappedSubtitle)
            }
            
            Section(header: Text("Nearby...")) {
               if loadingState == .loaded {
                  List(pages, id: \.pageid) { page in
                     Text(page.title).bold() +
                        Text(":\n") + Text(page.description).italic().foregroundColor(.secondary)
                  }
               } else if loadingState == .loading {
                  Text("Loading ..")
               } else {
                  Text("Please try again later.")
               }
            }
         }
         .navigationBarTitle("Edit place")
         .navigationBarItems(trailing: Button("Done") {
            self.presentationMode.wrappedValue.dismiss()
         })
         .onAppear(perform: fetchNearbyPlaces)
      }
    }
   
   func fetchNearbyPlaces() {
      
      let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

      guard let url = URL(string: urlString) else {
         print("Bad URL: \(urlString)")
         return
      }
      
      URLSession.shared.dataTask(with: url) {
         data, response, error in
         
         if let data = data {
            let decoder = JSONDecoder()
            
            if let items = try? decoder.decode(Result.self, from: data) {
               self.pages = Array(items.query.pages.values).sorted()
               print(pages)
               self.loadingState = .loaded
               return
            }
         }
         
         self.loadingState = .failed
      }.resume()
   }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
      EditView(placemark: MKPointAnnotation.example)
    }
}
