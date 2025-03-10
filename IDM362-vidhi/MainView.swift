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
    
    @State private var selectedMonth = Date() // Stores the currently displayed month
    @State private var moodEntries: [MoodEntry] = [] // Change moodEntries to @State so it can be updated
    
    // Get the moods from the MoodDataManager
    private func loadMoodEntries() {
        moodEntries = MoodDataManager.shared.loadMoodEntries() // Load mood entries on demand
    }
    
    var body: some View {
        TabView(selection: $navigationState.currentView) {
            // Pass selectedDate as a Binding to CalendarView
            CalendarView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0) // Unique tag for CalendarView
                .onAppear {
                    // Trigger loadMoodEntries when Calendar tab is selected
                    if navigationState.currentView == 0 {
                        loadMoodEntries()
                    }
                }
            
            // Pass selectedDate as a Binding to ContentView
            ContentView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Mood", systemImage: "cloud.fill")
                }
                .tag(1) // Unique tag for ContentView
        }
        .environmentObject(navigationState)
        .tint(Color("Color"))
        .onAppear {
            // Set unselected tab bar item color dynamically
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "navbar")
        }
        .environmentObject(userData)
        // Handle tab change with onChange (iOS 17.0 and later)
        .onChange(of: navigationState.currentView) { newValue in
            // Check if the CalendarView tab (tag 0) is selected
            if newValue == 0 {
                loadMoodEntries()
            }
        }
    }
}


#Preview {
    MainView()
        .environmentObject(UserData())
}
