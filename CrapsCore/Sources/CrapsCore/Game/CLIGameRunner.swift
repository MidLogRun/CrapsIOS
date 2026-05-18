//
//  GameRunner.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//


public class CLIGameRunner {

    private var player: Player
    private var game: GameEngine

    public init (player: Player, game: GameEngine) {
        self.player = player
        self.game = game
    }


    public func runGame() {
        while game.playerCanPlay {
//            game.playTurn()

        }
    }

}
