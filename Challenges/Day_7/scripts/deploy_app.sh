# Pull the Docker image
docker pull slayerop15/web-app:latest

# Run the container
docker stop web-app || true
docker rm web-app || true
docker run -d --name web-app -p 5000:5000 slayerop15/web-app:latest

# Install and configure Nginx
sudo apt install -y nginx

# Create the Nginx configuration file
sudo tee /etc/nginx/sites-available/web-app <<EOF
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# Create a symbolic link if it doesn't already exist
if [ ! -L /etc/nginx/sites-enabled/web-app ]; then
    sudo ln -s /etc/nginx/sites-available/web-app /etc/nginx/sites-enabled/web-app
fi

# Remove the default site configuration if it exists
if [ -L /etc/nginx/sites-enabled/default ]; then
    sudo rm /etc/nginx/sites-enabled/default
fi

# Restart Nginx to apply changes
sudo systemctl restart nginx

echo "Web application deployed successfully!"