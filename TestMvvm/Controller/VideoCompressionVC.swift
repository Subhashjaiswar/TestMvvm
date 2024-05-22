//
//  VideoCompressionVC.swift
//  TestMvvm
//
//  Created by Harsh on 06/05/24.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AVKit

class VideoCompressionVC: UIViewController {
    @IBOutlet weak var imgProfile:UIImageView!
    @IBOutlet weak var gesView:UIView!
    @IBOutlet weak var gesViewHight:NSLayoutConstraint!
    let imagePickerController = UIImagePickerController()
    var imgPicker = UIImagePickerController()
    var imgDataLogo = Data()
    var uploadModeel = UserPicUploadModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        imgPicker.delegate = self
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipe:")))
        swipeGesture.direction = [.down, .up]
        self.gesView.addGestureRecognizer(swipeGesture)
        
    }
    
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        
        print(sender.direction)
        if sender.direction == .up{
            gesViewHight.constant = 600
          
        }else{
            gesViewHight.constant = 280
        }
    }
    
    @IBAction func btnGetVideo(_ sernder:UIButton){
        imagePickerController.sourceType = .photoLibrary

        imagePickerController.delegate = self

        imagePickerController.mediaTypes = ["public.movie"]

        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func btnGetImage(_ sernder:UIButton){
        
        //displayImageProof()
        
       ImagePickerManager().pickImage(self){ image in
                //here is the image
            self.imgProfile.image = image
            self.imgDataLogo = self.imgProfile.image!.jpegData(compressionQuality: 0.1)!
            self.uploadModeel.UploadProfile(imgDataLogoo: self.imgDataLogo) { result in
                switch result{
                case .success(let favdata):
                    print("All data ->>>>>>",favdata)
                    self.toastMessage(favdata.msg!)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
      
     
    }
    
    func displayImageProof(){
         let actionSheet = UIAlertController.init(title: "Choose", message: "image", preferredStyle: .actionSheet)
               //actionSheet.view.tintColor = UIColor.darkGray
               let actionCamera = UIAlertAction.init(title: "Camera", style: .default) { (action) in
                self.imgPicker.openCamera()
                self.present(self.imgPicker, animated: true, completion: nil)
               }
        
               let actionGallery = UIAlertAction.init(title: "Gallery", style: .default) { (action) in
                   self.imgPicker.openGallary()
                self.present(self.imgPicker, animated: true, completion: nil)
               }
        
               let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
                   self.dismiss(animated: true, completion: nil)
               }
               
               actionSheet.addAction(actionCamera)
               actionSheet.addAction(actionGallery)
               actionSheet.addAction(actionCancel)
               
               self.present(actionSheet, animated: true, completion: nil)
       
    }
    
    @IBAction func playVideoButtonTapped(_ sender: UIButton) {
        // Replace with the URL of your remote video
        let videoURLString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"

        // Ensure the URL is valid
        guard let videoURL = URL(string: videoURLString) else {
            print("Invalid video URL")
            return
        }
 
        let recordedVideoURL: URL = videoURL

        removeAudioFromVideo(videoURL: recordedVideoURL) { outputURL in
            if let outputURL = outputURL {
                print("Video without audio saved at: \(outputURL)")
                // You can now use the outputURL as needed
                
                let player = AVPlayer(url: outputURL)
                
                DispatchQueue.main.async {
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                        player.play()
                    }
                }
                
                
            } else {
                print("Failed to remove audio from video")
            }
        }
        
        

    }
 
}

extension VideoCompressionVC{
    
    func removeSoundFromVideo(url: URL, completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: url)
        let composition = AVMutableComposition()
        
        do {
            // Video track
            let videoTrack = asset.tracks(withMediaType: .video).first!
            let videoCompositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
            try videoCompositionTrack?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: asset.duration), of: videoTrack, at: .zero)
            videoCompositionTrack?.isEnabled = true
            
            // Audio tracks
            let audioMix = AVMutableAudioMix()
            let audioParams = asset.tracks(withMediaType: .audio).map { track -> AVMutableAudioMixInputParameters in
                let audioInputParams = AVMutableAudioMixInputParameters(track: track)
                audioInputParams.setVolume(0, at: .zero)
                return audioInputParams
            }
            audioMix.inputParameters = audioParams
            
            // Export session
            guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
                print("Cannot create export session")
                completion(nil)
                return
            }
            
            let outputURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("output.mov")
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mov
            
            exportSession.audioMix = audioMix
            
            exportSession.exportAsynchronously {
                switch exportSession.status {
                case .completed:
                    print("Export completed successfully: \(outputURL)")
                    completion(outputURL)
                case .failed:
                    if let error = exportSession.error {
                        print("Export failed with error: \(error.localizedDescription)")
                    }
                    completion(nil)
                case .cancelled:
                    print("Export cancelled")
                    completion(nil)
                default:
                    break
                }
            }
        } catch {
            print("Error creating composition: \(error.localizedDescription)")
            completion(nil)
        }
    }

}


