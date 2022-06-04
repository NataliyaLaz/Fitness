//
//  WorkoutModel.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 9.05.22.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    
    @Persisted var workoutDate: Date
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutName: String = "Unknown"
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int
    @Persisted var workoutReps: Int
    @Persisted var workoutTimer: Int
    @Persisted var workoutImage: Data?
    @Persisted var status: Bool = false//Start vs Complete
}
