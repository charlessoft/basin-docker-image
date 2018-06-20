pipeline {
    agent {
        node {
            label 'ci.basin.ali'
        }
    }

    parameters { string(defaultValue: 'latest', name: 'GIT_TAG', description: '默认master\n1.指定branch/tag' ) }
    stages {

        stage('checkout') {
            steps {
                echo "========="
                    echo "检出源码"
                    //credentialsId 直接复制
                    git(branch: 'master', url: 'ssh://git@47.100.219.148:10023/basin/basin-docker-image.git', credentialsId: '97aafea0-575e-45a9-ab31-c917d8ca99d4')
                    sh """
                    git checkout -b ${GIT_TAG}
                """
                    echo "========="
            }
        }


        stage('build-image') {
            steps {
                echo '======================================='
                    echo '编译镜像'
                    echo '======================================='
                    echo env.JOB_NAME
                    echo '======================================='
                    script{
                    if (env.JOB_NAME == 'alpine-python' ){
                        
                        sh """
                        cd ${JOB_NAME}/2.7; bash build.sh ${GIT_TAG}
                        """
                    }
                    else{
                        sh """
                        cd ${JOB_NAME};echo "sss"
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
            cleanWs()
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



