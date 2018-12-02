//
//  ViewController.swift
//  ParagonHealth
//
//  Created by otto on 12/1/18.
//  Copyright © 2018 ParagonHealth. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

class MainVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageCmr: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var riskImg: UIImageView!
    @IBOutlet weak var riskLbl: UILabel!
    @IBOutlet weak var riskView: UIView!
    
    var lvl = 0.0
    
    override func viewDidLoad() {
        self.title = "Trial Screening"
        
        self.cameraButton.layer.cornerRadius = 25
    }
    
    // MARK: - Image Classification
    
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Model().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load ML model: \(error)")
        }
    }()
    
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        classificationLabel.text = "Classifying..."
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.classificationLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                self.classificationLabel.text = "Nothing recognized."
            } else {
              
                let topClassifications = classifications.prefix(1)
                let descriptions = topClassifications.map { classification -> String in
                    if classification.identifier != "benign" {
                        self.lvl = Double(classification.confidence)
                    }
                    return String(format: "%.1f%% %@", classification.confidence * 100, classification.identifier)
                }
                self.classificationLabel.text = "(" + descriptions.joined(separator: " ") + ")"
                self.riskView.isHidden = false
                
                if self.lvl >= 0.7 {
                    self.riskImg.image = UIImage(named: "icn-risk-hi")
                    self.riskLbl.text = "High risk"
                } else if self.lvl >= 0.3 {
                    self.riskImg.image = UIImage(named: "icn-risk-med")
                    self.riskLbl.text = "Medium risk"
                } else {
                    
                }
                self.cameraButton.isHidden = true
                self.imageCmr.isHidden = true
            }
        }
    }
    
    // MARK: - Photo Actions
    
    @IBAction func takePicture() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Handling Image Picker Selection
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        updateClassifications(for: image)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
