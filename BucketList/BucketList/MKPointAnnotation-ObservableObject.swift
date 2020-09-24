//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by George Solorio on 9/23/20.
//

import Foundation
import MapKit

extension MKPointAnnotation: ObservableObject {
   public var wrappedTitle: String {
      get {
         self.title ?? "Unknown value"
      }
      set {
         title = newValue
      }
   }
   
   public var wrappedSubtitle: String {
      get {
         self.subtitle ?? "Unknown value"
      }
      
      set {
         subtitle = newValue
      }
   }
}
