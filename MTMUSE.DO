10 'Two-Voice Music on Tandy Model T
20 'v20131122
30 '***** Setup *****
40 MAXFILES = 2
50 CLS
60 PRINT "Two-Voice Music on Tandy Model Ts"
70 PRINT "Written by Christopher Fox, 2013"
80 PRINT
90 INPUT "Is this (c)lient or (s)erver";CS$
100 IF CS$="s" THEN GOTO 200 ELSE IF CS$="c" THEN GOTO 1000
200 '***** Server *****
210 CLS
220 PRINT "Music Server"
230 PRINT
240 INPUT "Song filename";SO$
250 INPUT "Tempo";TE%
260 PRINT "Press any key to import and transfer."
270 PRINT "Be sure client is ready to receive."
280 IF INKEY$="" THEN GOTO 280
290 OPEN "RAM:"+SO$ FOR INPUT AS 1
300 OPEN "COM:98N1EIN" FOR OUTPUT AS 2
310 LINE INPUT #1, LN$
320 IF LN$<>"ss" THEN PRINT "This is not a song file!":END
330 PRINT "Transferring data to client..."
340 PRINT #2,SO$
350 PRINT #2,TE%
360 LINE INPUT #1, LN$
370 PRINT ".";:PRINT #2, LN$
380 IF LN$<>"es" THEN GOTO 360
390 PRINT:PRINT "Transfer of client data complete."
400 PRINT "Loading local array store..."
410 LINE INPUT #1, NC$
420 DIM N%(VAL(NC$)),D%(VAL(NC$))
430 LI%=0
440 IF EOF(1) THEN GOTO 510
450 LINE INPUT #1, LN$
460 PRINT ".";
470 N%(LI%)=VAL(LEFT$(LN$,INSTR(LN$,",")))
480 D%(LI%)=FIX(TE%*VAL(RIGHT$(LN$,(LEN(LN$)-INSTR(LN$,",")))))
490 LI%=LI%+1
500 GOTO 440
510 PRINT:PRINT "Complete."
520 PRINT "Press any key to begin playback."
530 IF INKEY$="" THEN GOTO 530 ELSE PRINT #2, "***"
540 FOR I = 0 TO LI%
550 SOUND N%(I),D%(I)
560 NEXT I
570 PRINT "Playback completed."
580 CLEAR
590 END
1000 '***** Client *****
1010 CLS
1020 PRINT "Music Client"
1030 PRINT
1040 PRINT "Press any key when ready to receive."
1050 IF INKEY$="" THEN GOTO 1050
1060 PRINT "Receiving data from server..."
1065 OPEN "COM:98N1EIN" FOR INPUT AS 1
1070 LINE INPUT #1, SO$:PRINT "Song title: ";SO$
1080 LINE INPUT #1, TE$:TE%=VAL(TE$):PRINT "Tempo: ";TE%
1090 PRINT "Loading local array store..."
1100 LINE INPUT #1, NC$
1110 DIM N%(VAL(NC$)),D%(VAL(NC$))
1120 LI%=0
1130 LINE INPUT #1, LN$
1140 IF LN$="es" THEN GOTO 1200
1150 PRINT ".";
1160 N%(LI%)=VAL(LEFT$(LN$,INSTR(LN$,",")))
1170 D%(LI%)=FIX(TE%*VAL(RIGHT$(LN$,(LEN(LN$)-INSTR(LN$,",")))))
1180 LI%=LI%+1
1190 GOTO 1130
1200 PRINT:PRINT "COMPLETE"
1300 PRINT "Waiting for playback signal..."
1310 LINE INPUT #1, LN$
1320 IF LN$<>"***" THEN GOTO 1310
1330 FOR I = 0 TO LI%
1340 SOUND N%(I),D%(I)
1350 NEXT I
1360 PRINT "Playback completed."
1370 END
