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
    
    // @IBOutlets
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    
    
    // Property Variables
    
    var audioRecorder : AVAudioRecorder? = nil
    
    var audioPlayer : AVAudioPlayer?
    
    // Nick didn't create this property
    
    var audioPlyerURL : URL?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupRecorder()
        
        playButton.isEnabled = false
        
        addButton.isEnabled = false
        
    }
    
    
    
    // @IBAction functions
    
    // recordTapped
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            
            // Stop the recording
            
            audioRecorder?.stop()
            
            
            // Change button title to Recording
            
            recordButton.setTitle("Record", for: .normal)
            
            // Enable the play button when recording is stopped.
            
            playButton.isEnabled = true
            
            addButton.isEnabled = true
            
            
        } else {
            
            // Start the recording
            
            audioRecorder?.record()
            
            
            // Change the button title to Stop
            
            recordButton.setTitle("Stop", for: .normal)
        }
        
    }
    
    // playTapped
    
    @IBAction func playTapped(_ sender: Any) {
        
        do {
            
            try audioPlayer = AVAudioPlayer (contentsOf: audioPlyerURL!)
            
            audioPlayer!.play()
            
        } catch let error as NSError {
            
            print(error)
            
        }
        
    }
    
    // addTapped
    
    @IBAction func addTapped(_ sender: Any) {
        
        // Set the context of CoreDate
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        // Create sound variable of type Sound object for CoreData and set the attributes of name and audio.
        
        let sound = Sound (context: context)
        
        sound.name = nameTextField.text
        
        sound.audio = NSData(contentsOf: audioPlyerURL!)
        
        
        // Save the context to CoreData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        print("The name of audio file is: \(sound.name!)")
        print ("The context of the audion file is: \(sound.audio)")
        
        // Navigate back to the previous View Controller.
        
        navigationController!.popToRootViewController(animated: true)
        
    }
    
    
    
    // Custom functions
    
    // setupRecorder
    
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
            
            audioPlyerURL = audioURL
            
            print("####################")
            
            print("The audioURL is: \(audioURL)")
            
            print("####################")
            
            
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
}
