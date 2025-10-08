# 0) Base packages (git, curl, nginx, dos2unix)
sudo apt-get update -y
sudo apt-get install -y git curl ca-certificates gnupg nginx dos2unix

# 1) Convert CRLF -> LF across your working dir (adjust path if needed)
# If your script is already on the instance:
dos2unix install-env.sh 2>/dev/null || true
# If you've copied other files too, normalize all of them:
# find . -type f -exec dos2unix {} \; 2>/dev/null || true

# 2) Install Node.js properly (NodeSource; works on Ubuntu 22.04)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
npm -v

# 3) PM2 for Node apps
sudo npm i -g pm2

# 4) Clean any broken clone attempts and re-clone your repo (no '?/' at the end!)
cd /home/ubuntu || cd ~
sudo rm -rf SAS-LAB6
git clone https://github.com/AlbertoSardo/SAS-LAB6.git
cd SAS-LAB6

# 5) Make sure all text files are LF (prevents systemd/nginx issues)
find . -type f -exec dos2unix {} \; 2>/dev/null || true

# 6) Install frontend deps (if package.json exists)
if [ -f package.json ]; then
  npm install
  # ensure DynamoDB client exists
  npm ls @aws-sdk/client-dynamodb >/dev/null 2>&1 || npm i @aws-sdk/client-dynamodb
fi

# 7) Put your nginx site config in place (requires that ./default exists in repo)
if [ -f ./default ]; then
  sudo cp ./default /etc/nginx/sites-available/default
  sudo systemctl daemon-reload
  sudo systemctl restart nginx
  sudo systemctl enable nginx
fi

# 8) Start the app (ensure app.js exists at repo root)
if [ -f ./app.js ]; then
  pm2 start ./app.js --name module-06
  pm2 save
else
  echo "ERROR: app.js not found at /home/ubuntu/SAS-LAB6/app.js"
fi

