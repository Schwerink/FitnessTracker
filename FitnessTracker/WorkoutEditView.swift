//
//  WorkoutEditView.swift
//  FitnessTracker
//
//  Created by Erik on 20.09.25.
//

import SwiftUI

struct WorkoutEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    var plan: WorkoutPlan
    
    @State private var name = ""
    @State private var exercises: [Exercise] = []
    
    @State private var newExerciseName = ""
    @State private var newSets = 3
    @State private var newReps = 10
    
    var body: some View {
        
        NavigationStack{
            Form {
                TextField("Plan Name", text:$name)
                
                Section("Übungen") {
                    if exercises.isEmpty {
                        Text("Noch keine Übungen Hinzugefügt")
                    }else{
                        ForEach(exercises) { exercise in
                            Text("\(exercise.name) - \(exercise.defaultSets) x \(exercise.defaultReps)")
                        }
                        .onDelete{indexSet in exercises.remove(atOffsets: indexSet)}
                        
                    }
                    
                }
                
                Section("Übung hinzufügen"){
                    TextField("Übungsname", text:$newExerciseName)
                    Stepper("Sätze: \(newSets)", value:$newSets, in: 1...10)
                    Stepper("Wdh: \(newReps)", value:$newReps, in: 1...30)
                    
                    Button("Zur Liste hinzufügen"){
                        let trimmedName = newExerciseName.trimmingCharacters(in: .whitespaces)
                        guard !trimmedName.isEmpty else {return}
                        
                        let newExercise = Exercise(
                            name:trimmedName,
                            defaultSets: newSets,
                            defaultReps: newReps
                        )
                        exercises.append(newExercise)
                        
                        newExerciseName = ""
                        newSets = 3
                        newReps = 10
                    }
                    .disabled(newExerciseName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .navigationTitle("Plan bearbeiten")
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button("Speichern"){
                            plan.name = name
                            plan.exercises.removeAll()
                            for ex in exercises{
                                context.insert(ex)
                                plan.exercises.append(ex)
                            }
                            try? context.save()
                            dismiss()
                        }
                    }
                }
                .onAppear{
                    if name.isEmpty{
                        name = plan.name
                        exercises = plan.exercises
                    }
                }
                
            }
        }
        
    }

}

//#Preview {
//    WorkoutEditView(plan: <#WorkoutPlan#>)
//}
