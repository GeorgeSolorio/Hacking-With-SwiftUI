//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by George Solorio on 9/10/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
   
   @ObservedObject var order: Order
   @State private var confirmationMessage = ""
   @State private var showingConfirmation = false
   
    var body: some View {
      GeometryReader { geo in
         ScrollView {
            VStack {
               Image("cupcakes")
                  .resizable()
                  .scaledToFit()
                  .frame(width: geo.size.width)
               
               Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                  .font(.title)
               
               Button("Place order") {
                  self.placeOrder()
               }
               .padding()
            }
         }
      }
      .navigationBarTitle("Checkout", displayMode: .inline)
      .alert(isPresented: $showingConfirmation) {
         Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
      }
    }
   
   func placeOrder() {
      guard let encoded = try? JSONEncoder().encode(order) else {
         print("Failed to encode order")
         return
      }
      
      let url = URL(string: "https://reqres.in/api/cupcakes")!
      var request = URLRequest(url: url)
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpMethod = "POST"
      request.httpBody = encoded
      
      URLSession.shared.dataTask(with: request) {
         data, response, error in
         
         guard let data = data else {
            print("No data in reponse: \(error?.localizedDescription ?? "Unknown error")")
            return
         }
         
         if let decoderOrder = try? JSONDecoder().decode(Order.self, from: data) {
            self.confirmationMessage = "Your order for \(decoderOrder.quantity)x \(Order.types[decoderOrder.type].lowercased()) cupcakes is on its way!"
            self.showingConfirmation = true
         } else {
            print("Invalid response from server")
         }
      }.resume()
   }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
