//
//  SwiftUIView.swift
//  neumorphimTest
//
//  Created by Freddy Haug on 1/28/21.
//

import SwiftUI

extension Color {
    
    static let offWhite = Color(red: 0 / 255, green: 145 / 255, blue: 173 / 255)
    

    //Backgrounds
    static let offBlue = Color(red: 0 / 255, green: 109 / 255, blue: 131 / 255)
    static let boundingBoxBlue = Color(red: 0 / 255, green: 109 / 255, blue: 131 / 255)
    
    static let barGreen = Color(red: 203 / 255, green: 255 / 255, blue: 235 / 255)
    static let barRed = Color(red: 244 / 255, green: 147 / 255, blue: 162 / 255)
}

struct Now: Identifiable {
    var id = UUID()
    var red: Int
    var green: Int
}

struct SwiftUIView: View {
    
    @ObservedObject var bleManager = BluetoothController()
    

    
    var body: some View {
        ZStack {
            Color.offBlue
            VStack{
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.boundingBoxBlue)
                    .frame(width: 285, height: 315)
                    .shadow(color: Color.offWhite.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                    .overlay(
                    // Inside the first box and adding chart 1
                        VStack {
                            HStack {
                                
                                // Inside the first green row of capsules
                                Spacer()
                                
                                ForEach( bleManager.nowPayload )
                                    { now in VStack {
                                            VStack {
                                                Capsule()
                                                    .fill(Color.barGreen)
                                                    .frame(width: 22,   height: CGFloat(now.green))
                                                    }.frame(height: 100)
                                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                                        }
                                    }
                                Spacer()

                                }
                            
                            Divider()
                            .frame(width:250)
                            
                            HStack {
                                
                                // Inside the first green row of capsules
                                Spacer()
                                
                                ForEach( bleManager.nowPayload )
                                    { now in VStack {
                                            VStack {
                                                Capsule()
                                                    .fill(Color.barRed)
                                                    .frame(width: 22,   height: CGFloat(now.red))
                                                    }.frame(height: 100)
                                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                                        }
                                    }
                                Spacer()
                                }
                                
                            })
                Spacer()
                    .frame(height: 30)
                HStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.boundingBoxBlue)
                        .frame(width: 28, height: 28)
                        .shadow(color: Color.offWhite.opacity(0.7), radius: 10, x: -5, y: -5)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                        .overlay(
                            HStack{
                                Image(systemName: "trash")
                            })
                    
                    Text("           Receiving Data        ")
                    
                    // Status goes here
                    if bleManager.isSwitchedOn {
                            Text("Bluetooth is switched on")
                                        .foregroundColor(.green)
                    }
                    else {
                            Text("Bluetooth is NOT switched on")
                                        .foregroundColor(.red)
                    }
//                        .colorInvert()
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.boundingBoxBlue)
                        .frame(width: 28, height: 28)
                        .shadow(color: Color.offWhite.opacity(0.7), radius: 10, x: -5, y: -5)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                }
                Spacer()
                    .frame(height: 30)
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.boundingBoxBlue)
                    .frame(width: 285, height: 120)
                    .shadow(color: Color.offWhite.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUIView()
            SwiftUIView()
            SwiftUIView()
        }
    }
}
