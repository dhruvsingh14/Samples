*Run frequency tables and bar charts on 3 variables. 

frequencies educ marit jtype 
/barchart 
/order variable.

*Show only value labels and variable labels in output 

* tvars is short for table variables

* tnumbers is short for table numbers

set 
tnumbers labels 
tvars labels.

* good for formatting tables

set tlook 'C:\Program Files\IBM\SPSS\Statistics\20\Looks\Report.stt'.

* now, applying formats to charts

set ctemplate 'C:\Program Files\IBM\SPSS\Statistics\20\Looks\APA_Styles.sgt'.



* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=ALL  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /DOC  DOCUMENTFILE=
    'C:\Dhruv\Week2_Nov4\data_training\SPSS\SPSS_Beginners_Tutorials\Introduction_to_SPSS\04_SPSS_Out'+
    'put–Basics,Tips&Tricks\word_report.doc'
     NOTESCAPTIONS=YES  WIDETABLES=WRAP
     PAGESIZE=INCHES(8.5, 11.0)  TOPMARGIN=INCHES(1.0)  BOTTOMMARGIN=INCHES(1.0)
     LEFTMARGIN=INCHES(1.0)  RIGHTMARGIN=INCHES(1.0).
