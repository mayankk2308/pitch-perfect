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
    
    @IBAction func fastButton(sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingFastAudio()
    }
    
    @IBAction func darthVader(sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingDarthVaderAudio()
        playSound()
    }
    
    @IBAction func slowButton(sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingSlowAudio()
    }
    
    @IBAction func chipmunk(sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingChipmunkAudio()
        playSound()
    }
    
    @IBAction func echo(sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingEchoAudio()
        playSound()
    }
    
    @IBAction func reverb(sender: UIButton) {
        showStopButton()
        manageAudio.startPlayingReverbAudio()
        playSound()
    }
    
    func showStopButton(){
        stopButton.hidden=false
    }
    
    func hideStopButton()->Void{
        stopButton.hidden=true
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if(flag){
            stopButton.hidden=true
        }
    }
    
    func playSound(){
        audioNode=manageAudio.audioPlayerNode
        audioNode.scheduleFile(manageAudio.audioFile, atTime: nil, completionHandler: hideStopButton)//completionHandler working, but very slow
        audioNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        hideStopButton()
        manageAudio.stopAudio()
    }
    
}
