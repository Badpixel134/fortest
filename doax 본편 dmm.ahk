RunAsAdmin()
#Include Gdip_all.ahk
SetWorkingDir %A_ScriptDir%





Gui, Color, White, White
Gui Add, Text, x256 y16 w140 h20 +Center, DOAX-VV (DMM) Auto
Gui Add, Text, x232 y48 w190 h30 +Center vA, 준비
Gui Add, Text, x304 y88 w50 h20 +Center vB, 0 회
Gui Add, Button, x200 y128 w120 h30, 시작
Gui Add, Button, x336 y128 w120 h30, 종료
Gui Add, DropDownList, x472 y32 w220 vDDL Choose1 AltSubmit, Empty|final|semi-final|6|5|1|SS+|경쟁전|20fp|맨아래|맨위|
Gui Add, DropDownList, x472 y64 w220 vDDL2 Choose1 AltSubmit, 일반|피버 1회|피버 2회|
Gui Add, DropDownList, x472 y96 w220 vDDL5 Choose1 AltSubmit, 이벤트 진입 및 맨 위 챕터 자동선택|수동|
Gui Add, Text, x16 y16 w165 h30 +Center, (필수) 플레이 할 횟수
Gui Add, Edit, x56 y48 w90 h20 vPC Number, 10
Gui Add, Edit, x56 y120 w90 h20 vOffset Number, 0
Gui Add, Text, x16 y88 +Center, 맨위, 맨아래 y축 오프셋 설정
Gui Add, Link, x528 y152 w119 h12 , <a href="https://github.com/Badpixel134/vv-auto">Github repository link</a>
Gui Add, Text, x16 y160 +Center, 피버 도달 스킵 횟수 오프셋`n(입력값 +2까지 랜덤)
Gui Add, Text, x16 y220 w160 +Center, FP 회복 횟수 설정
Gui Add, Edit, x56 y240 w92 h21 vDrink Number, 0
Gui Add, Edit, x56 y190 w92 h21 vFoffset Number, 4
Gui Add, CheckBox, x200 y202 vError_Enable, 에러 검출 시`n
Gui Add, CheckBox, x296 y202 vCAPTCHA_Enable, 캡챠 검출 시`n
Gui Add, CheckBox, x400 y202 vPLAYTIME_Enable, 지정된 만큼 플레이되고나서`n(플레이 횟수 및 FP 회복)
Gui Add, CheckBox, x248 y234 vGame_Shutdown, 게임 종료`n
Gui Add, CheckBox, x352 y234 vSystem_shutdown, 시스템 종료`n
Gui Add, GroupBox, x185 y180 w393 h75, 게임 / 시스템 자동 종료 옵션
Gui Add, GroupBox, x464 y8 w232 h118, 페스 조건 및 옵션
Gui Add, CheckBox, x620 y200 vC_fes_S, S
Gui Add, CheckBox, x620 y220 vC_fes_SS, SS
Gui Add, CheckBox, x620 y240 vC_fes_SSS, SSS
Gui Add, GroupBox, x590 y180 w105 h75, 경쟁전 랭크 탐색
/*
if Error_Enable=1
{
if Game_Shutdown=1
{
Game_shutdown()
}
if System_Shutdown=1
{
System_shutdown()
}
}

if CAPTCHA_Enable=1
{
if Game_Shutdown=1
{
Game_shutdown()
}
if System_Shutdown=1
{
System_shutdown()
}
}

if PLAYTIME_Enable=1
{
if Game_Shutdown=1
{
Game_shutdown()
}
if System_Shutdown=1
{
System_shutdown()
}
}
*/

클리어횟수 := 0

Gui, Show, w700 h270, DOAX-VV (DMM)
Return


