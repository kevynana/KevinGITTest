@echo off
PATH .;d:\ibi\webfocus43\ibi_html\javaassist\jre1.2.2i\bin
set CLASSPATH=.;d:\ibi\webfocus43\javamail\activation.jar;d:\ibi\webfocus43\javamail\mail.jar;d:\ibi\webfocus43\javamail\smtp.jar;d:\ibi\webfocus43\javamail\
 
rem Syntax is: java sendfile <ToEmailAddress> <FromEmailAddress> <SMTPmailServer> <FileAttachment> <Subject> <LetterBody>

java sendfile "%1" ttreports@tandt.com omamail01.tandt.com "%2" false "eTTek Review Report Creation Failed!!" "See the attached file for details..."
