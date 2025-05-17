//
//  WorkoutTrackingView.swift
//  FitnessTracker
//
//  Created by Erik on 16.05.25.
//

import SwiftUI

struct WorkoutTrackingView: View {
    var plan: WorkoutPlan
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var trackedExercises: [TrackedExercise] = []
    
    var body: some View {
        List{
            ForEach(plan.exercises) { exercise in
                Section(exercise.name){
                    let index = trackedExercises.firstIndex(where: { $0.exerciseName == exercise.name }) ?? {
                        let new = TrackedExercise(exerciseName: exercise.name, sets: exercise.defaultSets, reps: exercise.defaultReps, weight: 0)
                        trackedExercises.append(new)
                        return trackedExercises.count - 1
                    }()
                    
                    Stepper("Gewicht: \(trackedExercises[index].weight, specifier: "%.1f") kg", value: $trackedExercises[index].weight, in: 0...200, step: 2.5)
                    Stepper("Sätze: \(trackedExercises[index].sets)", value: $trackedExercises[index].sets, in: 1...10)
                    Stepper("Wdh: \(trackedExercises[index].reps)", value: $trackedExercises[index].reps, in: 1...30)
                }
            }
        }
        .navigationTitle("Workout Starten")
        .toolbar{
            Button("Workout Speichern") {
                let session = WorkoutSession(trackedExercises: trackedExercises)
                context.insert(session)
                dismiss()
            }
        }
        .onAppear {
            // Init trackedExercises
            trackedExercises = plan.exercises.map {
                 TrackedExercise(exerciseName: $0.name, sets: $0.defaultSets, reps: $0.defaultReps, weight: 0)
            }
        }
    }
}

