pipeline {
    agent any
    //agent {
    //    node {
    //        label 'ci.basin.ali'
    //    }
    //}
    environment {
      SNAPSHOTS = '/data/basin-baseenv/data/docker-release-server/httpd/html/releases/helloworld/snapshots'
    
   }

    parameters { string(defaultValue: 'latest', name: 'GIT_TAG', description: '默认master\n1.指定branch/tag' ) }
    stages {

        //stage('clean_workspace') {
        //  steps {
        //    deleteDir()
        //  }
        //}
        stage('checkout') {
            steps {
                 echo "========="
                     echo "检出源码"
                     script {
                         if (env.GIT_TAG == 'latest') {
                                 sh '''
                             git checkout -b ${GIT_TAG}
                             '''
                         } else{
                             sh '''
                             git checkout  ${GIT_TAG}
                         '''
                         }
                     }

                     echo "========="
            }
        }


        stage('build-image-push-image') {
            steps {
                    echo '======================================='
                    echo '编译镜像'
                    echo '======================================='
                    echo env.JOB_NAME
                    echo '======================================='
                    script{
                    if (env.JOB_NAME == 'alpine-python' ){
                        
                        sh """
                        echo "======"
                        echo ${DOCKER_PRIVATE_SERVER}

                        """
                    }
                    else if(env.JOB_NAME == 'alpine-python-3' ) {
                        sh """
                        cd alpine-python/3;bash build.sh ${GIT_TAG}
                        docker tag basin/alpine-python3:${GIT_TAG} ${DOCKER_PRIVATE_SERVER}/alpine-python3:${GIT_TAG}
                        docker push ${DOCKER_PRIVATE_SERVER}/alpine-python3:${GIT_TAG}
                        """
                    }
                    else if(env.JOB_NAME == 'dockercloud-haproxy'){
                        sh """
                        cd ${JOB_NAME}/1.6.7; bash build.sh ${GIT_TAG}
                        """
                    }
                    else{
                        sh """
                        cd ${JOB_NAME}; bash build.sh ${GIT_TAG}
                        docker tag basin/${JOB_NAME}:${GIT_TAG} ${DOCKER_PRIVATE_SERVER}/${JOB_NAME}:${GIT_TAG}
                        docker push ${DOCKER_PRIVATE_SERVER}/${JOB_NAME}:${GIT_TAG}
                        """
                    }
                }
                    
            }
        }

        stage('test') {
            steps {
                echo '======================================='
                    echo 'test..'
                    echo '======================================='

            }
        }


        stage('publish') {
            steps {
                echo "code sync"
                    script {
                        if (env.GIT_TAG == 'master') {
                            echo 'master主干,发布到snapshots/'
                                sh 'mkdir -p /data/basin-baseenv/data/docker-release-server/httpd/html/releases/basin-docker-image/snapshots'
                                sh "docker save ci_hellowrld:latest > /data/basin-baseenv/data/docker-release-server/httpd/html/releases/basin-docker-image/snapshots/${JOB_NAME}_${GIT_TAG}.tar"


                        } else {

                            echo "指定编译版本 ${GIT_TAG},发布到指定目录"

                        }

                    }
            }
        }


    }
    //post 这段直接复制
    post {
       always {
              echo 'One way or another, I have finished'
              deleteDir() /* clean up our workspace */
        }
        success {
            httpRequest consoleLogResponseBody: true, contentType: 'APPLICATION_JSON_UTF8', httpMode: 'POST', ignoreSslErrors: true, requestBody: """{
                "msgtype": "link",
                    "link": {
                        "title": "${env.JOB_NAME}${env.BUILD_DISPLAY_NAME} 构建成功",
                        "text": "项目[${env.JOB_NAME}${env.BUILD_DISPLAY_NAME}] 构建成功，构建耗时 ${currentBuild.durationString}",
                        "picUrl": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/sign-check-icon.png",
                        "messageUrl": "${env.BUILD_URL}"
                    }
            }""", responseHandle: 'NONE', url: 'https://oapi.dingtalk.com/robot/send?access_token=fd87df4f83611b4c4cf31d5ad48f890f9603b57b1cac3d52fb80df8b86a5b629'
        }
        failure {
            httpRequest consoleLogResponseBody: true, contentType: 'APPLICATION_JSON_UTF8', httpMode: 'POST', ignoreSslErrors: true, requestBody: """{
                "msgtype": "link",
                    "link": {
                        "title": "${env.JOB_NAME}${env.BUILD_DISPLAY_NAME} 构建失败",
                        "text": "项目[${env.JOB_NAME}${env.BUILD_DISPLAY_NAME}] 构建失败，构建耗时 ${currentBuild.durationString}",
                        "picUrl": "http://www.iconsdb.com/icons/preview/soylent-red/x-mark-3-xxl.png",
                        "messageUrl": "${env.BUILD_URL}"
                    }
            }""", responseHandle: 'NONE', url: 'https://oapi.dingtalk.com/robot/send?access_token=fd87df4f83611b4c4cf31d5ad48f890f9603b57b1cac3d52fb80df8b86a5b629'
        }
    }
}



