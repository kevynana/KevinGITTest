�*  
   
       �    ���  �       	  TRIGGER1     TRIGGER    action code             	   inline string  q   -SET &&HLPEXE = &&HLP_PATH || 'Travel Tracker.CHM';
DOS HH.EXE &&HLPEXE
-WINFORM MAIN ALTER WINDOW POPUP FALSE    run immediate     d  	  TRIGGER2     TRIGGER    action code             	   inline string  N   -WINFORM MAIN ALTER PWAIT SHOW TRUE

RUN SRV_STAT
-RUN

EX RESET
-RUN
    run immediate     d  	  TRIGGER3     TRIGGER    action code             	   inline string  k   -WINFORM MAIN ALTER PWAIT SHOW TRUE

-SET &&NOW_CYC = 'NOW';

RUN SETF_MNT
-RUN

EX RESTART
-RUN
    run immediate     d  	  TRIGGER4     TRIGGER    action code             	   inline string     EX HIER_UPD
-RUN
    run immediate     d  	  TRIGGER5     TRIGGER    action code             	   inline string  I  -WINFORM MAIN ALTER PWAIT SHOW TRUE

FILEDEF PARMPASS DISK &&PARMPASS
-RUN

RUN ROLL_ENV
-RUN

FILEDEF PARMPASS CLEAR
-RUN

FILEDEF PARMPASS DISK &&PARMPASS
-RUN

-READ PARMPASS &&ROLLUP.8
-RUN

-* Here we set the "control id" based entry in the local Control
-*  file, so that each user's session can be tied to different
-*  Rollups, and MAINTAIN routines will know the User ID
-*  making changes to the DB environment

TABLE FILE ROLLUP
ON TABLE SET PAGE-NUM OFF
PRINT  ROLLUP_CODE
IF ROLLUP_CODE EQ &&ROLLUP
ON TABLE NOTOTAL
ON TABLE HOLD
END
-RUN

CREATE FILE CONTROL
-RUN

MODIFY FILE CONTROL
FIXFORM ROLLUP_CODE/A8
COMPUTE CONTROL_ID/A3  =  &&USEID.EVAL;
MATCH CONTROL_ID
  ON MATCH UPDATE ROLLUP_CODE
  ON NOMATCH INCLUDE
DATA ON HOLD
END
-RUN

DEFINE FILE * CLEAR
-RUN

EX RESET
-RUN    run immediate     d  	  TRIGGER6     TRIGGER    action code             	   inline string     FIN    run immediate     d  	  TRIGGER7     TRIGGER    action code            @	   action string     SETFILP    run immediate     d  	  TRIGGER8     TRIGGER    action code             	   inline string     EX LOAD_IT2
-RUN    run immediate     d  	  TRIGGER9     TRIGGER    action code             	   inline string     EX LOAD_IT
-RUN
    run immediate     d    MENU ITEM1  
   MENU ITEM 	   label  	   Contents  	  Selected  	   TRIGGER1     MENU ITEM2  
   MENU ITEM 	   label     ServerQueue  	  Selected  	   TRIGGER2     MENU ITEM3  
   MENU ITEM 	   label  
   Set Files  	  Selected  	   TRIGGER3     MENU ITEM4  
   MENU ITEM 	   label  
   Hierarchy  	  Selected  	   TRIGGER4     MENU ITEM5  
   MENU ITEM 	   label     Company  	  Selected  	   TRIGGER5     MENU ITEM6  
   MENU ITEM 	   label     Exit  	  Selected  	   TRIGGER6     MENU ITEM7  
   MENU ITEM 	   label     Setfile Import  	  Selected  	   TRIGGER7     MENU ITEM8  
   MENU ITEM 	   label     Instance Tag  	  Selected  	   TRIGGER8     MENU ITEM9  
   MENU ITEM 	   label  
   Load Data  	  Selected  	   TRIGGER9     POPUP1     POPUP 	   label     Help    items     MENU ITEM1     POPUP2     POPUP 	   label     Edit    items     MENU ITEM5    MENU ITEM4    MENU ITEM3    MENU ITEM2     POPUP3     POPUP 	   label     File    items     MENU ITEM9    MENU ITEM8    MENU ITEM7    MENU ITEM6     AMPER VARIABLE1     AMPER VARIABLE 	   name     &PW   
  TRIGGER10     TRIGGER    action code             	   action string     RUN_SET 	   inline string     EX RUN_SET
    run immediate     d    AMPER VARIABLE2     AMPER VARIABLE 	   name     &RPTNAM   
  TRIGGER11     TRIGGER    action code             	   action string  	   RUN_INDV 	   inline string     EX RUN_INDV
