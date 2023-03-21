import Foundation

extension NSXPCConnection {
    public func _remoteObject<T: NSObjectProtocol>(type: T.Type = T.self) async throws -> T {
        let remoteObject: T = try await withCheckedThrowingContinuation { continuation in
            guard 
                let remoteObject: T = remoteObjectProxyWithErrorHandler({ error in
                    continuation.resume(with: .failure(error))
                }) as? T
            else {
                fatalError()
            }
            
            continuation.resume(with: .success(remoteObject))
        }
        
        return remoteObject
    }
}
