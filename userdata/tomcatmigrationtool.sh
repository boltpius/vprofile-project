# Download the tool
wget https://archive.apache.org/dist/tomcat/jakartaee-migration/v1.0.7/binaries/jakartaee-migration-1.0.7-shaded.jar

# Run the migration (converts your war file)
java -jar jakartaee-migration-1.0.7-shaded.jar vprofile-v2.war vprofile-jakarta.war

# Move the NEW converted file to the standard webapps folder
sudo mv vprofile-jakarta.war /var/lib/tomcat10/webapps/ROOT.war

# Restart Tomcat
sudo systemctl restart tomcat10
