import Foundation
import AVFoundation

internal class AudioHelper {
    private var player: AVAudioPlayer?

    internal func setupAudio() {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .duckOthers)
//            try audioSession.setActive(true)
//        } catch {
//            print("AVAudioSession cannot be set: \(error)")
//        }
    }
    
    private func playSound(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
            fatalError()
        }
    }
    
    internal func play(sound: Sound) {
        let soundURL = Bundle.main.url(forResource: "\(sound.rawValue)", withExtension: "m4a")
        
        playSound(url: soundURL!)
    }
}
