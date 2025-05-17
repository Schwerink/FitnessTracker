//
//  AddWorkoutPlanView.swift
//  FitnessTracker
//
//  Created by Erik on 15.05.25.
//

import SwiftUI

struct AddWorkoutPlanView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var name = ""
    @State private var exercises: [Exercise] = []
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Plan Name", text:$name)
                
                Section("Übungen") {
                    ForEach(exercises) { exercise in
                        Text("\(exercise.name) - \(exercise.defaultSets) x \(exercise.defaultReps)")
                    }
                    Button("Übung hinzufügen") {
                        //hier kommt eingabe für eine übung rein
                        exercises.append(Exercise(name: "Bankdrücken", defaultSets: 3, defaultReps: 10))
                    }
                }
            }
            .navigationTitle("neuer Plan")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Speichern"){
                        let plan = WorkoutPlan(name: name, exercises: exercises)
                        context.insert(plan)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Abbrechen"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddWorkoutPlanView()
}
