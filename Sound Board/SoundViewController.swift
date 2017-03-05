//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Mohammed Al-Khonaizi on 3/5/17.
//  Copyright © 2017 Mohammed Al-Khonaizi. All rights reserved.
//

import UIKit

import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupRecorder()
        
    }
    
    func setupRecorder () {
       
        do {
            // Create an audion session
            
            let session = AVAudioSession.sharedInstance()
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            try session.overrideOutputAudioPort(.speaker)
            
            try session.setActive(true)
            
            
            // Create URL for the audion file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.m4a"]
            
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)
            

            // Create settings for the audio recorder
            
            var settings : [String:Any] = [:]
            
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            
            settings[AVSampleRateKey] = 44100.0
            
            settings[AVNumberOfChannelsKey] = 2
            

            // Create Audio Recorder Object
            
            try audioRecorder = AVAudioRecorder (url: audioURL!, settings: settings)
            
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            
            print(error)
            
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
        
    }
    @IBAction func addTapped(_ sender: Any) {
        
    }
}
