//
//  GameScene.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/18.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//


// ゲームを作るときにはSKSceneクラスを継承した独自のクラスを作成することになる。

/*
import SpriteKit    // SpriteKit に置き換える

class GameScene: SKScene {

    /// 障害物の壁
    var wallNode: SKNode!


    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {

        // 背景色を設定
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        // 障害物の壁用のノード
        wallNode = SKNode()

        // スプライトを生成する処理
        setupWall()

    }

    // 壁について
    func setupWall() {
        // 壁の画像を読み込む。壁のテクスチャをつくる。
        let wallTexture = SKTexture(imageNamed: "tenjiblock")

        // ただの四角をつくる。
        let wallSquare = SKShapeNode(rect: CGRect(200.0, 150.0))





        wallTexture.filteringMode = .linear    // linear は画質はきれいだが処理が遅い。一般的に当たり判定は画質優先のほうが良いらしい。

        // スプライトを作成
        wallNode = SKSpriteNode(texture: wallTexture)
        wallNode = SKShapeNode
        wallNode.position = CGPoint(x: self.frame.size.width / 4, y:self.frame.size.height / 4)

        // 物理演算を設定
        wallNode.physicsBody = SKPhysicsBody(circleOfRadius: wallNode.size.height / 2.0)



        addChild(wallNode)

    }


}
 */
