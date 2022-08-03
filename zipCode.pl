pipeline {
   agent any
     stages { 
        stage ('verify perl') {
           steps {
            sh 'perl --version'
            }
         }
       }
}