extension VideoCompressionVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // dismiss(animated: true, completion: nil)
            //guard let movieUrl = info[.mediaURL] as? URL else { return }
        //print("vidoe url",movieUrl)
        
        
         //let videoURL = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as! NSURL?
        guard let videoURL = info[.mediaURL] as? URL else { return }
        let data = NSData(contentsOf: videoURL as URL)!
      
      let strUrl = String(describing: videoURL)
      
      Compression.shared.compress(videoPath: strUrl, renderSize: CGSize(width: 80, height: 50)) { result, data in
          print("video compress data ->>>>>>>> ", result)
      }
      
      
        print("File size before compression: \(Double(data.length / 1048576)) mb")
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".m4v")
        compressVideo(inputURL: videoURL as URL, outputURL: compressedURL) { (exportSession) in
                guard let session = exportSession else {
                    return
                }

                switch session.status {
                case .unknown:
                    break
                case .waiting:
                    break
                case .exporting:
                    break
                case .completed:
                    guard let compressedData = NSData(contentsOf: compressedURL) else {
                        return
                    }
                   print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                case .failed:
                    break
                case .cancelled:
                    break
                @unknown default:
                    fatalError("error")
                }
            }
        self.dismiss(animated: true, completion: nil)
            // work with the video URL
    }
    
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       // if info[UIImagePickerController.InfoKey.mediaType.rawValue] as? String == (kUTTypeMovie as? String) {
            // here your video capture code
        let videoURL = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as! NSURL?
        
        let inputURL = URL(fileURLWithPath: "path_to_input_video.mp4")
        let outputURL = URL(fileURLWithPath: "path_to_output_video.mp4")
        
        removeSound(from: videoURL! as URL, outputURL: videoURL! as URL) { error in
            if let error = error {
                print("Error removing sound:", error.localizedDescription)
            } else {
                print("Sound removed successfully and saved at:", outputURL.path)
            }
        }
        
            let data = NSData(contentsOf: videoURL! as URL)!
         
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".m4v")
         
         let strUrl = String(describing: videoURL)
         
         Compression.shared.compress(videoPath: strUrl, renderSize: CGSize(width: 80, height: 50)) { result, data in
             print("video compress data ->>>>>>>> ", data)
         }
         
            compressVideo(inputURL: videoURL! as URL, outputURL: compressedURL) { (exportSession) in
                    guard let session = exportSession else {
                        return
                    }

                    switch session.status {
                    case .unknown:
                        break
                    case .waiting:
                        break
                    case .exporting:
                        break
                    case .completed:
                        guard let compressedData = NSData(contentsOf: compressedURL) else {
                            return
                        }
                       print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                        
                    case .failed:
                        break
                    case .cancelled:
                        break
                    @unknown default:
                        fatalError("error")
                    }
                }
         //  }
           self.dismiss(animated: true, completion: nil)
    }
    
 
    
 /*   func imagePickerController(_ picker: UIImagePickerController,
                                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
       
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.imgProfile.image = image
            self.imgDataLogo = imgProfile.image!.jpegData(compressionQuality: 0.1)!
            self.imgProfile.contentMode = .scaleToFill
            self.dismiss(animated: true, completion: {
                self.uploadModeel.UploadProfile(imgDataLogoo: self.imgDataLogo) { result in
                    switch result{
                    case .success(let favdata):
                        let arr = favdata.msg
                        print("All data ->>>>>>",arr!)
                        self.toastMessage(arr!)
                    case .failure(let error):
                        print(error)
                    }
                }
            })
             
       }
    }
    */
    
    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
           let urlAsset = AVURLAsset(url: inputURL, options: nil)
           guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
               handler(nil)

               return
           }

           exportSession.outputURL = outputURL
           exportSession.outputFileType = AVFileType.mov
           exportSession.shouldOptimizeForNetworkUse = true
           exportSession.exportAsynchronously { () -> Void in
               handler(exportSession)
           }
       }
    
}

extension VideoCompressionVC{
    func removeSound(from videoURL: URL, outputURL: URL, completion: @escaping (Error?) -> Void) {
        let asset = AVAsset(url: videoURL)
        
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
            completion(NSError(domain: "com.yourapp.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create export session"]))
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
     
        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = []
        exportSession.audioMix = audioMix
        
        exportSession.exportAsynchronously {
            if exportSession.status == .completed {
                completion(nil)
            } else if let error = exportSession.error {
                completion(error)
            } else {
                completion(NSError(domain: "com.yourapp.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
            }
        }
    }
    

    
}

extension VideoCompressionVC{
    func removeAudioFromVideo(videoURL: URL, completion: @escaping (URL?) -> Void) {
        // Create an AVAsset from the input video URL
        let asset = AVAsset(url: videoURL)
        
        // Create an AVMutableComposition to hold the video without audio
        let composition = AVMutableComposition()
        
        // Get the video track from the asset
        guard let videoTrack = asset.tracks(withMediaType: .video).first else {
            completion(nil)
            return
        }
        
        // Create a new composition track for the video
        let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        do {
            // Insert the video track into the composition track
            try compositionVideoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: videoTrack, at: .zero)
        } catch {
            print("Error inserting video track: \(error)")
            completion(nil)
            return
        }
        
        // Create an export session to export the composition without audio
        guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil)
            return
        }
        
        // Create a URL for the output video
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
        
        // Set the output URL and output file type
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        
        // Export the composition
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(outputURL)
            case .failed, .cancelled:
                print("Export failed or was cancelled: \(String(describing: exportSession.error))")
                completion(nil)
            default:
                break
            }
        }
    }

}
