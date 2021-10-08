rm -rf /root/sethforprivacy.com/public /root/sethforprivacy.com/tor
cd /root/sethforprivacy.com/

# Pull the latest changes from Github
git pull

# Build the clearnet static site
echo "Building the clearnet static site..."
hugo --config clearnet_config.toml

# Build the Tor static site
echo "Building the Tor static site..."
hugo --config tor_config.toml

# Compress the clearnet static site
echo "Compressing /public..."
cd /root/sethforprivacy.com/public
for file in $(find . -type f)
do
    zopfli "$file"
    rm "$file"
    touch -r "$file".gz "$file"
done

# Compress the Tor static site
echo "Compressing /tor..."
cd /root/sethforprivacy.com/tor
for file in $(find . -type f)
do
    zopfli "$file"
    rm "$file"
    touch -r "$file".gz "$file"
done

cd ~
echo "Building new Docker image..."
docker build -f Dockerfile . -t sethforprivacy-nginx:public
docker-compose up -d