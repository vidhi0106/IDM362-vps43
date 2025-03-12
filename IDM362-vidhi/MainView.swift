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
    @Published var currentView: Int = 0 // 1 for CalendarView, 0 for ContentView
}

struct MainView: View {
    @StateObject var userData = UserData()
    @StateObject var navigationState = NavigationState()
    
    // Store selectedDate as @State in MainView to pass it as a Binding
    @State private var selectedDate: Date = Date()
    
    // Get color scheme from device
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedMonth = Date() // Stores the currently displayed month
    @State private var moodEntries: [MoodEntry] = [] // Change moodEntries to @State so it can be updated
    
    // Get the moods from the MoodDataManager
    private func loadMoodEntries() {
        moodEntries = MoodDataManager.shared.loadMoodEntries() // Load mood entries on demand
    }
    
    var body: some View {
        TabView(selection: $navigationState.currentView) {
            // Pass selectedDate as a Binding to CalendarView
            ContentView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Mood", systemImage: "cloud.fill")
                }
                .tag(0) // Unique tag for ContentView
            
            CalendarView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(1) // Unique tag for CalendarView
            
        
        }
        .environmentObject(navigationState)
        .tint(Color("Color"))
        .onAppear {
            // Set unselected tab bar item color dynamically
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "navbar")
            loadMoodEntries()
        }
        .environmentObject(userData)
        // Handle tab change with onChange (iOS 17.0 and later)
        
    }
    
}

//
//#Preview {
//    MainView()
//        .environmentObject(UserData())
//}
