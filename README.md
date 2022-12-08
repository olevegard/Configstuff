# Configstuff

## New PC Setup

### Install everything
```
sudo pacman -S cmake firefox docker go neovim steam ninja vlc edge lcov
yay -S slack-desktop jdk11-openjdk deezer microsoft-edge-stable-bin
```

## Setup

### Android SDK
```
mkdir ~/Android
cd ~/Android
wget commandlinetools-linux-8512546_latest.zip
unzip commandlinetools-linux-8512546_latest.zip

./sdkmanager --sdk_root=~/Android/
yes | ./sdkmanager --install "sources;android-33" "system-images;android-33;google_apis;arm64-v8a" "platforms;android-33" "build-tools;33.0.0" "platform-tools"
yes | flutter doctor --android-licenses
```

### Java


### Environment
```
export ANDROID_HOME="/home/olevegard/Android"
export PATH="$PATH:/home/olevegard/Programming/flutter/bin:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/cmdline-tools/tools/bin/"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export GOPATH="/home/olevegard/Programming/go"
```

### Docker

```
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $USER
```

### Neovim
```
cp init.lua ~/.config/nvim/
```

### NTP
```
sudo systemctl status ntpd.service
```
