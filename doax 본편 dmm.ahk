RunAsAdmin()
#Include Gdip_all.ahk
SetWorkingDir %A_ScriptDir%





Gui, Color, White, White
Gui Add, Text, x256 y16 w140 h20 +Center, DOAX-VV (DMM) Auto
Gui Add, Text, x232 y48 w190 h30 +Center vA, �غ�
Gui Add, Text, x304 y88 w50 h20 +Center vB, 0 ȸ
Gui Add, Button, x200 y128 w120 h30, ����
Gui Add, Button, x336 y128 w120 h30, ����
Gui Add, DropDownList, x472 y32 w220 vDDL Choose1 AltSubmit, Empty|final|semi-final|6|5|1|SS+|������|20fp|�ǾƷ�|����|
Gui Add, DropDownList, x472 y64 w220 vDDL2 Choose1 AltSubmit, �Ϲ�|�ǹ� 1ȸ|�ǹ� 2ȸ|
Gui Add, DropDownList, x472 y96 w220 vDDL5 Choose1 AltSubmit, �̺�Ʈ ���� �� �� �� é�� �ڵ�����|����|
Gui Add, Text, x16 y16 w165 h30 +Center, (�ʼ�) �÷��� �� Ƚ��
Gui Add, Edit, x56 y48 w90 h20 vPC Number, 10
Gui Add, Edit, x56 y120 w90 h20 vOffset Number, 0
Gui Add, Text, x16 y88 +Center, ����, �ǾƷ� y�� ������ ����
Gui Add, Link, x528 y152 w119 h12 , <a href="https://github.com/Badpixel134/vv-auto">Github repository link</a>
Gui Add, Text, x16 y160 +Center, �ǹ� ���� ��ŵ Ƚ�� ������`n(�Է°� +2���� ����)
Gui Add, Text, x16 y220 w160 +Center, FP ȸ�� Ƚ�� ����
Gui Add, Edit, x56 y240 w92 h21 vDrink Number, 0
Gui Add, Edit, x56 y190 w92 h21 vFoffset Number, 4
Gui Add, CheckBox, x200 y202 vError_Enable, ���� ���� ��`n
Gui Add, CheckBox, x296 y202 vCAPTCHA_Enable, ĸí ���� ��`n
Gui Add, CheckBox, x400 y202 vPLAYTIME_Enable, ������ ��ŭ �÷��̵ǰ���`n(�÷��� Ƚ�� �� FP ȸ��)
Gui Add, CheckBox, x248 y234 vGame_Shutdown, ���� ����`n
Gui Add, CheckBox, x352 y234 vSystem_shutdown, �ý��� ����`n
Gui Add, GroupBox, x185 y180 w393 h75, ���� / �ý��� �ڵ� ���� �ɼ�
Gui Add, GroupBox, x464 y8 w232 h118, �佺 ���� �� �ɼ�
Gui Add, CheckBox, x620 y200 vC_fes_S, S
Gui Add, CheckBox, x620 y220 vC_fes_SS, SS
Gui Add, CheckBox, x620 y240 vC_fes_SSS, SSS
Gui Add, GroupBox, x590 y180 w105 h75, ������ ��ũ Ž��
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

Ŭ����Ƚ�� := 0

Gui, Show, w700 h270, DOAX-VV (DMM)
Return


