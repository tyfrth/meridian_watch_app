//
//  ContentView.swift
//  meridian_watch_app
//
//  Created by Tyler Frith on 10/30/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import SwiftUI
import WatchConnectivity

//    struct ContentView: View {
//        var body: some View {
//            Text("Hello World!")
//        }
//    }
//
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//            }
//        }

struct ContentView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: MRMapViewController, context: Context) {
        
    }
    func makeUIViewController(context: Context) -> MRMapViewController {
        HACKMapViewController.init()
    }
    
}

