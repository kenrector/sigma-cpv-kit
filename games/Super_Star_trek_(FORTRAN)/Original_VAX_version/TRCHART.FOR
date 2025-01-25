      SUBROUTINE CHART
	INCLUDE 'TREKCOM/NOLIST'
      CALL PROUT(31HSTAR CHART FOR THE KNOWN GALAXY,31)
      CALL SKIP(1)
      CALL PROUT(42H      1    2    3    4    5    6    7    8,42) 
      CALL PROUT(44H    ----------------------------------------,44) 
      CALL PROUT(3H  :,3) 
      DO 50 I=1,8 
      CALL CRAMI(I,1) 
      CALL CRAM(2H :) 
      DO 40 J=1,8 
      IF(STARCH(I,J)) 10,20,30
 10   CALL CRAM(5H  .1.)
      GO TO 40
 20   CALL CRAM(5H  ...)
      GO TO 40
 30   IF(STARCH(I,J) .GT. 999) GO TO 35 
      CALL CRAMI(GALAXY(I,J),5) 
      GO TO 40
 35   CALL CRAMI(STARCH(I,J)-1000,5)
 40   CONTINUE
      CALL CREND
      CALL PROUT(3H  :,3) 
 50   CONTINUE
      CALL SKIP(1)
      CALL CRAMSHP
      CALL CRAM(16H IS CURRENTLY IN)
      CALL CRAMLOC(1,QUADX,QUADY) 
      CALL CREND
      RETURN
      END 
