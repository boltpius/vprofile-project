FROM openjdk:11 AS BUILD_IMAGE
# build the artifact using multi stage docker file.
RUN apt update && apt install maven -y
RUN git clone https://github.com/devopshydclub/vprofile-project.git
RUN cd vprofile-project && git checkout docker &&  mvn install 

FROM tomcat:9-jre11
LABEL "Project"="Vprofile"
LABEL "Engineer"="Pius"
RUN rm -rf /usr/local/tomcat/webapps/* # This is where the default tomcat application is and can be found in the image repo in docker hub 
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"] # the command to run was provided in the tomcat image in  docker hub 
