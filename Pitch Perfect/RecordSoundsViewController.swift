//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Mayank Kumar on 3/5/15.
//  Copyright (c) 2015 Mayank Kumar. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController{

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var beginRecord: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    var manageAudio:AudioManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButtonOutlet.hidden=true
        pauseButton.hidden=true
        playButton.hidden=true
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButtonOutlet.hidden=true
        pauseButton.hidden=true
        playButton.hidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordButton(sender: UIButton) {
        recordButtonOutlet.hidden=false
        pauseButton.hidden=false
        beginRecord.enabled=false
        recordLabel.text="Now Recording...."
        manageAudio=AudioManager()
        manageAudio.startRecordingAudio()
    }

    @IBAction func stopButton(sender: UIButton) {
        recordButtonOutlet.hidden=true
        pauseButton.hidden=true
        beginRecord.enabled=true
        recordLabel.text="Tap Mic to Record"
        manageAudio.stopRecordingAudio()
    }
    
    @IBAction func resumeRecording(sender: UIButton) {
        recordLabel.text="Now Recording...."
        playButton.hidden=true
        pauseButton.hidden=false
        manageAudio.resumeRecordingAudio()
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        recordLabel.text="Paused Recording"
        pauseButton.hidden=true
        playButton.hidden=false
        manageAudio.pauseRecordingAudio()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let data=manageAudio
            playSoundsVC.manageAudio=data
        }
    }
}

