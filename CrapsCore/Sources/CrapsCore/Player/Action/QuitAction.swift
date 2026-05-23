//
//  QuitAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/22/26.
//


public struct QuitAction: Action {
    public func execute(on: any ActionExecutor) {
        _ = on.quit()
    }


}
