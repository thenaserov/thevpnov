# THEVPNOV

### 🧩 **System Components**

#### 1. **UI Layer (QML + C++ Backend)**

* **Login Page:**

  * Inputs: Host, Port, Username, Password
  * Save as profile (optional checkbox)
* **Profile Management Page:**

  * List of saved profiles (from SQLite)
  * Add / Edit / Delete buttons
* **Status Page:**

  * Connection status
  * IP info, traffic stats
  * "Connect", "Disconnect" button

#### 2. **SQLite Database**

* Table: `profiles`

  ```sql
  CREATE TABLE profiles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      host TEXT NOT NULL,
      port INTEGER DEFAULT 22,
      username TEXT NOT NULL,
      password TEXT NOT NULL
  );
  ```

#### 3. **SSH Tunnel Engine (C++)**

* Use `libssh` or native `ssh` binary.
* Establish SOCKS5 proxy via:

  ```bash
  ssh -N -D 1080 username@host
  ```
* Wrap process handling in C++ (`QProcess`).

#### 4. **System Proxy Configuration**

* Linux: Use `gsettings` for GNOME, `networksetup` for macOS, and Windows Registry or `netsh` for Windows.
* Detect OS and apply accordingly.
* Revert on disconnect.

---

### 🔄 **Workflow**

1. **User Launches App**
2. **Chooses/Saves SSH Profile**
3. **Clicks "Connect"**

   * Start SSH SOCKS5 tunnel (via QProcess)
   * Set system proxy (127.0.0.1:1080)
   * Show connected state
4. **Clicks "Disconnect"**

   * Kill SSH process
   * Restore previous proxy settings

---

### 🛡️ Security Considerations

* Encrypt saved passwords using `QCryptographicHash` or system keychain
* Ensure tunnel is monitored (restart if killed)
* Prevent multiple tunnels from launching simultaneously
