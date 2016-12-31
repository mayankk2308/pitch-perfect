import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var stopButton: UIButton!
    var manageAudio:AudioManager!
    var audioNode: AVAudioPlayerNode!
    
    override func viewDidLoad() {
        hideStopButton()
        manageAudio.audioPlayer.delegate=self
    }
    
    @IBAction func fastButton(_ sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingFastAudio()
    }
    
    @IBAction func darthVader(_ sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingDarthVaderAudio()
        playSound()
    }
    
    @IBAction func slowButton(_ sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingSlowAudio()
    }
    
    @IBAction func chipmunk(_ sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingChipmunkAudio()
        playSound()
    }
    
    @IBAction func echo(_ sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingEchoAudio()
        playSound()
    }
    
    @IBAction func reverb(_ sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingReverbAudio()
        playSound()
    }
    
    func showStopButton(){
        stopButton.isHidden=false
    }
    
    func hideStopButton()->Void{
        stopButton.isHidden=true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(flag){
            stopButton.isHidden=true
        }
    }
    
    func playSound(){
        audioNode=manageAudio.audioPlayerNode
        audioNode.scheduleFile(manageAudio.audioFile, at: nil, completionHandler: hideStopButton)//completionHandler working, but very slow
        audioNode.play()
    }
    
    @IBAction func stopAudio(_ sender: UIButton) {
        hideStopButton()
        manageAudio.stopAudio()
    }
    
}
