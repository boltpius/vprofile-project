def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]


pipeline {
    agent any 
    environment {
	NEXUSPASS = 'nexuspass'

    }

    stages {

	stage('Setup parameters') {
		steps {
			script {
				properties([
					parameters([
						string(
							defaultValue: '',
							name: 'BUILD',
						),
						string(
							defaultValue: '',
							name: 'TIME',
						)
					])
				])
			}
		}
	}

        stage("Ansible Deploy to Prod") {
		steps {
			ansiblePlaybook([
				inventory : 'ansible/prod.inventory.yml',
				playbook : 'ansible/site.yml',
				installation : 'ansible', 
				colorized : true,
				credentialsId: 'app01-staging',
				disableHostKeyChecking: true,
				extraVars : [
					USER: "admin",
					PASS: "pius",
					nexusip: "10.0.0.235",
					reponame: "vprofile-release",
					groupid: "QA",
					time: "${env.TIME}",
					build: "${env.BUILD}",
					artifactid: "vproapp",
					vprofile_version: "vproapp-${env.BUILD}-${env.TIME}.war"
				]
			])
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
