//
//  MainView.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 2/10/25.
//
import SwiftUI

class UserData: ObservableObject {
    @Published var ndx: Int = 0
}

import SwiftUI

class NavigationState: ObservableObject {
    @Published var currentView: Int = 0 // 0 for CalendarView, 1 for ContentView
}

struct MainView: View {
    @StateObject var userData = UserData()
    @StateObject var navigationState = NavigationState()
    
    // Store selectedDate as @State in MainView to pass it as a Binding
    @State private var selectedDate: Date = Date()
    
    // Get color scheme from device
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $navigationState.currentView) {
            // Pass selectedDate as a Binding to CalendarView
            CalendarView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0) // Unique tag
            
            // Pass selectedDate as a Binding to ContentView
            ContentView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Mood", systemImage: "cloud.fill")
                }
                .tag(1) // Unique tag
            
//            Text("Report Tab")
//                .tabItem {
//                    Label("Report", systemImage: "chart.bar.fill")
//                }
//                .tag(2) // Unique tag
        }
        .environmentObject(navigationState)
        .tint(Color("Color"))
        .onAppear {
            // Set unselected tab bar item color dynamically
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "navbar")
        }
        .environmentObject(userData)
    }
}

//#Preview {
//    MainView()
//        .environmentObject(UserData())
//}
