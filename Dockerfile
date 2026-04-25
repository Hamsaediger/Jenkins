# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the static HTML file to the Nginx html directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
