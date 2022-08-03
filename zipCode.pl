pipeline {
   agent any
     stages { 
        stage ('verify perl') {
           step {
            sh 'perl --version'
            }
         }
       }
}
