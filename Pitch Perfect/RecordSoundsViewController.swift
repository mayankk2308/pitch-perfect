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
        recordButtonOutlet.isHidden=true
        pauseButton.isHidden=true
        playButton.isHidden=true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordButtonOutlet.isHidden=true
        pauseButton.isHidden=true
        playButton.isHidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordButton(_ sender: UIButton) {
        recordButtonOutlet.isHidden=false
        pauseButton.isHidden=false
        beginRecord.isEnabled=false
        recordLabel.text="Now Recording...."
        manageAudio=AudioManager()
        manageAudio.startRecordingAudio()
    }

    @IBAction func stopButton(_ sender: UIButton) {
        recordButtonOutlet.isHidden=true
        pauseButton.isHidden=true
        beginRecord.isEnabled=true
        recordLabel.text="Tap Mic to Record"
        manageAudio.stopRecordingAudio()
    }
    
    @IBAction func resumeRecording(_ sender: UIButton) {
        recordLabel.text="Now Recording...."
        playButton.isHidden=true
        pauseButton.isHidden=false
        manageAudio.resumeRecordingAudio()
    }
    
    @IBAction func pauseRecording(_ sender: UIButton) {
        recordLabel.text="Paused Recording"
        pauseButton.isHidden=true
        playButton.isHidden=false
        manageAudio.pauseRecordingAudio()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="stopRecording"){
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let data=manageAudio
            playSoundsVC.manageAudio=data
        }
    }
}

