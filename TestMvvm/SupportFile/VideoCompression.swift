//
//  VideoCompression.swift
//  iGroup
//
//  Created by Sudeep Agrawal on 20/06/19.
//  Copyright © 2019 Advantal. All rights reserved.
//

import Foundation
import AVKit

class Compression {
    static let shared = Compression()
    private init(){

    }
    func compress(videoPath : String,renderSize : CGSize, completion : @escaping (Bool,Data) -> ()) {
        let filemanager = FileManager.default
        let exportVideoPath = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0] as URL
//        let exportVideoPath = documentsDirectory.appendingPathComponent("video.mp4")
//        //Check if the file already exists then remove the previous file
//        if FileManager.default.fileExists(atPath: exportVideoPath.path) {
//            do {
//                try FileManager.default.removeItem(at: exportVideoPath)
//            } catch {
//                completion(false, Data())
//            }
//        }
        let videoUrl = URL(fileURLWithPath: videoPath)

        if (filemanager.fileExists(atPath: videoPath)) {
            completion(false, Data())
            return
        }

        let videoAssetUrl = AVURLAsset(url: videoUrl, options: nil)

        let videoTrackArray = videoAssetUrl.tracks(withMediaType: AVMediaType.video)

        if videoTrackArray.count < 1 {
            completion(false, Data())
            return
        }

        let videoAssetTrack = videoTrackArray[0]

        let audioTrackArray = videoAssetUrl.tracks(withMediaType: AVMediaType.audio)

        if audioTrackArray.count < 1 {
            completion(false, Data())
            return
        }

        let audioAssetTrack = audioTrackArray[0]

        // input readers
        let outputUrl = URL(fileURLWithPath: exportVideoPath.path)
        let videoWriter = try! AVAssetWriter(outputURL: outputUrl, fileType: AVFileType.mp4)
        videoWriter.shouldOptimizeForNetworkUse = true

        let vSettings = videoSettings(size: renderSize)
        let videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: vSettings)
        videoWriterInput.expectsMediaDataInRealTime = false
        videoWriterInput.transform = videoAssetTrack.preferredTransform
        videoWriter.add(videoWriterInput)


        let aSettings = audioSettings()
        let audioWriterInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: aSettings)
        audioWriterInput.expectsMediaDataInRealTime = false
        audioWriterInput.transform = audioAssetTrack.preferredTransform
        videoWriter.add(audioWriterInput)

        // output readers

        let videoReaderSettings : [String : Int] = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)]
        let videoReaderOutput = AVAssetReaderTrackOutput(track: videoAssetTrack, outputSettings: videoReaderSettings)
        let videoReader = try! AVAssetReader(asset: videoAssetUrl)
        videoReader.add(videoReaderOutput)

        var settings = [String : AnyObject]()
        settings[AVFormatIDKey] = Int(kAudioFormatLinearPCM) as AnyObject
        let audioReaderOutput = AVAssetReaderTrackOutput(track: audioAssetTrack, outputSettings: settings)
        let audioReader = try! AVAssetReader(asset: videoAssetUrl)
        audioReader.add(audioReaderOutput)

        videoWriter.startWriting()
        videoReader.startReading()
        videoWriter.startSession(atSourceTime: CMTime.zero)

        let processingVideoQueue = DispatchQueue(__label: "processingVideoCompressionQueue", attr: nil)

        videoWriterInput.requestMediaDataWhenReady(on: processingVideoQueue) {
            while (videoWriterInput.isReadyForMoreMediaData) {

                let sampleVideoBuffer = videoReaderOutput.copyNextSampleBuffer()
                if (videoReader.status == .reading && sampleVideoBuffer != nil) {
                    videoWriterInput.append(sampleVideoBuffer!)
                } else {
                    videoWriterInput.markAsFinished()

                    if (videoReader.status == .completed) {

                        audioReader.startReading()
                        videoWriter.startSession(atSourceTime: CMTime.zero)

                        let processingAudioQueue = DispatchQueue(__label: "processingAudioCompressionQueue", attr: nil)

                        audioWriterInput.requestMediaDataWhenReady(on: processingAudioQueue, using: {
                            while (audioWriterInput.isReadyForMoreMediaData) {
                                let sampleAudioBuffer = audioReaderOutput.copyNextSampleBuffer()
                                if (audioReader.status == .reading && sampleAudioBuffer != nil) {
                                    audioWriterInput.append(sampleAudioBuffer!)
                                } else {
                                    audioWriterInput.markAsFinished()

                                    if (audioReader.status == .completed) {
                                        videoWriter.finishWriting(completionHandler: {
                                            completion(true, exportVideoPath.data())
                                        })
                                    }
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    

    func videoSettings(size : CGSize) -> [String : Any] {

        var compressionSettings = [String : Any]()
        compressionSettings[AVVideoAverageBitRateKey] = 425000

        var settings = [String : Any]()
        settings[AVVideoCompressionPropertiesKey] = compressionSettings
        settings[AVVideoCodecKey] = AVVideoCodecType.h264
        settings[AVVideoHeightKey] = size.height
        settings[AVVideoWidthKey] = size.width

        return settings
    }

    func audioSettings() -> [String : Any] {
        // set up the channel layout
        var channelLayout = AudioChannelLayout()
        memset(&channelLayout, 0, MemoryLayout.size(ofValue: AVChannelLayoutKey));
        channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;

        // set up a dictionary with our outputsettings
        var settings = [String : Any]()
        settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
        settings[AVSampleRateKey] = 44100
        settings[AVNumberOfChannelsKey] = 1
        settings[AVEncoderBitRateKey] = 96000
        //settings[AVChannelLayoutKey] = NSData(bytes:&channelLayout, length:AudioChannelLayout)
        settings[AVChannelLayoutKey] = Data(bytes: &channelLayout, count: MemoryLayout.size(ofValue: AVChannelLayoutKey))

        return settings
    }
}