Button시작:
{
 FormatTime, CurrentDateTime,, yyyy-MM-dd HH-mm

	
	
	Gui,Submit,nohide
	GuiControl,,A,시작
	매크로시작 := true
	Cur_drink = 0
	p = 0
	Loop
	{
	Drink := Drink*1
	Offset := Offset*1
	Foffset := Foffset*1
	i = 0
	load = 0
	x = 1
	t = 0
	q = 40
	카운트 := 0
	w = 1
	Sleep,1000
	c=0														; 페스 후 마우스 연타 검출 횟수
	z=0														; 페스 중 피버를 위한 라운드 스킵할때, 스킵 버튼 검출 횟수
	fes_check=0												; 페스 시작 전 페스 검출 횟수
	GuiControl,,A,test
	log_dir = log\%CurrentDateTime% log.txt
	FileCreateDir, log
	FileCreateDir, screenshot
	timeRecord("VV auto 시작.")
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
	captcha=0


if (p>=PC)
{
	GuiControl,,A,END OF PLAY plz restart
	
	if PLAYTIME_Enable=1
	{
	if Game_Shutdown=1
	{
	timeRecord("설정에 의하여 지정된만큼 플레이 후 게임 종료.")
	Game_shutdown()
	}
	if System_Shutdown=1
	{
	timeRecord("설정에 의하여 지정된만큼 플레이 후 시스템 종료.")
	System_shutdown()
	}
	}
	
	Msgbox, !입력된 횟수만큼 플레이 됨! (재시작 요망)`n`nPress F2 to exit`nPress F3 to restart
	timeRecord("지정된 횟수만큼 플레이 됨")
	
}
	
/*
************************************************************************************************

########  ######## ########  #######  ########  ########    ######## ########  ######  
##     ## ##       ##       ##     ## ##     ## ##          ##       ##       ##    ## 
##     ## ##       ##       ##     ## ##     ## ##          ##       ##       ##       
########  ######   ######   ##     ## ########  ######      ######   ######    ######  
##     ## ##       ##       ##     ## ##   ##   ##          ##       ##             ## 
##     ## ##       ##       ##     ## ##    ##  ##          ##       ##       ##    ## 
########  ######## ##        #######  ##     ## ########    ##       ########  ######  

************************************************************************************************
*/	
WinActivate DOAX VenusVacation


if DDL=8
{
if (C_fes_S==0 AND C_fes_SS==0 AND C_fes_SSS==0)
{
msgbox, !경쟁전 탐색 옵션을 지정해주세요!`n(우측 하단)`nS에서 SS, SSS 순으로 탐색 됨.
}
}
	while i<x
	{
	GuiControl,,A,이벤트창 탐색

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\notify.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,이벤트창 클릭
				Random,Ran,1,10
				Random,Ran2,1,10
				MouseClick, Left, 1828+Ran, 85+Ran2,1
				timeRecord("이벤트 확인.")
			}
			

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes_menu.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
			Random,Ran,60,0
			Random,Ran2,10,20
			MouseClick, Left, eeX+Ran, eeY+Ran2,1
			Sleep,10600+Ran3
			}
			
			
fes_check++

if DDL5=1
{
GuiControl,,A,챕터 시작
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\chapter.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,챕터 발견
			f=1
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+10+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,1600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			}
}			
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\event fes.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,이벤트 페스 발견
				Random,Ran3,0,400
			Sleep,1600+Ran3
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran+20, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,1800+Ran3
			
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			
			
			
			
GuiControl,,A,이벤트 페스 시작
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-e.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,이벤트 페스 발견
				Random,Ran3,0,400
			Sleep,1600+Ran3
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			}
			
GuiControl,,A,이벤트 페스 확인

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\event.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,이벤트 발견
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			}
			}
			
			
			
			GuiControl,,A,챕터
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\chapter-ss.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,챕터
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,1600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			}
			
if f=1
{
ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-e.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			f=0
			}
}
			
			
GuiControl,,A,페스 시작
if DDL=1
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-e.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,-10,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
			}
if DDL=2
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-f.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,-200,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
			}
if DDL=3
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-s-f.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
			}
if DDL=4
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-6.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,-200,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
			}
if DDL=5
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-5.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,-200,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
			}
if DDL=6
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-1.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,-200,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
			}
if DDL=7
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-ss+.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,15
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
}
			
if DDL=8
{
	if C_fes_S=1
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-s.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("S랭크 경쟁전 탐색 완료")

			}
	}
	if C_fes_SS=1
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-ssm.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SS-랭크 경쟁전 탐색 완료")
			}
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-ss.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SS랭크 경쟁전 탐색 완료")
			}
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-ssp.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SS+랭크 경쟁전 탐색 완료")
			}
	}
	if C_fes_SSS=1
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-sss.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SSS랭크 경쟁전 탐색 완료")
			}
	}
}		
		if DDL=9
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\20fp.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 발견
			Random,Ran,-200,15
				Random,Ran2,-30,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1

			}
}	
if DDL=10
{
GuiControl,,A,맨 위 페스
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes_menu.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
			Random,Ran,60,0
			Random,Ran2,10,20
			MouseClick, Left, eeX+Ran, eeY+Ran2,1
			Sleep,10600+Ran3
			}
			else
			{
			Random,Ran,-50,200
			Random,Ran2,-5,15
			MouseClick, Left, 1445+Ran+Offset, 935+Ran2+Offset,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			}
			
			Random,Ran2,1,15
			Random,Ran1,1,30
			MouseMove, 10+ran2, 10+ran1
}	

if DDL=11
{
GuiControl,,A,맨 아래 페스
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes_menu.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
			Random,Ran,60,0
			Random,Ran2,10,20
			MouseClick, Left, eeX+Ran, eeY+Ran2,1
			Sleep,10600+Ran3
			}
			else
			{
			Random,Ran,-50,200
			Random,Ran2,1,50
			MouseClick, Left, 1445+Ran+Offset, 510+Ran2+Offset,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			}
			
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
}	


if fes_check=30
{
GuiControl,,A,페스티벌 확인 오류
timeRecord("페스티벌 확인 실패 횟수가 20회를 넘었습니다.")
Screenshot(FES NOT FOUND)
	if Error_Enable=1
	{
	if Game_Shutdown=1
	{
	timeRecord("설정에 의하여 오류 검출 후 게임 종료.")
	Game_shutdown()
	}
	if System_Shutdown=1
	{
	timeRecord("설정에 의하여 오류 검출 후 시스템 종료.")
	System_shutdown()
	}
	}
	Sleep,300000
	Msgbox, !페스티벌 확인 실패 횟수가 20회를 넘었습니다! (재시작 요망)`n`nPress F2 to exit`nPress F3 to restart
}

if DDL5=1
{
GuiControl,,A,챕터 최상단
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\chapter-opened.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,챕터
			Random,Ran,1,15
				Random,Ran2,1,40
				MouseClick, Left, 1446+Ran, 560+Ran2,1
				Random,Ran3,0,400
			Sleep,1600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			}
			
}
GuiControl,,A,페스 시작 버튼 탐색
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\start.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 시작 버튼 탐색 완료
			Random,Ran,1,20
				Random,Ran2,1,20
				MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
				Random,Ran3,0,400
			Random,Ran2,1,15
			Random,Ran1,1,15
			timeRecord("페스 시작 버튼 탐색 됨.")
			Sleep,3000+Ran3
			MouseMove, 10+ran2, 10+ran1
			}
