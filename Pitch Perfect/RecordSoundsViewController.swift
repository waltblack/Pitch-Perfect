//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Walter Black on 3/19/15.
//  Copyright (c) 2015 Walt Black. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordAudio!
    let tapMessage = "Tap to Record"
    
    @IBOutlet weak var microphoneButton: UIButton!
    
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.hidden = false
        recordLabel.text = tapMessage
        recordLabel.hidden = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func recordPressed(sender: UIButton) {
        
        stopButton.hidden = false
        recordLabel.text = "Recording"
        
        microphoneButton.hidden = true
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordAudio
            playSoundsVC.receivedAudio = data
        }
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordAudio(fileURL:recorder.url, title:recorder.url.lastPathComponent)
            //Move to the next seque
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        //Stop recording the user's voice
        microphoneButton.hidden = false
        recordLabel.hidden = false
        recordLabel.text = tapMessage
        stopButton.hidden = true
        audioRecorder.stop()
    }
}

