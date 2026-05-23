    //
    //  BetRollActionStrategy.swift
    //  CrapsCore
    //
    //  Created by Matthew Long on 5/20/26.
    //


public struct BetRollActionStrategy: ActionStrategy {
    private var lastAction: any Action //Tracks the last action decided to determine the next action
    public let bettingStrategy: any BettingStrategy

    public init(bettingStrategy: any BettingStrategy) {
        self.bettingStrategy = bettingStrategy
        self.lastAction = RollAction()
    }

    mutating func setLastAction(action: any Action){
        self.lastAction = action
    }

    public mutating func getActionWithBalance(gameState: GameState, puck: Puck, snapshot: PlayerSnapshot) -> any Action {
            //TODO: bet, roll, bet, roll, etc.
        if (lastAction is MakeBetAction){
            let newAction = RollAction()
            setLastAction(action: newAction)
            return RollAction()
        }
        let bet = bettingStrategy.makeBet(gameState: gameState, puck: puck, balance: snapshot.balance)
        let newAction = MakeBetAction(bet: bet)
        setLastAction(action: newAction)

        return MakeBetAction(bet: bet)
    }



}
