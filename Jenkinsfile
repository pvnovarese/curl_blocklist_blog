pipeline {
  environment {
    // "registry" isn't required if we're using docker hub, I'm leaving it here in case 
    // you want to use a different registry, just uncomment this and set as needed.
    // registry = 'registry.hub.docker.com'
    // you need a credential named 'docker-hub' with your DockerID/password to push images
    registryCredential = 'docker-hub'
    // change this repository and imageLine to your DockerID
    repository = 'pvnovarese/curl_blocklist_blog'
    imageLine = "pvnovarese/curl_blocklist_blog:${BUILD_NUMBER} Dockerfile"
    // old image line - delete
    // imageLine = 'pvnovarese/curl_example:dev Dockerfile'
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
        script {
          dockerImage = docker.build repository + ":${BUILD_NUMBER}"
          docker.withRegistry( '', registryCredential ) { 
            dockerImage.push() 
          }
        }
      }      
    }
    stage('Analyze with Anchore plugin') {
      steps {
        writeFile file: 'anchore_images', text: imageLine
        anchore name: 'anchore_images', forceAnalyze: 'true'
        // forceAnalyze is a good idea since we're passing a Dockerfile with the image
      }
    }
    stage('Re-tag as prod and push stable image to registry') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push('prod') 
            // dockerImage.push takes the argument as a new tag for the image before pushing
          }
        }
      }
    }
  }
}
