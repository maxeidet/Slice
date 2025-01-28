//
//  Test.swift
//  Slice
//
//  Created by Max Eidet on 2024-12-22.
//

import SwiftUI

struct Test: View {
    @State private var strokes = 0
    var body: some View {
      
        VStack{
            
            Text("\(strokes)")
            Button(action: {
              strokes += 1
            }, label: {
                Text("Lägg till")
                
            })
                .bold()
                .foregroundStyle(Color.white)
           
        }
        .frame(width: 340, height: 150)
        .background(Color(.blue))
        .cornerRadius(10)
    }
}

#Preview {
    Test()
}
