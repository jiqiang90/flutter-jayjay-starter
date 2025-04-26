import Foundation

@objc class ICloudService: NSObject {
    @objc static let shared = ICloudService()
    
    @objc func isICloudAvailable() -> Bool {
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    @objc func syncToICloud(filePath: String) -> Bool {
        guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else {
            return false
        }
        
        do {
            // 创建 iCloud 容器目录（如果不存在）
            try FileManager.default.createDirectory(at: containerURL, withIntermediateDirectories: true)
            
            let sourceURL = URL(fileURLWithPath: filePath)
            let destinationURL = containerURL.appendingPathComponent(sourceURL.lastPathComponent)
            
            // 如果目标文件已存在，先删除
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            
            // 复制文件到 iCloud
            try FileManager.default.setUbiquitous(true, itemAt: sourceURL, destinationURL: destinationURL)
            return true
        } catch {
            print("iCloud sync error: \(error)")
            return false
        }
    }
    
    @objc func restoreFromICloud(destinationPath: String) -> Bool {
        guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else {
            return false
        }
        
        do {
            let destinationURL = URL(fileURLWithPath: destinationPath)
            let fileName = destinationURL.lastPathComponent
            let sourceURL = containerURL.appendingPathComponent(fileName)
            
            // 等待文件从 iCloud 下载
            let coordinator = NSFileCoordinator(filePresenter: nil)
            var error: NSError?
            var success = false
            
            coordinator.coordinate(readingItemAt: sourceURL, options: .withoutChanges, error: &error) { (url) in
                do {
                    // 如果目标文件已存在，先删除
                    if FileManager.default.fileExists(atPath: destinationURL.path) {
                        try FileManager.default.removeItem(at: destinationURL)
                    }
                    
                    // 复制文件到本地
                    try FileManager.default.copyItem(at: url, to: destinationURL)
                    success = true
                } catch {
                    print("iCloud restore error: \(error)")
                }
            }
            
            return success && error == nil
        } catch {
            print("iCloud restore error: \(error)")
            return false
        }
    }
} 