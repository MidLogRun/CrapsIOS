//
//  RollAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//


public struct RollAction: Action {
    public func execute(on: ActionExecutor) {
        
        on.roll()
    }


}
