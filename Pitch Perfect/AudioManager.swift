import AVFoundation

class AudioManager:NSObject{
    var recordAudio:AVAudioRecorder!
    var session:AVAudioSession!
    var recordedAudio:URL!
    var audioPlayer:AVAudioPlayer!
    var audioPitch:AVAudioUnitTimePitch!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioReverb:AVAudioUnitReverb!
    var audioEcho:AVAudioUnitDistortion!
    var audioPlayerNode:AVAudioPlayerNode!
    
    func startRecordingAudio(){
        let dirPath=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let currentDateTime=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy-HHmmss"
        let recordingName=formatter.string(from: currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        session=AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        do {
            try recordAudio = AVAudioRecorder(url: filePath!, settings: [:])
        } catch _ {
        }
        recordAudio.isMeteringEnabled=true
        recordAudio.prepareToRecord()
        recordAudio.record()
    }
    
    func stopRecordingAudio(){
        recordAudio.stop()
        do {
            try session.setActive(false)
        } catch _ {
        }
        recordedAudio=recordAudio.url
        do {
            audioPlayer=try AVAudioPlayer(contentsOf: recordedAudio)
        } catch _ {
            audioPlayer = nil
        }
        audioPlayer.enableRate=true
    }
    
    func pauseRecordingAudio(){
        recordAudio.pause()
    }
    
    func resumeRecordingAudio(){
        recordAudio.record()
    }
    
    func startPlayingSlowAudio(){
        playAudioAtRate(0.5)
    }
    
    func startPlayingFastAudio(){
        playAudioAtRate(2.0)
    }
    
    func playAudioAtRate(_ rate: Float!){
        if(audioEngine != nil){
            audioEngine.reset()
        }
        audioPlayer.stop()
        audioPlayer.rate=rate
        audioPlayer.play()
    }
    
    func startPlayingChipmunkAudio(){
        playAudioWithVariablePitch(1000)
    }

    func startPlayingDarthVaderAudio(){
        playAudioWithVariablePitch(-1000)
    }
    
    func startPlayingEchoAudio(){
        audioEcho=AVAudioUnitDistortion()
        audioEcho.loadFactoryPreset(AVAudioUnitDistortionPreset.multiEcho1)
        playAudioWithEffect(audioEcho)
    }
    
    func startPlayingReverbAudio(){
        audioReverb=AVAudioUnitReverb()
        audioReverb.loadFactoryPreset(AVAudioUnitReverbPreset.largeRoom)
        playAudioWithEffect(audioReverb)
    }
    
    func playAudioWithVariablePitch(_ pitch: Float!){
        audioPitch=AVAudioUnitTimePitch()
        audioPitch.pitch=pitch
        playAudioWithEffect(audioPitch)
    }
    
    
    func playAudioWithEffect(_ node: AVAudioNode!){
        stopAudio()
        audioPlayerNode=AVAudioPlayerNode()
        audioEngine=AVAudioEngine()
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(node)
        audioEngine.connect(audioPlayerNode, to: node, format: nil)
        audioEngine.connect(node, to: audioEngine.outputNode, format: nil)
        do {
            audioFile=try AVAudioFile(forReading: recordedAudio)
        } catch _ {
            audioFile = nil
        }
        do {
            try audioEngine.start()
        } catch _ {
        }
    }
    
    func stopAudio(){
        if(audioPlayer != nil){
            audioPlayer.stop()
        }
        if(audioEngine != nil){
            audioEngine.stop()
        }
    }
    
}
