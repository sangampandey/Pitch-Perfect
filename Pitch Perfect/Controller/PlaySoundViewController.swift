//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Sangam Pandey on 9/13/15.
//  Copyright (c) 2015 Sangam Pandey. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController,AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer!
    var receiveAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func playAudioFast(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    
    @IBAction func playChipMunkEffect(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playDarthVaderEffect(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    /**
        this function is responsible to change the rate of the audio
        @params : rate
    */
    
    func playAudioWithVariableRate(rate:Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime=0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    /**
        this function is responsible to change the pitch of the audio
        @params : pitch -2000 to 2000
    */
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
