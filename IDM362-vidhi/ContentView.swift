import SwiftUI

struct ContentView: View {
    let moods = [
        ("Excited", "Excited", Color(red: 1.0, green: 0.7137254901960784, blue: 0.592156862745098)),
        ("Happy", "Happy", Color(red: 1.0, green: 0.8117647058823529, blue: 0.592156862745098)),
        ("Calm", "Calm", Color(red: 1.0, green: 0.9176470588235294, blue: 0.7019607843137254)),
        ("Anxious", "Anxious", Color(red: 0.8352941176470589, green: 0.9411764705882353, blue: 1.0)),
        ("Sad", "Sad", Color(red: 0.9333333333333333, green: 0.8235294117647058, blue: 1.0)),
        ("Angry", "Angry", Color(red: 1.0, green: 0.7372549019607844, blue: 0.9098039215686274))
    ]
    
    @Binding var selectedDate: Date // Add Binding for selectedDate
    @State private var selectedMood = ""
    @State private var notes = ""

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


    var body: some View {
        NavigationStack {
            VStack {
                Text("MoodCloud")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundStyle(Color("Color"))
                
                Text("Pick your mood for \(displayDateString(from: selectedDate))")

                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .foregroundStyle(Color("Color"))
                
                // Grid of mood buttons
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(moods, id: \.1) { mood in
                        NavigationLink(destination: MoodDetailView(
                            moodName: mood.1,
                            moodImage: mood.0,
                            moodColor: mood.2,
                            selectedDate: $selectedDate)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(mood.2)
                                    .frame(width: 160, height: 90)
                                
                                VStack(spacing: -30) {
                                    Image(mood.0)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 90)
                                        .offset(y: -40)

                                    Text(mood.1)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.top, -10)
                                }
                                .padding(30)
                            }
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
        .accentColor(Color("Color"))
    }
}

#Preview {
    ContentView(selectedDate: .constant(Date()))
}



import SwiftUI

struct MoodDetailView: View {
    let moodName: String
    let moodImage: String
    let moodColor: Color
    @State private var notes: String = ""
    @Binding var selectedDate: Date // Binding for selected date

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationState: NavigationState

    var body: some View {
        VStack {
            Text("You picked \(moodName)")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Image(moodImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)

            Text("Add notes about your mood:")
                .font(.headline)
                .padding(.top)

            // Increased height of input field
            TextEditor(text: $notes)
                .frame(height: 150) // Adjust height here
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 2))
                .padding()

            Button("Done") {
                // Create a new MoodEntry
                let newMoodEntry = MoodEntry(date: dateString(from: selectedDate), mood: moodName, notes: notes)

                print("Mood entry logged: \(newMoodEntry)")
                
                // Save the entry
                MoodDataManager.shared.saveMoodEntry(newMoodEntry)

                // After saving, go back to CalendarView
                navigationState.currentView = 1
                presentationMode.wrappedValue.dismiss()
                
            }
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(width: 250)
            .background(moodColor)
            .cornerRadius(10)
            .padding(.top)
            
            Spacer()
        }
        .background(moodColor.opacity(0.2).edgesIgnoringSafeArea(.all))
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

    // Function to format selectedDate into a string
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

#Preview {
    MoodDetailView(
            moodName: "Excited",
            moodImage: "sparkly",
            moodColor: Color(red: 1.0, green: 0.7137254901960784, blue: 0.592156862745098),
            selectedDate: .constant(Date())
    ).environmentObject(NavigationState())
}

