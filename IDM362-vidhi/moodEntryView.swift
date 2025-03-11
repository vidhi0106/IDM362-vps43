//
//  moodEntryView.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 3/10/25.
//

import SwiftUI

struct moodEntryView: View {
    let moodName: String
    let moodImage: String
    let moodColor: Color
    let notes: String
    
    
    @Binding var selectedDate: Date // Binding for selected date
    
    @State private var selectedMood = ""

    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationState: NavigationState
    
    init(selectedDate: Binding<Date>, moodEntry: MoodEntry) {
        _selectedDate = selectedDate
        self.moodName = moodEntry.mood
        self.notes = moodEntry.notes
        self.moodImage = moodEntry.mood
        self.moodColor = Color(moodEntry.mood)
    }
    
    var body: some View {
        
        VStack (spacing:30) {
            
            Text("Your mood on \(displayDateString(from: selectedDate))")
                .font(.title)
                .fontWeight(.bold)
                .padding(10)
                .multilineTextAlignment(.center)
                
                
                
            
            VStack (spacing:-10) {
                Image(moodImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text(moodName)
                    .font(.title)
                    .fontWeight(.bold)

            }
            
            
        
            VStack (spacing:-10) {
                Text("Your Notes")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                
                Text(notes)
                    .font(.title3)
                    .padding(10)
            }
                
            
            
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(moodColor.opacity(0.2)
        .edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MoodCloud")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("Color"))
            }

            ToolbarItem(placement: .topBarLeading) {
                Button(action: {}) {}.tint(Color("Color"))
            }
        }
    }

        
    }
   
    
    
    // Function to format selectedDate into a string
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    func displayDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy" // "Monday, March 10, 2025"
        return formatter.string(from: date)
    }


#Preview {
    moodEntryView(selectedDate: .constant(Date()), moodEntry: MoodEntry(date: "2025-03-10", mood: "Sad", notes: "Feeling great todaybecaise I ifnally got everything to work and I am so excited!!"))
}
