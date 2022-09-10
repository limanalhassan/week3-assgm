node {
    
    stage ("Fetch code") {
        git branch: 'main', url: 'https://github.com/limanalhassan/week3-assgm.git'
    }
    
    stage ("Build") {
        def mvnHome = tool name: 'mymvn', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
    }
    
    stage ("Deploy .war file") {
        sshPublisher(publishers: [sshPublisherDesc(configName: 'docker_host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /home/dockeradmin
docker stop hello_app
docker rm hello_app
docker rmi -f myapp
docker build -t myapp:latest .
docker run -d -p 8090:8080 --name hello_app myapp:latest 
''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: 'webapp/target', sourceFiles: '**/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            
    }
    stage ("Snyk Test") {
        step([$class: 'SnykStepBuilder', additionalArguments: 'snyk test', snykInstallation: 'mysnyk', snykTokenId: 'snyk_token', targetFile: '/var/lib/jenkins/workspace/build_java_app/webapp/pom.xml'])
    }
}