Button����:
{
 FormatTime, CurrentDateTime,, yyyy-MM-dd HH-mm

	
	
	Gui,Submit,nohide
	GuiControl,,A,����
	��ũ�ν��� := true
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
	ī��Ʈ := 0
	w = 1
	Sleep,1000
	c=0														; �佺 �� ���콺 ��Ÿ ���� Ƚ��
	z=0														; �佺 �� �ǹ��� ���� ���� ��ŵ�Ҷ�, ��ŵ ��ư ���� Ƚ��
	fes_check=0												; �佺 ���� �� �佺 ���� Ƚ��
	GuiControl,,A,test
	log_dir = log\%CurrentDateTime% log.txt
	FileCreateDir, log
	FileCreateDir, screenshot
	timeRecord("VV auto ����.")
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
	timeRecord("������ ���Ͽ� �����ȸ�ŭ �÷��� �� ���� ����.")
	Game_shutdown()
	}
	if System_Shutdown=1
	{
	timeRecord("������ ���Ͽ� �����ȸ�ŭ �÷��� �� �ý��� ����.")
	System_shutdown()
	}
	}
	
	Msgbox, !�Էµ� Ƚ����ŭ �÷��� ��! (����� ���)`n`nPress F2 to exit`nPress F3 to restart
	timeRecord("������ Ƚ����ŭ �÷��� ��")
	
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
msgbox, !������ Ž�� �ɼ��� �������ּ���!`n(���� �ϴ�)`nS���� SS, SSS ������ Ž�� ��.
}
}
	while i<x
	{
	GuiControl,,A,�̺�Ʈâ Ž��

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\notify.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�̺�Ʈâ Ŭ��
				Random,Ran,1,10
				Random,Ran2,1,10
				MouseClick, Left, 1828+Ran, 85+Ran2,1
				timeRecord("�̺�Ʈ Ȯ��.")
			}
			

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes_menu.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
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
GuiControl,,A,é�� ����
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\chapter.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,é�� �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\event fes.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�̺�Ʈ �佺 �߰�
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
			
			
			
			
GuiControl,,A,�̺�Ʈ �佺 ����
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-e.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�̺�Ʈ �佺 �߰�
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
			
GuiControl,,A,�̺�Ʈ �佺 Ȯ��

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\event.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�̺�Ʈ �߰�
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
			
			
			
			GuiControl,,A,é��
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\chapter-ss.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,é��
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
ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-e.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
			
			
GuiControl,,A,�佺 ����
if DDL=1
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-e.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-f.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-s-f.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-6.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-5.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-1.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-ss+.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-s.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("S��ũ ������ Ž�� �Ϸ�")

			}
	}
	if C_fes_SS=1
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-ssm.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SS-��ũ ������ Ž�� �Ϸ�")
			}
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-ss.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SS��ũ ������ Ž�� �Ϸ�")
			}
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-ssp.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SS+��ũ ������ Ž�� �Ϸ�")
			}
	}
	if C_fes_SSS=1
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes-c-sss.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
			Random,Ran,1,160
				Random,Ran2,-15,15
				MouseClick, Left, eeX+60+Ran, eeY+Ran2,1
				Random,Ran3,0,400
			Sleep,600+Ran3
			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
			timeRecord("SSS��ũ ������ Ž�� �Ϸ�")
			}
	}
}		
		if DDL=9
{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\20fp.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �߰�
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
GuiControl,,A,�� �� �佺
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes_menu.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
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
GuiControl,,A,�� �Ʒ� �佺
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\fes_menu.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
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
GuiControl,,A,�佺Ƽ�� Ȯ�� ����
timeRecord("�佺Ƽ�� Ȯ�� ���� Ƚ���� 20ȸ�� �Ѿ����ϴ�.")
Screenshot(FES NOT FOUND)
	if Error_Enable=1
	{
	if Game_Shutdown=1
	{
	timeRecord("������ ���Ͽ� ���� ���� �� ���� ����.")
	Game_shutdown()
	}
	if System_Shutdown=1
	{
	timeRecord("������ ���Ͽ� ���� ���� �� �ý��� ����.")
	System_shutdown()
	}
	}
	Sleep,300000
	Msgbox, !�佺Ƽ�� Ȯ�� ���� Ƚ���� 20ȸ�� �Ѿ����ϴ�! (����� ���)`n`nPress F2 to exit`nPress F3 to restart
}

if DDL5=1
{
GuiControl,,A,é�� �ֻ��
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *60 DOAX\DMM\chapter-opened.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,é��
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
GuiControl,,A,�佺 ���� ��ư Ž��
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\start.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 ���� ��ư Ž�� �Ϸ�
			Random,Ran,1,20
				Random,Ran2,1,20
				MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
				Random,Ran3,0,400
			Random,Ran2,1,15
			Random,Ran1,1,15
			timeRecord("�佺 ���� ��ư Ž�� ��.")
			Sleep,3000+Ran3
			MouseMove, 10+ran2, 10+ran1
			}
