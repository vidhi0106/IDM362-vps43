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

struct MainView: View {
    @StateObject var userData = UserData()
    
    // get color scheme from device
       @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $userData.ndx) {
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0) // Unique tag
            
            ContentView()
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
        .tint(Color("Color"))
        .onAppear {
                    // Set unselected tab bar item color dynamically
                    UITabBar.appearance().unselectedItemTintColor = UIColor(named: "navbar")
                }
        .environmentObject(userData)
        
    }

}

#Preview {
    MainView()
        .environmentObject(UserData())
}