GuiControl,,A,페스 오류 탐색
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\ERROR.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 에러

			timeRecord("프로그램 오류 또는 캡챠 이미지에 의한 종료.")

				Random,Ran3,0,400
			Sleep,200+Ran3
						ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\cancel.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
				if((ErrorLevel = 0))
				{
					Random,Ran,1,20
					Random,Ran2,1,20
					MouseClick, Left, eeX+1+Ran, eeY+1+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3
					
					Screenshot(CAPTCHA)
					
					if CAPTCHA_Enable=1
					{
						if Game_Shutdown=1
						{
			timeRecord("설정에 의하여 캡챠 검출 후 게임 종료.")
						Game_shutdown()
						}
						if System_Shutdown=1
						{
			timeRecord("설정에 의하여 캡챠 검출 후 시스템 종료.")
						System_shutdown()
						}
					}
				}
			Msgbox, !캡챠 검출 됨! (재시작 요망)`n`nPress F2 to exit`nPress F3 to restart
			Sleep,8000000000
			
			
			}
			
ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\fp_confirm.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
				if((ErrorLevel = 0))
				{
GuiControl,,A,캡챠 확인 2
					captcha++
				}

ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\cancel.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
				if((ErrorLevel = 0))
				{
GuiControl,,A,캡챠 확인 3
					captcha++
				}
				
if captcha=3
{
	Screenshot(CAPTCHA)
					
		if CAPTCHA_Enable=1
		{
			if Game_Shutdown=1
			{
			timeRecord("설정에 의하여 캡챠 검출 후 게임 종료.")
			Game_shutdown()
			}
			if System_Shutdown=1
			{
			timeRecord("설정에 의하여 캡챠 검출 후 시스템 종료.")
			System_shutdown()
			}
			}
}

WinActivate DOAX VenusVacation
GuiControl,,A,FP 탐색
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\FP.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
				timeRecord("FP 부족 확인.")
			
					if (Cur_drink>=drink)
					{
						timeRecord("FP 회복 횟수가 지정된 만큼 실시되었습니다.")
						
							GuiControl,,A,END OF PLAY plz restart
	
							if PLAYTIME_Enable=1
							{
								if Game_Shutdown=1
								{
								timeRecord("설정에 의하여 지정된만큼 플레이 후 게임 종료.")
								Game_shutdown()
								}
								if System_Shutdown=1
								{
								timeRecord("설정에 의하여 지정된만큼 플레이 후 시스템 종료.")
								System_shutdown()
								}
							}
	
								Msgbox, !입력된 FP 회복 횟수만큼 플레이 됨! (재시작 요망)`n`nPress F2 to exit`nPress F3 to restart
					}
					
