pipeline {
  agent {
    kubernetes {
      label 'kaniko-git'
      defaultContainer 'git'
      yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: git
      image: alpine/git:2.45.2
      command: ["sh", "-c", "sleep 99d"]
      tty: true
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.23.2-debug
      command: ["sh", "-c", "sleep 99d"]
      tty: true
'''
    }
  }

  environment {
    AWS_REGION = 'us-west-2'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    TARGET_VALUES_FILE = 'charts/django-app/values.yaml'
  }

  stages {
    stage('Checkout source repo') {
      steps {
        checkout scm
      }
    }

    stage('Build and push image to ECR') {
      steps {
        container('kaniko') {
          withCredentials([
            [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-jenkins-creds'],
            string(credentialsId: 'aws-account-id', variable: 'AWS_ACCOUNT_ID'),
            string(credentialsId: 'ecr-repository-name', variable: 'ECR_REPOSITORY_NAME')
          ]) {
            sh '''
              set -eu
              DESTINATION="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$IMAGE_TAG"
              /kaniko/executor \
                --context "$WORKSPACE" \
                --dockerfile "$WORKSPACE/Dockerfile" \
                --destination "$DESTINATION" \
                --destination "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:latest"
            '''
          }
        }
      }
    }

    stage('Update Helm values in deployment repo') {
      steps {
        container('git') {
          withCredentials([
            string(credentialsId: 'git-token', variable: 'GIT_TOKEN'),
            string(credentialsId: 'aws-account-id', variable: 'AWS_ACCOUNT_ID'),
            string(credentialsId: 'ecr-repository-name', variable: 'ECR_REPOSITORY_NAME'),
            string(credentialsId: 'target-repo-url', variable: 'TARGET_REPO_URL')
          ]) {
            sh '''
              set -eu
              apk add --no-cache sed

              SAFE_URL="${TARGET_REPO_URL#https://}"
              git clone "https://oauth2:${GIT_TOKEN}@${SAFE_URL}" deploy-repo
              cd deploy-repo

              sed -E -i "s#(tag:[[:space:]]*\").*(\")#\1${IMAGE_TAG}\2#" "$TARGET_VALUES_FILE"

              git config user.name "jenkins-bot"
              git config user.email "jenkins-bot@example.com"

              git add "$TARGET_VALUES_FILE"
              git commit -m "chore: update image tag to ${IMAGE_TAG}" || true
              git push origin main
            '''
          }
        }
      }
    }
  }
}