GuiControl,,A,�佺 ���� Ž��
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\ERROR.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 ����

			timeRecord("���α׷� ���� �Ǵ� ĸí �̹����� ���� ����.")

				Random,Ran3,0,400
			Sleep,200+Ran3
						ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\cancel.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
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
			timeRecord("������ ���Ͽ� ĸí ���� �� ���� ����.")
						Game_shutdown()
						}
						if System_Shutdown=1
						{
			timeRecord("������ ���Ͽ� ĸí ���� �� �ý��� ����.")
						System_shutdown()
						}
					}
				}
			Msgbox, !ĸí ���� ��! (����� ���)`n`nPress F2 to exit`nPress F3 to restart
			Sleep,8000000000
			
			
			}
			
ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\fp_confirm.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
				if((ErrorLevel = 0))
				{
GuiControl,,A,ĸí Ȯ�� 2
					captcha++
				}

ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\cancel.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
				if((ErrorLevel = 0))
				{
GuiControl,,A,ĸí Ȯ�� 3
					captcha++
				}
				
if captcha=3
{
	Screenshot(CAPTCHA)
					
		if CAPTCHA_Enable=1
		{
			if Game_Shutdown=1
			{
			timeRecord("������ ���Ͽ� ĸí ���� �� ���� ����.")
			Game_shutdown()
			}
			if System_Shutdown=1
			{
			timeRecord("������ ���Ͽ� ĸí ���� �� �ý��� ����.")
			System_shutdown()
			}
			}
}

WinActivate DOAX VenusVacation
GuiControl,,A,FP Ž��
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\FP.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
				timeRecord("FP ���� Ȯ��.")
			
					if (Cur_drink>=drink)
					{
						timeRecord("FP ȸ�� Ƚ���� ������ ��ŭ �ǽõǾ����ϴ�.")
						
							GuiControl,,A,END OF PLAY plz restart
	
							if PLAYTIME_Enable=1
							{
								if Game_Shutdown=1
								{
								timeRecord("������ ���Ͽ� �����ȸ�ŭ �÷��� �� ���� ����.")
								Game_shutdown()
								}
								if System_Shutdown=1
								{
								timeRecord("������ ���Ͽ� �����ȸ�ŭ �÷��� �� �ý��� ����.")
								System_shutdown()
								}
							}
	
								Msgbox, !�Էµ� FP ȸ�� Ƚ����ŭ �÷��� ��! (����� ���)`n`nPress F2 to exit`nPress F3 to restart
					}
					
GuiControl,,A,FP ����
					Random,Ran3,0,400
					Sleep,200+Ran3
					Random,Ran,1,10
					Random,Ran2,1,10
					MouseClick, Left, eeX+140+Ran, eeY+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3


		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\Steam\FP2.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,FP ����
					Random,Ran3,0,400
					Sleep,200+Ran3
					Random,Ran,1,10
					Random,Ran2,1,10
					Random,Ran3,0,400
					Sleep,600+Ran3
			}
			

			ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\fp_confirm.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
				if((ErrorLevel = 0))
				{
GuiControl,,A,FP ����
					Random,Ran,1,20
					Random,Ran2,1,20
					MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3
					
					Cur_drink := Cur_drink*1+1
					
					timeRecord_FPrecover(drink)
					timeRecord_Cur_FPrecover(Cur_drink)
					
								
			ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\fp_confirm.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
				if((ErrorLevel = 0))
				{
GuiControl,,A,FP ���� Ȯ�� *double check
					Random,Ran,1,20
					Random,Ran2,1,20
					MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
					Random,Ran3,0,400
					Sleep,600+Ran3
					
					ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *30 DOAX\DMM\start.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
						if((ErrorLevel = 0))
						{
GuiControl,,A,FP ���� �� �佺 ����
							Random,Ran,1,20
							Random,Ran2,1,20
							MouseClick, Left, eeX+10+Ran, eeY+10+Ran2,1
					Random,Ran3,0,400
					Sleep,400+Ran3
					timeRecord("FP ���� �� �佺 ����")
						}
				}
			}
		}
		
		load=0
while load<1
{	
GuiControl,,A,�ε� Ž��	
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\loading.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�ε� �߰�
			i++
			timeRecord("�佺 ���� �ε� �����.")
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
GuiControl,,A,�ǹ� ���϶� ���� ��ŵ

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\r_skip.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,��ŵ ������ �߰�
			
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
				
				
GuiControl,,A,�ǹ�

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
GuiControl,,A,�ǹ� ���϶� ���� ��ŵ

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *40 DOAX\DMM\r_skip.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,��ŵ ������ �߰�
			
			
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
				
				
GuiControl,,A,�ǹ�

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
GuiControl,,A,��ŵ�ϱ�

			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\skip.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,��ŵ ������ �߰�			
				Random,Ran,-20,20
				Random,Ran2,-20,20
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
				Sleep,1500+Ran3
				
				timeRecord("��ŵ �߰ߵ�")
			}
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\confirm.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,��ŵ Ȯ�� ������ �߰�
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
				
				timeRecord("��ŵ Ȯ�� ��ư Ŭ��")
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

