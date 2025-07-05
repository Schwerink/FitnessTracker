//
//  Model.swift
//  FitnessTracker
//
//  Created by Erik on 07.05.25.
//
import SwiftData
import Foundation

@Model
class Exercise{
    var name: String;
    var defaultSets: Int;
    var defaultReps: Int;
    
    init(name: String, defaultSets: Int, defaultReps: Int) {
        self.name = name
        self.defaultSets = defaultSets;
        self.defaultReps = defaultReps;
    }
}

@Model
class WorkoutPlan{
    var name: String;
    @Relationship var exercises: [Exercise] = []
    
    init(name: String, exercises: [Exercise] = []) {
        self.name = name;
        self.exercises = exercises;
    }
    
}

@Model
class TrackedExercise: Identifiable {
    var id: UUID = UUID()
    var exerciseName: String
    var sets: Int
    var reps: Int
    var weight: Double

    init(exerciseName: String, sets: Int, reps: Int, weight: Double) {
        self.exerciseName = exerciseName
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}

@Model
class WorkoutSession {
    var date: Date
    @Relationship var trackedExercises: [TrackedExercise] = []

    init(date: Date = Date(), trackedExercises: [TrackedExercise] = []) {
        self.date = date
        self.trackedExercises = trackedExercises
    }
}
