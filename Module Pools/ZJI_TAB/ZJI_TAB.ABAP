*&---------------------------------------------------------------------*
*& Report ZJI_TAB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zji_tab.
CONTROLS TS1 TYPE TABSTRIP.
DATA SO TYPE CHAR10.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA okcode_100 TYPE sy-ucomm.
  IF okcode_100 = 'FCT_EXIT'.
    LEAVE PROGRAM.
  ELSEIF okcode_100 = 'FCT_T1'.
    TS1-activetab = 'FCT_T1'.
  ELSEIF  okcode_100 =  'FCT_T2'.
    TS1-activetab = 'FCT_T2'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0060 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0060 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  TABLES: VBAP.

  SELECT SINGLE * FROM VBAP WHERE VBELN = SO.

ENDMODULE.

*&SPWIZARD: FUNCTION CODES FOR TABSTRIP 'TS2'
CONSTANTS: BEGIN OF C_TS2,
             TAB1 LIKE SY-UCOMM VALUE 'TS2_FC1',
             TAB2 LIKE SY-UCOMM VALUE 'TS2_FC2',
             TAB3 LIKE SY-UCOMM VALUE 'TS2_FC3',
           END OF C_TS2.
*&SPWIZARD: DATA FOR TABSTRIP 'TS2'
CONTROLS:  TS2 TYPE TABSTRIP.
DATA:      BEGIN OF G_TS2,
             SUBSCREEN   LIKE SY-DYNNR,
             PROG        LIKE SY-REPID VALUE 'ZJI_TAB',
             PRESSED_TAB LIKE SY-UCOMM VALUE C_TS2-TAB1,
           END OF G_TS2.


*&SPWIZARD: OUTPUT MODULE FOR TS 'TS2'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: SETS ACTIVE TAB
MODULE TS2_ACTIVE_TAB_SET OUTPUT.
  TS2-ACTIVETAB = G_TS2-PRESSED_TAB.
  CASE G_TS2-PRESSED_TAB.
    WHEN C_TS2-TAB1.
      G_TS2-SUBSCREEN = '0070'.
    WHEN C_TS2-TAB2.
      G_TS2-SUBSCREEN = '0080'.
    WHEN C_TS2-TAB3.
      G_TS2-SUBSCREEN = '0090'.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TS 'TS2'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: GETS ACTIVE TAB
MODULE TS2_ACTIVE_TAB_GET INPUT.
  OKCODE_100 = SY-UCOMM.
  CASE OKCODE_100.
    WHEN C_TS2-TAB1.
      G_TS2-PRESSED_TAB = C_TS2-TAB1.
    WHEN C_TS2-TAB2.
      G_TS2-PRESSED_TAB = C_TS2-TAB2.
    WHEN C_TS2-TAB3.
      G_TS2-PRESSED_TAB = C_TS2-TAB3.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.
