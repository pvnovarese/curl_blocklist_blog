pipeline {
  environment {
    registry = 'registry.hub.docker.com'
    registryCredential = 'docker-hub'
    repository = 'pvnovarese/curl_example'
    imageLine = 'pvnovarese/curl_example:dev Dockerfile'
  }
  agent any
  stages {
    stage('Checkout SCM') {
      steps {
        checkout scm
      }
    }
    stage('Build image and push to registry') {
      steps {
        sh 'docker --version'
        script {
          docker.withRegistry('https://' + registry, registryCredential) {
            def image = docker.build(repository + ':dev')
            image.push()
          }
        }
      }
    }
    stage('Scan') {
      steps {
        sh '/var/jenkins_home/inline/inline_scan-v0.7.3.sh scan -d Dockerfile -b policy_curl_blacklist.json -f -r ${repository}:dev'
      }
    }
    stage('Build and push stable image to registry') {
      steps {
        script {
          docker.withRegistry('https://' + registry, registryCredential) {
            def timeStamp = Calendar.getInstance().getTime().format('YYYYMMdd-HHmmss',TimeZone.getTimeZone('CST'))
            def image = docker.build(repository + ':prod-' + timeStamp)
            image.push()  
            def imageLatest = docker.build(repository + ':latest')
            imageLatest.push()  

          }
        }
      }
    }
  }
}
