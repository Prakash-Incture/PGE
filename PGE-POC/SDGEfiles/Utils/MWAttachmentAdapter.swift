////
////  MWAttachmentAdapter.swift
////  ADLSA
////
////  Created by mahabaleshwar hegde on 07/08/19.
////  Copyright © 2019 ADLSA. All rights reserved.
////
//
//import SAPFiori
//import Photos
//import MobileCoreServices
//
//protocol MWAttachmentAdapterDelegate: class {
//    func updateAttachmentViewHolder()
//}
//
//class MWAttachmentAdapter: NSObject {
//    
//    weak var delegate: MWAttachmentAdapterDelegate?
//    
//    private var isAttachementExist: Bool = false
//    // SAP using this internally
//    private var attachmentURLs = [URL]() {
//        didSet {
//            self.isAttachementExist = (self.attachmentURLs.count > 0)
//        }
//    }
//    
//    private(set) var cahceAttachmentURLs = [URL]()
//    private var attachmentThumbnails = [String: UIImage]() {
//        didSet {
//            self.isAttachementExist = (self.attachmentThumbnails.count > 0)
//        }
//    }
//    
//}
//
//
//extension MWAttachmentAdapter {
//    
//    func configureAttachmentTypeCell(tableView: UITableView, indexPath: IndexPath, title: String?) -> UITableViewCell {
//        
//        let attachmentCell = tableView.dequeueReusableCell(withIdentifier: FUIAttachmentsFormCell.reuseIdentifier, for: indexPath) as! FUIAttachmentsFormCell
//        attachmentCell.selectionStyle = .none
//        if title != nil {
//            attachmentCell.attachmentsController.title = title
//        }
//        attachmentCell.attachmentsController.customAttachmentsTitleFormat = "ATTACHMENT".localized + " (%d)"
//        attachmentCell.attachmentsController.delegate = self
//        attachmentCell.attachmentsController.dataSource = self
//        
//        attachmentCell.attachmentsController.reloadData()
//        
//        let addPhotoAction = FUIAddPhotoAttachmentAction()
//        addPhotoAction.delegate = self
//        attachmentCell.attachmentsController.addAttachmentAction(addPhotoAction)
//        
//        let takePhotoAction = FUITakePhotoAttachmentAction()
//        takePhotoAction.delegate = self
//        attachmentCell.attachmentsController.addAttachmentAction(takePhotoAction)
//        
//        let pickDocumentAction = FUIDocumentPickerAttachmentAction()
//        pickDocumentAction.delegate = self
//        attachmentCell.attachmentsController.addAttachmentAction(pickDocumentAction)
//        
//        attachmentCell.attachmentsController.maxItems = 3
//        attachmentCell.setTintColor(.themeColor, for: .normal)
//        return attachmentCell
//    }
//}
//
//
//// MARK :- Attachment data
//
//extension MWAttachmentAdapter {
//    
//    func getAttachemtData() -> [(data: Data, fileName: String, mimeType: String)] {
//        
//        guard self.cahceAttachmentURLs.count > 0 else  {
//            return []
//        }
//        
//        var attchmentList: [(data: Data, fileName: String, mimeType: String)] = []
//        for url in self.cahceAttachmentURLs {
//            let fileName = url.lastPathComponent
//            let mimeType = LRAttachment.FileType.getMimeType(fileExtension: url.pathExtension) ?? LRAttachment.ImageType.jpeg.rawValue
//            do {
//                let data = try Data(contentsOf: url)
//                attchmentList.append((data, fileName, mimeType))
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return attchmentList
//    }
//    
//    private func saveDocumentToCacheDirectory(attachmentURL: URL) -> URL {
//        
//        do {
//            let fileName = UUID().uuidString + LRAttachment.DocType.pdf.fileExtesnion
//            let data = try Data(contentsOf: attachmentURL)
//            let cacheURLPath = MWDocumentManager.shared.saveImage(data: data, fileName: fileName)!
//            return URL(fileURLWithPath: cacheURLPath)
//        } catch {
//            return attachmentURL
//        }
//    }
//    
//    // This function is invoked for setup thumbnails
//    private func setupThumbnails(_ attaURL: URL, with asset: PHAsset) {
//        let imageManager = PHImageManager.default()
//        let requestOptions = PHImageRequestOptions()
//        requestOptions.deliveryMode = .fastFormat
//        requestOptions.resizeMode = .exact
//        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
//        
//        do {
//            let imageData = try Data(contentsOf: attaURL)
//            let image = UIImage(data: imageData)
//            self.saveImage(image, attaURL: attaURL)
//        } catch let error as NSError {
//            print(error.userInfo)
//            imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions, resultHandler: { image, _ in
//                self.saveImage(image, attaURL: attaURL)
//            })
//        }
//    }
//    
//    private func saveImage(_ imageData: UIImage?, attaURL: URL) {
//        var resizedImage = imageData
//        if let value = imageData, value.imageSize > 3.0 {
//            resizedImage = value.resizeImage(maxWidth: 600, maxHeight: 600, compressionQuality: 1.0)
//        }
//        let fileName = UUID().uuidString + LRAttachment.ImageType.jpeg.fileExtesnion
//        let cacheURLPath = MWDocumentManager.shared.saveImage(data: resizedImage!, fileName: fileName)
//        let url = URL(fileURLWithPath: cacheURLPath!)
//        self.cahceAttachmentURLs.append(url)
//        self.attachmentThumbnails[attaURL.absoluteString] = resizedImage?.toImage()
//        DispatchQueue.main.async {
//            self.delegate?.updateAttachmentViewHolder()
//        }
//    }
//}
//
//// MARK: FUIAttachmentsViewControllerDataSource
//
//extension MWAttachmentAdapter: FUIAttachmentsViewControllerDataSource {
//    // Gets the number of attachments to display in the FUIAttachmentsViewController's collection
//    func numberOfAttachments(in _: FUIAttachmentsViewController) -> Int {
//        return self.attachmentURLs.count
//    }
//    
//    // Gets the file URL of the attachment resource
//    func attachmentsViewController(_: FUIAttachmentsViewController,
//                                   urlForAttachmentAtIndex index: Int) -> URL? {
//        return self.attachmentURLs[index]
//    }
//    
//    // Gets the thumbnail image for the attachment at the specified index
//    func attachmentsViewController(_: FUIAttachmentsViewController,
//                                   iconForAttachmentAtIndex index: Int) -> (image: UIImage, contentMode: UIView.ContentMode)? {
//        let urlString = attachmentURLs[index].absoluteString
//        guard let image = attachmentThumbnails[urlString] else {
//            return nil
//        }
//        return (image, .scaleAspectFill)
//    }
//}
//
//// MARK: FUIAttachmentsViewControllerDelegate
//
//extension MWAttachmentAdapter: FUIAttachmentsViewControllerDelegate {
//    // To notify when user tapped delete to an attachment
//    
//    func attachmentsViewController(_ attachmentsViewController: FUIAttachmentsViewController, didPressDeleteAtIndex index: Int) {
//        
//        if self.cahceAttachmentURLs.indices.contains(index) {
//            // Delete doc from document directory
//            let url = self.cahceAttachmentURLs[index]
//            MWDocumentManager.shared.deleteImage(fileName: url.lastPathComponent)
//            self.cahceAttachmentURLs.remove(at: index)
//            self.attachmentThumbnails[url.absoluteString] = nil
//        }
//        self.attachmentURLs.remove(at: index)
//        self.delegate?.updateAttachmentViewHolder()
//    }
//    
//    func attachmentsViewController(_ attachmentsViewController: FUIAttachmentsViewController, couldNotPresentAttachmentAtIndex index: Int) {
//        
//    }
//}
//
//// MARK: FUITakePhotoAttachmentActionDelegate
//
//extension MWAttachmentAdapter: FUITakePhotoAttachmentActionDelegate {
//    // This function is invoked when a photo is taken from camera
//    func takePhotoAttachmentAction(_: FUITakePhotoAttachmentAction, didTakePhoto asset: PHAsset, at url: URL) {
//        
//        self.setupThumbnails(url, with: asset)
//        self.attachmentURLs.append(url)
//    }
//}
//
//// MARK: FUIAddPhotoAttachmentActionDelegate
//
//extension MWAttachmentAdapter: FUIAddPhotoAttachmentActionDelegate {
//    // This function is invoked when a photo is selected from a photo picker
//    func addPhotoAttachmentAction(_: FUIAddPhotoAttachmentAction, didSelectPhoto asset: PHAsset, at url: URL) {
//        self.setupThumbnails(url, with: asset)
//        self.attachmentURLs.append(url)
//    }
//}
//
//// MARK: FUIDocumentPickerAttachmentActionDelegate
//
//extension MWAttachmentAdapter: FUIDocumentPickerAttachmentActionDelegate {
//    
//    var documentPicker: UIDocumentPickerViewController {
//        let documentTypes: [String] = [kUTTypePDF, kUTTypePNG, kUTTypeJPEG] as [String]
//        return UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
//    }
//    
//    func documentPickerAttachmentAction(_: FUIDocumentPickerAttachmentAction, didPickFileAt url: URL) {
//        
//        self.attachmentURLs.append(url)
//        let cahceURL = self.saveDocumentToCacheDirectory(attachmentURL: url)
//        self.cahceAttachmentURLs.append(cahceURL)
//        self.delegate?.updateAttachmentViewHolder()
//    }
//}