GuiControl,,A,FP 부족
					Random,Ran3,0,400
					Sleep,200+Ran3
					Random,Ran,1,10
					Random,Ran2,1,10
					MouseClick, Left, eeX+140+Ran, eeY+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3


		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\Steam\FP2.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,FP 부족
					Random,Ran3,0,400
					Sleep,200+Ran3
					Random,Ran,1,10
					Random,Ran2,1,10
					Random,Ran3,0,400
					Sleep,600+Ran3
			}
			

			ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\fp_confirm.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
				if((ErrorLevel = 0))
				{
GuiControl,,A,FP 충전
					Random,Ran,1,20
					Random,Ran2,1,20
					MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3
					
					Cur_drink := Cur_drink*1+1
					
					timeRecord_FPrecover(drink)
					timeRecord_Cur_FPrecover(Cur_drink)
					
								
			ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\fp_confirm.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
				if((ErrorLevel = 0))
				{
GuiControl,,A,FP 충전 확인 *double check
					Random,Ran,1,20
					Random,Ran2,1,20
					MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3
					
					ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\start.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
						if((ErrorLevel = 0))
						{
GuiControl,,A,FP 충전 후 페스 시작
							Random,Ran,1,20
							Random,Ran2,1,20
							MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
					Random,Ran3,0,400
					Sleep,400+Ran3
					timeRecord("FP 충전 후 페스 시작")
						}
				}
			}
		}
		
		load=0
while load<1
{	
GuiControl,,A,로딩 탐색	
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\loading.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,로딩 발견
			i++
			timeRecord("페스 시작 로딩 검출됨.")
			if ddl4=1
			Random,Ran3,0,400
			sleep,1000+Ran3
			}
			else
			{
			load=1
			}
}
}
			
			

WinActivate DOAX VenusVacation

/*
************************************************************************************************

######## ########  ######      ######  ########    ###    ########  ######## ######## ########  
##       ##       ##    ##    ##    ##    ##      ## ##   ##     ##    ##    ##       ##     ## 
##       ##       ##          ##          ##     ##   ##  ##     ##    ##    ##       ##     ## 
######   ######    ######      ######     ##    ##     ## ########     ##    ######   ##     ## 
##       ##             ##          ##    ##    ######### ##   ##      ##    ##       ##     ## 
##       ##       ##    ##    ##    ##    ##    ##     ## ##    ##     ##    ##       ##     ## 
##       ########  ######      ######     ##    ##     ## ##     ##    ##    ######## ########  

************************************************************************************************
*/	


			ran4 = 0
			Random,ran4,3,5
			w = 0
			load = 0
			
			while w<ran4
			{
			Random,Ran,-200,60
			Random,Ran2,-200,60
			MouseClick, Left, 400+10+Ran, 400+10+Ran2,1
			Random,Ran3,0,400
			Sleep,100+Ran3
			w++
			}
			Sleep,400+Ran3

			
			
