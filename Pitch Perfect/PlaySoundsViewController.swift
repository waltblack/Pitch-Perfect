//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Walter Black on 3/19/15.
//  Copyright (c) 2015 Walt Black. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio:RecordAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error:NSError?
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: &error)
        audioPlayer.enableRate = true

        // Do any additional setup after loading the view.
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playAudio(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.play()

    }
    
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.rate = 0.5
        audioEngine.stop()
        audioEngine.reset()
        playAudio()
    
    }

    
    @IBAction func playAudioFast(sender: AnyObject) {
        audioPlayer.rate = 2.0
        audioEngine.stop()
        audioEngine.reset()
        playAudio()
    }
    
    
    @IBAction func stopAudioPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

    }
    
   
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    
}
