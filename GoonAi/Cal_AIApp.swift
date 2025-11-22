// Legacy entry point retained intentionally blank after migration to `GoonAiApp`.
// Remove this file once the Xcode project no longer references it.

import Foundation

// Keeping a harmless symbol so the file compiles and can be referenced without @main conflicts.
extension Notification.Name {
    static let goonaiMigrated = Notification.Name("goonai.migrated")
}
