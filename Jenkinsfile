pipeline {
    agent any

    tools {
        maven 'Maven-3.8.5' // Nombre del Maven configurado en Jenkins
        jdk 'Java17'   // Nombre del JDK configurado en Jenkins
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Clonando el repositorio...'
                git branch: 'main', url: 'https://github.com/JorgeMartinezSanchez/Jenkins_qa_II.git'
            }
        }

        stage('Build & Test') {
            steps {
                echo 'Ejecutando pruebas Karate...'
                bat 'mvn test -Dkarate.options="--tags @Smock"'
            }
        }

        stage('Publicar Reporte') {
            steps {
                echo 'Publicando reporte HTML de Karate...'
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'target/karate-reports',
                    reportFiles: 'karate-summary.html',
                    reportName: 'Reporte de Pruebas Karate'
                ])
            }
        }
    }

    post {
        always {
            echo 'Pipeline finalizado — limpiando workspace.'
            cleanWs()
        }
        success {
            echo 'Pruebas Karate ejecutadas con éxito.'
        }
        failure {
            echo 'Falló alguna etapa del pipeline.'
        }
    }
}