if ddl2>=2
	{
	Random,ran4,0,2
	ran5:=ran4+Foffset
	i = 0
	x = 1	
	w = 0
	while i<x
	{	
GuiControl,,A,피버 보일때 까지 스킵

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\r_skip.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,스킵 아이콘 발견
			
			while w<ran5
			{
				Random,Ran,30,0
				Random,Ran2,30,0
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,300
				Sleep,500+Ran3
				Random,Ran,10,0
				Random,Ran2,10,0
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,300
				Sleep,400+Ran3
				w++
			}
				timeRecord_round(ran5)

			
	w = 0
				
				
GuiControl,,A,피버

				Sleep,1400+Ran3
			Random,ran4,3,4
			while w<ran4
			{
				Random,Ran,1,40
				Random,Ran2,1,80
				MouseClick, Left, 945+Ran, 960+Ran2,1
				Random,Ran3,0,400
				Sleep,110+Ran3
				w++
	

			}
			
				timeRecord_feverclick(ran4)
	w = 0
				Sleep,1500+Ran3	
				i++
			}
		}
	}
	if ddl2=3
	{
	z = 0
	i = 0
	x = 1
	w = 0
	Random,ran4,0,2
	ran5:=ran4+Foffset
	
	
	while i<x
	{
	z++
GuiControl,,A,피버 보일때 까지 스킵

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\r_skip.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,스킵 아이콘 발견
			
			
			while w<ran5
			{
				Random,Ran,0,30
				Random,Ran2,0,30
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,300
				Sleep,500+Ran3
				Random,Ran,0,30
				Random,Ran2,0,30
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,300
				Sleep,400+Ran3
				w++
				i++
			}
				timeRecord_round(ran5)
	w = 0
				
				
GuiControl,,A,피버

				Sleep,1400+Ran3
			Random,ran4,3,4
			while w<ran4
			{
				Random,Ran,1,40
				Random,Ran2,1,80
				MouseClick, Left, 945+Ran, 960+Ran2,1
				Random,Ran3,0,400
				Sleep,110+Ran3
				w++
			}
			
				timeRecord_feverclick(ran4)

	w = 0
			
			}
			
			
				Sleep,800+Ran3	
				
				
				if(z==8)
				{
				
				i++
				}
			
	}
}

	
	i = 0
	x = 1	
	z = 0
	while i<x
	{	
GuiControl,,A,스킵하기

			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\skip.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,스킵 아이콘 발견			
				Random,Ran,-20,20
				Random,Ran2,-20,20
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
				Sleep,1500+Ran3
				
				timeRecord("스킵 발견됨")
			}
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\confirm.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,스킵 확인 아이콘 발견
				Sleep,110+Ran3
				Random,Ran,1,60
				Random,Ran2,1,40
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
				Sleep,1400+Ran3
				Sleep,110+Ran3
				Random,Ran,1,40
				Random,Ran2,1,40
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				i++
				
				timeRecord("스킵 확인 버튼 클릭")
			}
			
				Sleep,800+Ran3	
				z++
				
				if(z==5)
				{
				w++
				i++
				}
			
	w = 0
	}

/*
*********************************************************************************

######## ##    ## ########      #######  ########    ######## ########  ######  
##       ###   ## ##     ##    ##     ## ##          ##       ##       ##    ## 
##       ####  ## ##     ##    ##     ## ##          ##       ##       ##       
######   ## ## ## ##     ##    ##     ## ######      ######   ######    ######  
##       ##  #### ##     ##    ##     ## ##          ##       ##             ## 
##       ##   ### ##     ##    ##     ## ##          ##       ##       ##    ## 
######## ##    ## ########      #######  ##          ##       ########  ######  

*********************************************************************************
*/	

WinActivate DOAX VenusVacation

