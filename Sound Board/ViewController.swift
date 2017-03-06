//
//  ViewController.swift
//  Sound Board
//
//  Created by Mohammed Al-Khonaizi on 3/5/17.
//  Copyright © 2017 Mohammed Al-Khonaizi. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var sounds : [Sound] = []
    
    // Property Variables
    
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sounds.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell ()
        
        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name
        
        return cell
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Set the context of CoreDate
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            
            try sounds = context.fetch(Sound.fetchRequest())
            
            tableView.reloadData()
            
            
        } catch let error as NSError {
            
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sound = sounds[indexPath.row]
        
        do {
            
            try audioPlayer = AVAudioPlayer (data: sound.audio as! Data)
            
        } catch let error as NSError {
            
            print(error)
        }
        
        audioPlayer?.play()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let sound = sounds[indexPath.row]
            
            print("You are about to delete audio file with the name of \(sound.name)")

        }
    }
    
}
