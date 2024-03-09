def buildNumber = Jenkins.instance.getItem('cicd-jenkinsbeanstalk-stage').lastSuccessfulBuild.number // this basically use the last sucessful build number from the staging pipeline to deploy to the production pipeline. All you have to do is to replace the name of  the job to the staging name. 

def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]


pipeline {
    agent any 
    tools {
        maven "MAVEN3"
        jdk "OracleJDK11"
    }

    environment {
        SNAP_REPO = 'vprofile-snapshot'
        NEXUS_USER = 'admin' // to login to nexus using username and password 
        NEXUS_PASS = 'pius'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUSIP = '10.0.0.235'  // nexus server private ip 
        NEXUSPORT = '8081'
        NEXUS_GRP_REPO = 'vprofile-maven-group'
        NEXUS_LOGIN = 'nexuslogin' // from credentials in jenkins

        AWS_REGION = 'eu-west-1'

        SONARSERVER = 'sonarserver' //server name saved under system in jenkins 
        SONARSCANNER = 'sonarscanner' // UNDER tool in jenkins, the name of the scanner tool added under global tool in jenkins. 
        
        ARTIFACT_NAME = "vprofile-v${buildNumber}.war"
        AWS_S3_BUCKET = 'cicd-jenkins-s3'
        AWS_EB_APP_NAME = 'hybridcicd'
        AWS_EB_ENVIRONMENT = 'Hybridcicd-prod-env'
        AWS_EB_APP_VERSION = "pius${buildNumber}"
    }

    stages {

        stage("Deploy to stage Beanstalk") {
            steps{
                withAWS(credentials: 'awsbeancreds', region: "${AWS_REGION}") {
                sh 'aws elasticbeanstalk update-environment --application-name $AWS_EB_APP_NAME --environment-name $AWS_EB_ENVIRONMENT --version-label $AWS_EB_APP_VERSION' 
                }
            }
        }
    }
    // post {
    //     always {
    //         echo 'Slack Notifications.'
    //         slackSend channel: '#jenkinscicd',
    //             color: COLOR_MAP[currentBuild.currentResult],
    //             message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
    //     }
    // }
}




//

// pipeline {
    
// 	agent any
// /*	
// 	tools {
//         maven "maven3"
//     }
// */	
//     environment {
//         NEXUS_VERSION = "nexus3"
//         NEXUS_PROTOCOL = "http"
//         NEXUS_URL = "172.31.40.209:8081"
//         NEXUS_REPOSITORY = "vprofile-release"
// 	NEXUS_REPOGRP_ID    = "vprofile-grp-repo"
//         NEXUS_CREDENTIAL_ID = "nexuslogin"
//         ARTVERSION = "${env.BUILD_ID}"
//     }
	
//     stages{
        
//         stage('BUILD'){
//             steps {
//                 sh 'mvn clean install -DskipTests'
//             }
//             post {
//                 success {
//                     echo 'Now Archiving...'
//                     archiveArtifacts artifacts: '**/target/*.war'
//                 }
//             }
//         }

// 	stage('UNIT TEST'){
//             steps {
//                 sh 'mvn test'
//             }
//         }

// 	stage('INTEGRATION TEST'){
//             steps {
//                 sh 'mvn verify -DskipUnitTests'
//             }
//         }
		
//         stage ('CODE ANALYSIS WITH CHECKSTYLE'){
//             steps {
//                 sh 'mvn checkstyle:checkstyle'
//             }
//             post {
//                 success {
//                     echo 'Generated Analysis Result'
//                 }
//             }
//         }

//         stage('CODE ANALYSIS with SONARQUBE') {
          
// 		  environment {
//              scannerHome = tool 'sonarscanner4'
//           }

//           steps {
//             withSonarQubeEnv('sonar-pro') {
//                sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
//                    -Dsonar.projectName=vprofile-repo \
//                    -Dsonar.projectVersion=1.0 \
//                    -Dsonar.sources=src/ \
//                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
//                    -Dsonar.junit.reportsPath=target/surefire-reports/ \
//                    -Dsonar.jacoco.reportsPath=target/jacoco.exec \
//                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
//             }

//             timeout(time: 10, unit: 'MINUTES') {
//                waitForQualityGate abortPipeline: true
//             }
//           }
//         }

//         stage("Publish to Nexus Repository Manager") {
//             steps {
//                 script {
//                     pom = readMavenPom file: "pom.xml";
//                     filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
//                     echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
//                     artifactPath = filesByGlob[0].path;
//                     artifactExists = fileExists artifactPath;
//                     if(artifactExists) {
//                         echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version} ARTVERSION";
//                         nexusArtifactUploader(
//                             nexusVersion: NEXUS_VERSION,
//                             protocol: NEXUS_PROTOCOL,
//                             nexusUrl: NEXUS_URL,
//                             groupId: NEXUS_REPOGRP_ID,
//                             version: ARTVERSION,
//                             repository: NEXUS_REPOSITORY,
//                             credentialsId: NEXUS_CREDENTIAL_ID,
//                             artifacts: [
//                                 [artifactId: pom.artifactId,
//                                 classifier: '',
//                                 file: artifactPath,
//                                 type: pom.packaging],
//                                 [artifactId: pom.artifactId,
//                                 classifier: '',
//                                 file: "pom.xml",
//                                 type: "pom"]
//                             ]
//                         );
//                     } 
// 		    else {
//                         error "*** File: ${artifactPath}, could not be found";
//                     }
//                 }
//             }
//         }


//     }


// }