-RUN
    run immediate     d    AMPER VARIABLE3     AMPER VARIABLE     AMPER VARIABLE4     AMPER VARIABLE 	   name     &RPTNAM   
  TRIGGER12     TRIGGER    action code             	   action string     UNDERCONST 	   inline string  0  FILEDEF INSTPASS DISK &&INSTPASS
-RUN

EX RPT_CYC
-RUN

-READ INSTPASS &&STREAM.8 &&IKEY.63
-IF &&IKEY EQ 'NONE' THEN GOTO XXIT;

-TYPE "INSTPASS NOT NONE"

-SET &&VARFILE = &&SYS_PATH || 'SETFILE.FEX';

FILEDEF OUTFILE DISK &&VARFILE
-RUN

EX VARSETS
-RUN

EX &&STREAM
-RUN

-XXIT    run immediate     d    AMPER VARIABLE5     AMPER VARIABLE   
  TRIGGER13     TRIGGER    action code            @	   action string     UNDERCONST    run immediate     d    AMPER VARIABLE6     AMPER VARIABLE   
  TRIGGER14     TRIGGER    action code             	   inline string  }   -WINFORM MAIN ALTER PWAIT SHOW TRUE

-TYPE Before initial RESET 
EX RESET
-RUN

-WINFORM MAIN ALTER PWAIT SHOW FALSE
    run immediate     d    MENU1     MENU    popups     POPUP3    POPUP2    POPUP1     PBTN1     PBTN 	   name     SETQ  	  location     "�7	   label  
   Set Queue    logfont  2   ��      �   "MS Sans Serif  �� 7q�� ��N'�    PBTN2     PBTN 	   name     SETNM  	  location     � E	   label  	   Set Name    logfont  2   ��      �   "MS Sans Serif   h ��$'�	 
  informbox     �'/     PBTN3     PBTN 	   name     RPTNM  	  location     � � D� 	   label     Report Name    logfont  2   ��      �   "MS Sans Serif ?   д�@   &��� �  	  TEXTBOX1     TEXTBOX 	   name     PWAIT  	  location     �Z �p  
  pen color     �      fill color     ���    justify     left d   logfont  2   ��      �    "MS Sans Serif �G�I �I !��!!��    source     from text d	   text     Please wait ...    amper     AMPER VARIABLE1     PBTN4     PBTN 	   name     RCYC_BT  	  location      � � � 	   label     Run Report Cycle    Clicked  
   TRIGGER10 	 
  informbox          FIELD1     FIELD 	   name     FIELD2  	  location     Y� S�    amper     AMPER VARIABLE2 	   label  	   Company:    frame         changed         upcase       	  password          PBTN5     PBTN 	   name     RSET_BT  	  location      � � � 	   label     Report Sets    Clicked  
   TRIGGER11     PICTUREBOX1     PICTUREBOX 	   name     PICTUREBOX2  	  location         {r   clipped     d   frame     d   amper     AMPER VARIABLE3 	 	  filename     SPLASH.BMP     FIELD2     FIELD 	   name     FIELD1  	  location     � o'   amper     AMPER VARIABLE4 	   label     Current Rollup    label logfont  2   ��      �    "Arial  g>    g>���  J8�D    field logfont  2   ��      �    "Arial  g>    g>���  J8�D    frame         changed         upcase       	  password        	  TEXTBOX2     TEXTBOX 	   name  
   TEXTBOX14  	  location     E,�G 
  pen color     � @    justify     left d   source     from text d	   text     > Report Cycle    amper     AMPER VARIABLE5    Clicked  
   TRIGGER12   	  TEXTBOX3     TEXTBOX 	   name  
   TEXTBOX13  	  location     � ,6C 
  pen color     � @    justify     left d   logfont  2   ��      �    "Arial  �:    �:���  J8�p    source     from text d	   text     > Update Cycle    amper     AMPER VARIABLE6    Clicked  
   TRIGGER13   	  DISPLAY1     DISPLAY    wait         delay changes         items  	   TEXTBOX3 	   TEXTBOX2    FIELD2    PICTUREBOX1    PBTN5    FIELD1    PBTN4 	   TEXTBOX1    PBTN3    PBTN2    PBTN1    menubar     MENU1    bkcolor     ���    On Open  
   TRIGGER14     WINDOW1     WINDOW 	   name     MAIN  	  location     ] H ��   style  
   moveable d
   sizeable d   closeable  	   title     Travel Tracker    visible     d   output  	   DISPLAY1    visible OK button     d	 	  filename  	   TNT_TRAK    trigger first       	  minimize     d           AMPER VARIABLE7     AMPER VARIABLE   
  TRIGGER15     TRIGGER    action code           @   run immediate     d    AMPER VARIABLE8     AMPER VARIABLE   	  TEXTBOX4     TEXTBOX 	   name  
   TEXTBOX19  	  location     �  o    justify     left d   logfont  2   ��      �    "Arial  �:    �:���  J8/H    source     from text d	   text  ?   Sorry, this function is still under development / construction    amper     AMPER VARIABLE7     PBTN6     PBTN 	   name     PBTN1  	  location     n x � � 	   label     OK    Clicked  
   TRIGGER15     PICTUREBOX2     PICTUREBOX 	   name     PICTUREBOX1  	  location      ( � d    clipped     d   frame         amper     AMPER VARIABLE8 	 	  filename     C:\WINDOWS\BUBBLES.BMP   	  DISPLAY2     DISPLAY    wait         delay changes         items     PICTUREBOX2    PBTN6 	   TEXTBOX4     WINDOW2     WINDOW 	   name     UNDERCONST  	  location     � � �L   style  
   moveable  
   sizeable     closeable  	   title     Under Construction    visible     d   output  	   DISPLAY2    visible OK button     d	 	  filename  	   TNT_TRAK    trigger first       	  minimize      �  �         AMPER VARIABLE9     AMPER VARIABLE   
  TRIGGER16     TRIGGER    action code             	   inline string     EX LOADSET
-RUN
    run immediate     d    AMPER VARIABLE10     AMPER VARIABLE 	   name  	   &SETPATH   	  TEXTBOX5     TEXTBOX 	   name  	   TEXTBOX5  	  location     � 
 �F  
  pen color            fill color     ���    justify     left d   source     from text d	   text  L   Enter the full path of the Rollup Setfiles
             (e.g. C:\TNTTEMP\)    amper     AMPER VARIABLE9     PBTN7     PBTN 	   name     PBTN7  	  location     �� �� 	   label     OK    Clicked  
   TRIGGER16     FIELD3     FIELD 	   name     SETPATH  	  location     < Z �o    amper     AMPER VARIABLE10 	   label     Path    label bkcolor     ���    frame         changed         upcase       	  password        	  DISPLAY3     DISPLAY    wait         delay changes         items     FIELD3    PBTN7 	   TEXTBOX5    bkcolor     ���     WINDOW3     WINDOW 	   name     SETFILP  	  location     � � �   style  
   moveable d
   sizeable     closeable  	   title     Set File Import Path    visible     d   output  	   DISPLAY3    visible OK button     d	 	  filename  	   TNT_TRAK    trigger first       	  minimize      3   3          `      
 _       y  MAINUNDERCONSTSETFILP         �  %  �*  