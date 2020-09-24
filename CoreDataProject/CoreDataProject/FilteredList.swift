//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by George Solorio on 9/15/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
   
   var fetchRequest: FetchRequest<T>
   var singers: FetchedResults<T> { fetchRequest.wrappedValue }
 
   // This is our content closure; we'll call this once for each item in the list
   let content: (T) -> Content
   
   var body: some View {
      List(fetchRequest.wrappedValue, id: \.self) { singer in
         self.content(singer)
      }
   }
   
   init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
      fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
      self.content = content
   }
}
