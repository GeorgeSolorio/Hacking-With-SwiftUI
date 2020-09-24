//
//  ImagePicker.swift
//  Instafilter
//
//  Created by George Solorio on 9/21/20.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
   
   func makeCoordinator() -> Coordinator {
      Coordinator(self)
   }
   
   class Coordinator: NSObject, UINavigationControllerDelegate,
                      UIImagePickerControllerDelegate {
      
      let parent: ImagePicker
      
      init(_ parent: ImagePicker) {
         self.parent = parent
      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         
         if let uiImage = info[.originalImage] as? UIImage {
            parent.image = uiImage
         }
         
         parent.presentationMode.wrappedValue.dismiss()
      }
   }
   
   typealias UIViewControllerType = UIImagePickerController
   
   @Environment(\.presentationMode) var presentationMode
   @Binding var image: UIImage?
   
   func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
      let picker = UIImagePickerController()
      picker.delegate = context.coordinator
      return picker
   }
   
   func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
      
   }
}

struct ImagePicker_Previews: PreviewProvider {
   static var previews: some View {
      /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
   }
}