GuiControl,,A,��� ��ŵ
	c = 0
	i = 0
	x = 1	
	while i<x
	{
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\fes_cancel.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
				Random,Ran,1,20
				Random,Ran2,1,20
				MouseClick, Left, eeX+1+Ran, eeY+1+Ran2,1
				Random,Ran3,0,400
				Sleep,600+Ran3
				
				timeRecord("�佺 ��� ȭ�� ������ ���� ��� ȭ�� �����. Ȥ�� ��� ��ư�� ����.")
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
		ImageSearch, eeX2, eeY2,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\close.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �� �̺�Ʈâ Ž��
				Sleep,110+Ran3
				Random,Ran,1,10
				Random,Ran2,1,10
				MouseClick, Left, eeX2+Ran, eeY2+Ran2,1
				
				timeRecord("�������� �߰ߵ�.")
			}
		
		load=0
		

		ImageSearch, eeX1, eeY2,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\loading.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,�佺 �� �ε�
			Sleep,1000+Ran3			
			i++
			timeRecord("�佺 ���� �� �ε� �����.")
			while load<1
			{
	ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *70 DOAX\DMM\loading.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
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
GuiControl,,A,��ŵ�ϱ�

			Random,Ran2,1,15
			Random,Ran1,1,15
			MouseMove, 10+ran2, 10+ran1
		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\skip.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,��ŵ ������ �߰�			
				Random,Ran,-10,0
				Random,Ran2,-10,0
				MouseClick, Left, eeX+Ran, eeY+Ran2,1
				Random,Ran3,0,400
				Sleep,1500+Ran3
			timeRecord("�ǹ��� ���� ���� �ǳʶٱ� ������ Ž�� 19ȸ �ʰ��� ���� �ǳʶٱ�.")
			}
			else
			{
			i++
			}
			

		ImageSearch, eeX, eeY,0,0, A_ScreenWidth, A_ScreenHeight, *80 DOAX\DMM\confirm.bmp ; *transBlack�� �������� �������� ����, *70�� ���� ������ 50���� ����
			if((ErrorLevel = 0))
			{
GuiControl,,A,��ŵ Ȯ�� ������ �߰�
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
	Ŭ����Ƚ�� := Ŭ����Ƚ�� + 1
	GuiControl, , B, %Ŭ����Ƚ��% ȸ
	p++
	timeRecord_playtime(Ŭ����Ƚ��)
	}	;Loop�� ��
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
	��ũ�ν��� := false
	timeRecord("������� F2�Է¿� ���� ����")
	ExitApp
}

return


F3::
{
timeRecord("������� F3�Է¿� ���� �����.")
Reload
}

Button����:
{
	��ũ�ν��� := false
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
	;�޸��� log.txt�� ��, ��, ��, ��, ��, ���� ���� ������ �߰��ۼ���. 
}

timeRecord_feverclick(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][�ǹ��� %sentence%ȸ Ŭ��]`n, %log_dir%
	;�޸��� log.txt�� ��, ��, ��, ��, ��, ���� ���� ������ �߰��ۼ���. 
}

timeRecord_round(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][�ǹ��� ���� %sentence%ȸ ���� ��ŵ�ϱ�]`n, %log_dir%
	;�޸��� log.txt�� ��, ��, ��, ��, ��, ���� ���� ������ �߰��ۼ���. 
}
timeRecord_playtime(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%sentence%ȸ �÷��� ��]`n, %log_dir%
	;�޸��� log.txt�� ��, ��, ��, ��, ��, ���� ���� ������ �߰��ۼ���. 
}
timeRecord_FPrecover(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][������ ȸ�� Ƚ���� %sentence%ȸ]`n, %log_dir%
	;�޸��� log.txt�� ��, ��, ��, ��, ��, ���� ���� ������ �߰��ۼ���. 
}
timeRecord_Cur_FPrecover(sentence)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%sentence%ȸ° FPȸ�� �ǽ�]`n, %log_dir%
	;�޸��� log.txt�� ��, ��, ��, ��, ��, ���� ���� ������ �߰��ۼ���. 
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