pipeline {
    agent {
        docker {
            image 'Robot'
        }
    }
    stages {
        stage('Build'){
            steps{
                echo 'Building or Resolve Dependencies!'
                sh 'pip install robotframework'
                sh 'pip install --upgrade robotframework-seleniumlibrary'
                sh 'pip install robotframework-requests'

            }
        }
        stage('Test'){
            steps{
                echo 'Running regression tests'
                sh 'robot -d tests/results tests/TestCases.robot'
            }
        }
    }
    
}
