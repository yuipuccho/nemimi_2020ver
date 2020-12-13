//
//  Sound.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/12/13.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

import AVFoundation

class Sound{

    //playerを作成
    var player: AVAudioPlayer!

//    init(fileName: String, fileType: String, volume: Float, numberOfLoops: Int) {
//        let soundFilePath = Bundle.main.path(forResource: fileName, ofType: fileType)!
//        let url: URL = URL(fileURLWithPath: soundFilePath)
//        do {
//            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
////            player.numberOfLoops = numberOfLoops/* 0なら一回、自然数ならその数だけループ、負の数なら永久ループ */
////            player.prepareToPlay()     //再生準備 (タイミングがシビアな時のみ)
////            player.volume = volume
//        } catch {
//            //プレイヤー作成失敗
//            fatalError("Failed to initialize a player.")
//        }
//        player.prepareToPlay()
//    }
//
//    convenience init(fileName: String, fileType: String){
//        self.init(fileName: fileName, fileType: fileType, volume: 1.0, numberOfLoops: 0)
//    }

    //AVAudioPlayerのメソッドを流用。これで〇〇.player.play()でなく〇〇.play()で済む
    func play(){
        self.player.play()
    }

    func pause(){
        self.player.pause()
    }

    func stop(){
        self.player.stop()
    }

}
