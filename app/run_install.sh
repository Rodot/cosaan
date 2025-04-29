apt install -y cmake ninja-build
npx @puppeteer/browsers install -y chromedriver@stable

cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y --fix-missing ./google-chrome-stable_current_amd64.deb
