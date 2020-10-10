import AVFoundation
import Combine
import UIKit

final class FrameExtractor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    var imagePublisher: AnyPublisher<UIImage, Never> {
        return imageFromBufferSubject
            .eraseToAnyPublisher()
    }

    var scaledImagePublisher: AnyPublisher<UIImage, Never> {
        return scaledImageFromBufferSubject
            .eraseToAnyPublisher()
    }

    private var position = AVCaptureDevice.Position.back
    private let quality = AVCaptureSession.Preset.high

    private var permissionGranted = false
    private let sessionQueue = DispatchQueue(label: "frame-ex", attributes: .concurrent)
    private let captureSession = AVCaptureSession()
    private let context = CIContext()

    private var bag = Set<AnyCancellable>()

    private let bufferSubject = PassthroughSubject<CMSampleBuffer, Never>()
    private let imageFromBufferSubject = PassthroughSubject<UIImage, Never>()
    private let scaledImageFromBufferSubject = PassthroughSubject<UIImage, Never>()

    override init() {
        super.init()
        setupStream()

        checkPermission()
        sessionQueue.async { [unowned(unsafe) self] in
            self.configureSession()
            self.captureSession.startRunning()
        }
    }

    private func setupStream() {
        bufferSubject
            .compactMap { raw in
                return Self.images(from: raw)
            }
            .sink(receiveValue: { [unowned(unsafe) self] (high: UIImage, scaled: UIImage) in
                self.imageFromBufferSubject.send(high)
                self.scaledImageFromBufferSubject.send(scaled)
            })
            .store(in: &bag)
    }

    // MARK: AVSession configuration

    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            permissionGranted = true
        case .notDetermined:
            requestPermission()
        default:
            permissionGranted = false
        }
    }

    private func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned(unsafe) self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }

    private func configureSession() {
        guard permissionGranted else {
            fatalError()
        }
        captureSession.sessionPreset = quality
        guard let captureDevice = selectCaptureDevice() else {
            fatalError()
        }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            fatalError()
        }
        guard captureSession.canAddInput(captureDeviceInput) else {
            fatalError()
        }
        captureSession.addInput(captureDeviceInput)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "frame-ex-buf", qos: .userInitiated, attributes: .concurrent))
        guard captureSession.canAddOutput(videoOutput) else {
            fatalError()
        }
        captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(with: AVFoundation.AVMediaType.video) else {
            fatalError()
        }
        guard connection.isVideoOrientationSupported else {
            fatalError()
        }
        guard connection.isVideoMirroringSupported else {
            fatalError()
        }
        connection.videoOrientation = .portrait
        connection.isVideoMirrored = position == .front
        connection.isEnabled = true
    }

    private func selectCaptureDevice() -> AVCaptureDevice? {
        let dualWide = AVCaptureDevice.default(
            .builtInDualWideCamera,
            for: AVMediaType.video,
            position: position
        )

        let dual = AVCaptureDevice.default(
            .builtInDualCamera,
            for: AVMediaType.video,
            position: position
        )

        let wide = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: AVMediaType.video,
            position: position
        )

        let ultraWide = AVCaptureDevice.default(
            .builtInUltraWideCamera,
            for: AVMediaType.video,
            position: position
        )

        let telephoto = AVCaptureDevice.default(
            .builtInTelephotoCamera,
            for: AVMediaType.video,
            position: position
        )

        return dualWide ?? ultraWide ?? dual ?? wide ?? telephoto
    }

    // MARK: -

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        bufferSubject.send(sampleBuffer)
    }

    private static func images(from buffer: CMSampleBuffer) -> (high: UIImage, scaled: UIImage)? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            return nil
        }

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        let srcWidth = CGFloat(ciImage.extent.width)
        let srcHeight = CGFloat(ciImage.extent.height)

        let dstWidth: CGFloat = 356
        let dstHeight: CGFloat = 356

        let scaleX = dstWidth / srcWidth
        let scaleY = dstHeight / srcHeight
        let scale = min(scaleX, scaleY)

        let transform = CGAffineTransform(scaleX: scale, y: scale)

        let output = ciImage
            .transformed(by: transform)
            .cropped(to: CGRect(x: 0, y: 0, width: dstWidth, height: dstHeight))

        return (UIImage(ciImage: ciImage), UIImage(ciImage: output))
    }
}
