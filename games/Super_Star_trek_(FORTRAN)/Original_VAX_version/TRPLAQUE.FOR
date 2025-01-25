      SUBROUTINE PLAQUE 
C
C	30-MAY-79
C	OUTPUT DATE WITH LOWER-CASE CHARACTERS
C	31-MAY-79
C	DON'T RE-OPEN OUTPUT IF LUN=2 ON ENTRY
C
	INCLUDE 'TREKCOM/NOLIST'
      COMMON/PLAQ/ISCORE,PERDATE,ISKILL 
	LOGICAL*1 NAME(30)
	COMMON/SCANBF/KEY,AITEM
	COMMON/PRLUN/LUN
	LUNSAV=LUN
	LUN=1
11	CALL PROMPT('ENTER NAME (UP TO 30 CHARACTERS): ',34)
	LUN=LUNSAV
	READ(1,20,ERR=11,END=11) ICHAR,NAME
20	FORMAT(Q,30A1)
	NSKIP=65-ICHAR/2
	IF(LUN.EQ.2)GO TO 25
	LUN=2
	CALL CLOSE(2)
	CALL ASSIGN(2,'LP:')
25	WRITE(2,30)
30	FORMAT('1')
	CALL SKIP(4)
C--------DRAW ENTERPRISE PICTURE. 
	CALL PROUT(114H                                                  
     +              EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE, 
     +114) 
      CALL PROUT (114H                                      EEE         
     +             E  : :                                         :  E, 
     +114) 
      CALL PROUT (114H                                    EE   EEE      
     +             E  : :                   NCC-1701              :  E, 
     +114) 
      CALL PROUT (113H                    EEEEEEEEEEEEEEEE        EEEEEE 
     +EEEEEEEEE    E  : :                                         : E,
     +114) 
      CALL PROUT (112H                     E                            
     +         E    EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	1 ,114)
      CALL PROUT (81H                      EEEEEEEEE               EEEEE
     +EEEEEEEE                 E  E ,81) 
      CALL PROUT (81H                               EEEEEEE   EEEEE    E
     +          E              E  E ,81) 
      CALL PROUT (81H                                      EEE          
     + E          E            E  E ,81) 
      CALL PROUT (81H                                                   
     +    E         E          E  E ,81) 
      CALL PROUT (81H                                                   
     +      EEEEEEEEEEEEE      E  E ,81) 
      CALL PROUT (87H                                                   
     +   EEE :           EEEEEEE  EEEEEEEE,87) 
      CALL PROUT (88H                                                   
     + :E    :                 EEEE       E,88)
      CALL PROUT (88H                                                   
     +.-E   -:-----                       E,88)
      CALL PROUT (88H                                                   
     + :E    :                            E,88)
      CALL PROUT (87H                                                   
     +   EE  :                    EEEEEEEE,87) 
      CALL PROUT (81H                                                  
     +     EEEEEEEEEEEEEEEEEEEEEEE   ,81)
      CALL SKIP(3)
      CALL PROUT(74H                                                    
     +   U. S. S. ENTERPRISE,74) 
 5    CALL SKIP(1)
      CALL SKIP(3)
      CALL PROUT(93H                                  For demonstrating 
     +outstanding ability as a starship captain,93) 
      CALL SKIP(1)
      CALL PROUT(81H                                                Star      
     +fleet Command bestows to you ,81)
      CALL SKIP(1)
      DO 8 I=1,NSKIP
 8    CALL CRAM(1H )
	CALL CRAMS(NAME,ICHAR)
      CALL CREND
      CALL SKIP(1)
      CALL PROUT(71H                                                    
     +       the rank of ,71)   
	CALL SKIP(1)
      CALL PROUT(75H                                                    
     +   "Commodore Emeritus",75) 
	CALL SKIP(1)
      CALL CRAM(58H                     
     +                                     )
      IF(ISKILL .EQ. 4) CALL CRAM(8H Expert ) 
      IF(ISKILL .EQ. 5) CALL CRAM(9HEmeritus )
      CALL CRAMDMP(5Hlevel)
	CALL SKIP(1)
      CALL CRAM(66H                                                     
	1 This day of )
	CALL FOR$DATE(NAME)
	NAME(5)=NAME(5)+32
	NAME(6)=NAME(6)+32
	CALL CRAMS(NAME,9)
	CALL CREND
      CALL SKIP(1)
      CALL CRAM(69H                                                     
	1   Your score:  )
	CALL CRAMI(ISCORE,0)
	CALL CREND
      CALL SKIP(1)
      CALL CRAM(76H                                                    
	1Klingons per stardate:   )
	CALL CRAMF(PERDATE,0,2)
	CALL CREND
      RETURN      
      END 
