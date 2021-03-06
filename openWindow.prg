OpenWindow("D:\DESARROLLO\MigDBFtoMySQL\migdbftomysql.exe", "Versi�n beta v102", _screen)
FUNCTION OpenWindow(tcEXE AS STRING, tcTitle AS STRING, toForm AS object)
	IF !FILE(SUBSTR(tcEXE, 1, AT(".EXE", UPPER(tcEXE),1) + 4))
		WAIT "La ruta o el nombre del archivo no son v�lidos!" WINDOW NOWAIT
		RETURN .F.
	ENDIF
	LOCAL nHwnd AS INTEGER
	nHwnd = 0

	DECLARE INTEGER WinExec		IN kernel32 STRING  lpCmdLine,		INTEGER nCmdShow
	DECLARE INTEGER FindWindow	IN user32   STRING  lpClassName,	STRING  lpWindowName
	DECLARE INTEGER SetParent	IN user32   INTEGER hWndChild,		INTEGER hWndNewParent


	DO WHILE .T.
		=WinExec(tcEXE, 1)
		nHwnd = FindWindow(NULL, tcTitle)
		nSec  = SECONDS() + 5
		DO WHILE EMPTY(nHwnd) AND SECONDS() < nSec
			WAIT "Esperando por el archivo ejecutable..." WINDOW NOWAIT
			IF nHwnd > 0
				EXIT
			ENDIF
		ENDDO
		IF EMPTY(nHwnd)
			IF MESSAGEBOX("Parece que el archivo ejecutable no ha cargado correctamente.",5 + 32, "Aviso") = 2
				EXIT
			ENDIF
		ELSE
			EXIT
		ENDIF
	ENDDO
	IF nHwnd > 0
		SetParent(nHwnd,toForm.HWND)
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ENDFUNC