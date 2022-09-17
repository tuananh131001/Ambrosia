/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Mai Nhung
 ID: s3879954
 Created  date: 15/08/2022
 Last modified: 29/08/2022
 Acknowledgement: Tom Huynh github, canvas
 // https://www.zerotoappstore.com/how-to-add-background-music-in-swift.html
 */


import Foundation
import AVFoundation


struct SoundModel {
    
    static var effectAudio: AVAudioPlayer?
    static var backgroundAudio: AVAudioPlayer?


    // MARK: - start sound
    // MARK: play sound effect (1 time play only)
    static func startEffectSound(sound soundPath: String, type: String) {
        if let path = Bundle.main.path(forResource: soundPath, ofType: type) {
            do {
                effectAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                effectAudio?.play()
            } catch {
                print("ERROR: Could not find and play sound file")
            }
        }
    }

    // MARK: play background music (infinite loop)
    static func startBackgroundMusic(bckName: String, type: String = "mp3") {
        if let bundle = Bundle.main.path(forResource: "bck-\(bckName)", ofType: type) {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                backgroundAudio = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = backgroundAudio else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print("ERROR: Could not find and play background music")
            }
        }
    }
    // MARK: - stop sound
    // MARK: stop background music
    static func stopBackgroundMusic() {
        guard let audioPlayer = backgroundAudio else { return }
        audioPlayer.stop()
    }
    
    // MARK: stop sound effect
    static func stopSoundEffect() {
        guard let audioPlayer = effectAudio else { return }
        audioPlayer.stop()
    }
    
    // MARK: - sound with name
    static func clickButtonSound() {
        startEffectSound(sound: "button-click", type: "mp3")
    }
    
    static func clickCardSound() {
//        stopSoundEffect()
        startEffectSound(sound: "card-click", type: "mp3")
    }
    
    static func clickTabSound() {
//        stopSoundEffect()
        startEffectSound(sound: "tab-click", type: "mp3")
    }
    
    static func clickOtherSound() {
        startEffectSound(sound: "other-click", type: "mp3")
    }
}
