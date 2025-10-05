//
//  WorkoutHistoryView.swift
//  FitnessTracker
//
//  Created by Erik on 05.07.25.
//

import SwiftUI
import SwiftData

struct WorkoutHistoryView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var sessions: [WorkoutSession]
    
    var body: some View {
            List{
                ForEach(sessions) { session in
                    Section(header: Text(formattedDate(session.date))){
                        ForEach(session.trackedExercises) { exercise in
                            VStack(alignment: .leading){
                                Text("\(exercise.exerciseName): \(exercise.sets) x \(exercise.reps)")
                                    .font(.headline)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
    
    func formattedDate(_ date: Date)-> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}

#Preview {
    WorkoutHistoryView()
}
