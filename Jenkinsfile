pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr:'5', artifactNumToKeepStr:'5', artifactDaysToKeepStr:'7'))
    durabilityHint('PERFORMANCE_OPTIMIZED')
    retry(1)
    skipDefaultCheckout()
    timestamps()
  }
  stages {
    stage ('Checkout') {
      // Checkout Repository
      steps {
        checkout([$class:'GitSCM', branches: [[name: '*/master']], 
        doGenerateSubmoduleConfigurations:false, extensions:[], submoduleCfg:[],
        userRemoteConfigs:[[ url:'https://github.com/samfil-technohub/samuel-nwoye-website-config.git']]])     
      }
    }
    stage ('Template') {
      // Build Test and Register the Golden Image 
      steps {
        sh 'packer --version'
        sh 'packer build -var-file=server-vars.json server-ami.json' 
      }
    }
    stage ('Clean Workspace'){
      steps {
        cleanWs()
      }
    }
  }
  post {
    success {
      slackSend (channel: '#mymonitor', color: 'good', message: "*${currentBuild.currentResult}:* _Job_ ${env.JOB_NAME}; _Build_ ${env.BUILD_NUMBER}\n *Visit:* ${env.BUILD_URL}")
    }
    failure {
      slackSend (channel: '#mymonitor', color: 'danger', message: "*${currentBuild.currentResult}:* _Job_ ${env.JOB_NAME}; _Build_ ${env.BUILD_NUMBER}\n *Visit:* ${env.BUILD_URL}")
    }
  }
}