//
//  CalendarView.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 2/10/25.


import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date // Binding for the selected date
    let calendar = Calendar.current
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @State private var selectedMonth = Date() // Stores the currently displayed month
    @State private var moodEntries: [MoodEntry] = [] // Stores mood entries
    @State private var selectedMoodEntry: MoodEntry? = nil // Track selected mood entry
    @State private var isNavigatingToMoodDetail = false // Track if we need to navigate
    @State private var refreshID = UUID() // refresh UUID
    
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.presentationMode) var presentationMode
    
    // Get the moods from the MoodDataManager
    private func loadMoodEntries() {
        print("Loading mood entries...")
        DispatchQueue.main.async{
            moodEntries = MoodDataManager.shared.loadMoodEntries() // Load mood entries on demand
            print("Loaded mood entries: \(moodEntries)")
        }// Debugging
    }
    
    let emotionColors: [String: Color] = [
        "Excited": Color("Excited"),
        "Happy": Color("Happy"),
        "Anxious": Color("Anxious"),
        "Calm": Color("Calm"),
        "Angry": Color("Angry"),
        "Sad": Color("Sad")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("MoodCloud")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundStyle(Color("Color"))
                
                // Month Navigation
                HStack {
                    Button(action: { changeMonth(by: -1) }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title)
                            .padding(10)
                            .tint(Color("Color"))
                            .imageScale(.large)
                    }
                    
                    Text(monthYearString(from: selectedMonth))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Color"))
                        .frame(width: 200)
                    
                    Button(action: { changeMonth(by: 1) }) {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title)
                            .tint(Color("Color"))
                            .padding(10)
                            .imageScale(.large)
                    }
                }
                .padding()
                
                // Weekday Labels
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color("Color"))
                    }
                }
                .padding(.bottom, 5)
                
                // Calendar Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(daysInMonth().indices, id: \.self) { index in
                        if let day = daysInMonth()[index] {
                            let dateKey = dateString(from: day)
                            let moodEntry = moodEntries.first(where: { $0.date == dateKey })
                            let backgroundColor = moodEntry != nil ? emotionColors[moodEntry!.mood] ?? Color("customGrey") : Color("customGrey")
                            
                            VStack {
                                Text("\(calendar.component(.day, from: day))")
                                    .font(.caption)
                                    .foregroundStyle(Color.black)
                                
                                // Fixed space for mood emoji (empty if no mood is logged)
                                if let moodEntry = moodEntry {
                                    Image(moodEntry.mood)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                } else {
                                    Text(" ") // Keeps layout intact
                                        .font(.title2)
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .frame(width: 50, height: 80)
                            .background(backgroundColor)
                            .cornerRadius(10)
                            .onTapGesture {
                                // Check if a mood is logged for the selected date
                                if let moodEntry = moodEntries.first(where: { $0.date == dateString(from: day) }) {
                                    // If a mood entry exists, set the selected mood entry
                                    selectedMoodEntry = moodEntry
                                    isNavigatingToMoodDetail = true
                                    selectedDate = day
                                    print("Selected date is \(selectedDate) with mood \(moodEntry.mood)") // Debugging
                                } else {
                                    // If no mood entry exists, navigate to ContentView to log a new mood
                                    navigationState.currentView = 0
                                    presentationMode.wrappedValue.dismiss()
                                    
                                    selectedDate = day
                                    print("No mood entry found for \(selectedDate). Navigating to ContentView") // Debugging
                                }
                            }
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 50, height: 80)
                        }
                    }
                }
                .frame(height: 500)
                .padding()
                
                // Navigate to MoodEntryView if needed
                NavigationLink(destination: moodEntryView(
                                selectedDate: $selectedDate,
                                moodEntry: selectedMoodEntry ?? MoodEntry(date: "", mood: "", notes: "")),
                               isActive: $isNavigatingToMoodDetail) {
                    EmptyView()
                }
            }
            .id(refreshID)
            .onAppear {
                loadMoodEntries()
                print("New Loaded mood entries are: \(moodEntries)") // Debugging
            }
            .onDisappear{
                refreshID = UUID()
            }
        }
    }
    
    // Function to generate an array of dates for the month
    func daysInMonth() -> [Date?] {
        let range = calendar.range(of: .day, in: .month, for: selectedMonth)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedMonth))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1 // Adjust for 0-based index
        // Create placeholder objects with unique IDs for empty days
            let emptyDays = (0..<firstWeekday).map { _ -> Date? in
                return nil
            }
            
            // Create actual date objects for days in month
            let monthDays = range.map { day -> Date? in
                return calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)
            }
            
            return emptyDays + monthDays
        }

    // Function to change months
    func changeMonth(by value: Int) {
        selectedMonth = calendar.date(byAdding: .month, value: value, to: selectedMonth)!
    }

    // Function to format month and year
    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    // Function to format a date into "YYYY-MM-DD"
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}


#Preview {
    // Create an instance of NavigationState
    let navigationState = NavigationState()
    
    // Provide it as an environment object to the CalendarView
    CalendarView(selectedDate: .constant(Date()))
        .environmentObject(NavigationState())
}

