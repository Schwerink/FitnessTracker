//
//  WorkoutTrackingView.swift
//  FitnessTracker
//
//  Created by Erik on 16.05.25.
//




///Abändern, dass man für jeden satz die wiederholungen und das gewicht eingeben kann.
///z.B. Überschrift bleibt name der Übung, darunter dann Zeile für satz 1, 2 und 3 und unter jedem satz dann wiederholungen und kg


import SwiftUI

struct WorkoutTrackingView: View {
    var plan: WorkoutPlan
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var trackedExercises: [TrackedExercise] = []
    
    var body: some View {
        List {
            ForEach(trackedExercises) { tracked in
                Section(tracked.exerciseName) {
                    if let index = trackedExercises.firstIndex(where: { $0.id == tracked.id }) {
                        Stepper("Gewicht: \(trackedExercises[index].weight, specifier: "%.1f") kg", value: $trackedExercises[index].weight, in: 0...200, step: 1)
                        Stepper("Sätze: \(trackedExercises[index].sets) | \(trackedExercises[index].exercise?.defaultSets ?? 0)", value: $trackedExercises[index].sets, in: 1...10)
                        Stepper("Wdh: \(trackedExercises[index].reps) | \(trackedExercises[index].exercise?.defaultReps ?? 0)", value: $trackedExercises[index].reps, in: 1...30)
                    }
                }
            }
        }
        .navigationTitle("Workout Starten")
        .toolbar{
            Button("Workout Speichern") {
                let session = WorkoutSession(trackedExercises: trackedExercises)
                context.insert(session)
                try? context.save()
                print("Session gespeichert mit \(session.trackedExercises.count) Übungen.")
                dismiss()
            }
        }
        .onAppear {
            // Init trackedExercises
            trackedExercises = plan.exercises.map { ex in
                 TrackedExercise(
                    exercise: ex,
                    sets: ex.defaultSets,
                    reps: ex.defaultReps,
                    weight: 0
                 )
            }
        }
    }
}

