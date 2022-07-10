//
//  CameraSessionManager.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 06.04.2022.
//

import AVFoundation

final class CameraSessionManager {
  let captureSession: AVCaptureSession = AVCaptureSession()
  private let queue = DispatchQueue(label: "PlayingWithML.CameraSessionManagerQueue")

  init() {
    setup()
  }

  deinit {
    stopSession()
  }

  func startSession() {
    queue.async {
      if !self.captureSession.isRunning {
        self.captureSession.startRunning()
      }
    }
  }

  func stopSession() {
    if captureSession.isRunning {
      captureSession.stopRunning()
    }
  }

  private func setup() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      setupCaptureSessionAndSetIfPossible()

    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
          self.setupCaptureSessionAndSetIfPossible()
        }
      }

    case .denied:
      return

    case .restricted:
      return
    @unknown default:
      return
    }
  }

  private func setupCaptureSessionAndSetIfPossible() {
    guard let videoDevice = AVCaptureDevice.default(
      .builtInWideAngleCamera,
      for: .video,
      position: .back
    )
    else { return }

    try! videoDevice.lockForConfiguration()
    defer { videoDevice.unlockForConfiguration() }

    guard let input = try? AVCaptureDeviceInput(device: videoDevice) else { return }

    captureSession.beginConfiguration()

    if captureSession.canAddInput(input) {
      captureSession.addInput(input)
    }

    let formatHD60FPS = videoDevice.formats.first {
      guard let maxFPS = $0.videoSupportedFrameRateRanges.last?.maxFrameRate else { return false }

      let dimensions = CMVideoFormatDescriptionGetDimensions($0.formatDescription)

      return maxFPS >= 60 && dimensions.width == 1280
    }

    formatHD60FPS.map { videoDevice.activeFormat = $0 }

    let fps: CMTimeScale = 60
    videoDevice.activeVideoMinFrameDuration = CMTime(value: 1, timescale: fps)
    videoDevice.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: fps)

    captureSession.commitConfiguration()
  }
}