GuiControl,,A,결과 스킵
	c = 0
	i = 0
	x = 1	
	while i<x
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\fes_cancel.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
				Random,Ran,1,20
				Random,Ran2,1,20
				MouseClick, Left, eeX+1+Ran, eeY+1+Ran2,1
				Random,Ran3,0,400
				Sleep,600+Ran3
				
				timeRecord("페스 결과 화면 내에서 종합 결과 화면 검출됨. 혹은 취소 버튼의 검출.")
			}
		Random,ran4,4,6
		while w<ran4
		{
		Random,Ran,-100,200
		Random,Ran2,-100,100
		MouseClick, Left, 1137+Ran, 783+Ran2,1
		Random,Ran3,80,400
		Sleep,Ran3
		w++
		}
		
		w=0
		c++
		
		if((c==20))
		{
		Msgbox, ERROR!
		Sleep,8000000000000
		}
		ImageSearch, eeX2, eeY2,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\close.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 후 이벤트창 탐색
				Sleep,110+Ran3
				Random,Ran,1,10
				Random,Ran2,1,10
				MouseClick, Left, eeX2+Ran, eeY2+Ran2,1
				
				timeRecord("공지사항 발견됨.")
			}
		
		load=0
		

		ImageSearch, eeX1, eeY2,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\loading.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,페스 후 로딩
			Sleep,1000+Ran3			
			i++
			timeRecord("페스 끝난 뒤 로딩 검출됨.")
			while load<1
			{
	ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\loading.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
			Sleep,1000+Ran3
			}
			else
			{
			load++
			Sleep,4000+Ran3
			}
			}
			
	}
			

			
			
			if((c==19))
			{
	i = 0
	x = 1	
	while i<x
	{	
GuiControl,,A,스킵하기

			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\skip.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,스킵 아이콘 발견			
				Random,Ran,-10,0
				Random,Ran2,-10,0
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
				Sleep,1500+Ran3
			timeRecord("피버를 위한 라운드 건너뛰기 아이콘 탐색 19회 초과로 인한 건너뛰기.")
			}
			else
			{
			i++
			}
			

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\confirm.bmp ; *transBlack은 투명배경을 검정색에 적용, *70은 색값 오차를 50으로 지정
			if((ErrorLevel = 0))
			{
GuiControl,,A,스킵 확인 아이콘 발견
				Sleep,110+Ran3
				Random,Ran,1,10
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
				Sleep,1400+Ran3
				Sleep,110+Ran3
				Random,Ran,1,10
				Random,Ran2,1,10
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				i++
			}
			
	w = 0
	c=0
	}
	}
			
			
	}
	클리어횟수 := 클리어횟수 + 1
	GuiControl, , B, %클리어횟수% 회
	p++
	timeRecord_playtime(클리어횟수)
	}	;Loop의 끝
}

return


/*
***********************************************************************

######## ##     ## ##    ##  ######  ######## ####  #######  ##    ## 
##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## 
##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## 
######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ## 
##       ##     ## ##  #### ##          ##     ##  ##     ## ##  #### 
##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### 
##        #######  ##    ##  ######     ##    ####  #######  ##    ## 

***********************************************************************
*/

F2::
{
	매크로시작 := false
	timeRecord("사용자의 F2입력에 의한 종료")
	ExitApp
}

return


F3::
{
timeRecord("사용자의 F3입력에 의한 재시작.")
Reload
}

Button종료:
{
	매크로시작 := false
	ExitApp
}

return

RunAsAdmin() {
	Loop, %0% {
		param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
		params .= A_Space . param
    }
	ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
	if not A_IsAdmin
	{
		If A_IsCompiled
			DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
		Else
			DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
		ExitApp
	}
}

timeRecord(sentence){
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%sentence%]`n, %log_dir%
	;메모장 log.txt에 월, 일, 시, 분, 초, 지정 문장 순으로 추가작성됨. 
}

timeRecord_feverclick(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][피버를 %sentence%회 클릭]`n, %log_dir%
	;메모장 log.txt에 월, 일, 시, 분, 초, 지정 문장 순으로 추가작성됨. 
}

timeRecord_round(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][피버를 위해 %sentence%회 라운드 스킵하기]`n, %log_dir%
	;메모장 log.txt에 월, 일, 시, 분, 초, 지정 문장 순으로 추가작성됨. 
}
timeRecord_playtime(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%sentence%회 플레이 됨]`n, %log_dir%
	;메모장 log.txt에 월, 일, 시, 분, 초, 지정 문장 순으로 추가작성됨. 
}
timeRecord_FPrecover(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][지정된 회복 횟수는 %sentence%회]`n, %log_dir%
	;메모장 log.txt에 월, 일, 시, 분, 초, 지정 문장 순으로 추가작성됨. 
}
timeRecord_Cur_FPrecover(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%sentence%회째 FP회복 실시]`n, %log_dir%
	;메모장 log.txt에 월, 일, 시, 분, 초, 지정 문장 순으로 추가작성됨. 
}
Screenshot(OutFile)
{
 FormatTime, CurrentDateTime,, yyyy-MM-dd HH-mm
    pToken := Gdip_Startup()

    screen=0|0|%A_ScreenWidth%|%A_ScreenHeight%
    pBitmap := Gdip_BitmapFromScreen(screen)
	location = %A_ScriptDir%\screenshot\%CurrentDateTime% screenshot.png
    Gdip_SaveBitmapToFile(pBitmap, location, 100)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
}

Game_shutdown()
{
	sleep,1000
	send {Esc}
	send {Enter}
}

System_shutdown()
{
	sleep,1000
	shutdown, 12
}