//
//  RealmManager.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 9.05.22.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
    
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {
        try! localRealm.write{
            model.status = bool
        }
    }
    
    func deleteWorkoutModel(model: WorkoutModel) {
        try! localRealm.write{
            localRealm.delete(model)
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int){
        try! localRealm.write{
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, timer: Int){
        try! localRealm.write{
            model.workoutSets = sets
            model.workoutTimer = timer
        }
    }
    
 // User Model
    
    func saveUserModel(model: UserModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
    
    func updateUserModel(model: UserModel){
        let users = localRealm.objects(UserModel.self)
        try! localRealm.write{
            users[0].firstName = model.firstName
            users[0].secondName = model.secondName
            users[0].height = model.height
            users[0].weight = model.weight
            users[0].target = model.target
        }
    }
}
