pipeline {
    agent any

    tools {
        maven 'Maven-3.8.5'
        jdk 'Java17'
    }

    stages {
        // Eliminamos la etapa de Checkout porque Jenkins ya lo hace por defecto.

        stage('Build & Test') {
            steps {
                echo 'Ejecutando pruebas Karate...'
                // Nota: Verifica si es @Smoke o @Smock. Si no usas tags, solo pon 'mvn test'
                sh 'mvn clean test -f myproject/pom.xml'
            }
        }

        stage('Publicar Reporte') {
            steps {
                echo 'Publicando reporte HTML de Karate...'
                // Este paso requiere que el plugin "HTML Publisher" esté instalado en Jenkins.
                publishHTML(target: [
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
        // Quitamos cleanWs() de aquí para no borrar los reportes que acabamos de generar.
        // Jenkins guarda los reportes en su propio espacio de trabajo seguro.
        success {
            echo 'Pruebas Karate ejecutadas con éxito.'
        }
        failure {
            echo 'Falló alguna etapa del pipeline.'
        }
        always {
            echo 'Pipeline finalizado.'
        }
    }
}