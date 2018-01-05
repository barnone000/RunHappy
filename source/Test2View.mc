using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time;
using Toybox.Time.Gregorian as Calendar;
//using Toybox.Sensor;
using Toybox.Background;
using Toybox.Activity as Act;
using Toybox.ActivityMonitor as ActMon;
//using Toybox.Communications as Comm;

class Test2View extends Ui.WatchFace {

	var heartIcon, notificationIcon, noNotificationIcon, face = null;
	
	var dateFont, timeFont, systemFont, messageFont = null;

	var faceLocation = new [2];
	var heartLocation = new [4];
	var messageLocation = new [4];
	var dateLocation = new [2];
	var timeLocation = new [2];
	var batteryLocation = new [2];
	
    function initialize() {WatchFace.initialize();}

    function onLayout(dc) {
		face = Ui.loadResource(Rez.Drawables.runHappy);
		notificationIcon = Ui.loadResource(Rez.Drawables.Notification);
		noNotificationIcon = Ui.loadResource(Rez.Drawables.NoNotification);
		heartIcon = Ui.loadResource(Rez.Drawables.Heart);
		
		dateFont = Ui.loadResource(Rez.Fonts.dateFont);
		timeFont = Ui.loadResource(Rez.Fonts.timeFont);
		systemFont = Ui.loadResource(Rez.Fonts.systemFont);
		messageFont = Ui.loadResource(Rez.Fonts.messageFont);
		
		locations(dc);
		getNotifications(dc);
    }
    


    function onShow() {	}
	
    function onUpdate(dc) {
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
    	dc.clear();
		
    	dc.drawBitmap(faceLocation[0], faceLocation[1], face);
    	getNotifications(dc);
    	var time = new TimeField(timeLocation[0], timeLocation[1], timeFont, Gfx.COLOR_WHITE);
    	time.draw(dc);
    	var date = new DateField(dateLocation[0], dateLocation[1], dateFont, Gfx.COLOR_WHITE, 0);
    	date.draw(dc);
		var uBattery = new BatteryField(batteryLocation[0], batteryLocation[1], systemFont, Gfx.COLOR_LT_GRAY);
		uBattery.draw(dc);
		var uHeartRate = new HeartRateField(heartLocation[2], heartLocation[3], systemFont, Gfx.COLOR_RED);
		uHeartRate.draw(dc);
		dc.drawBitmap(heartLocation[0], heartLocation[1], heartIcon);
    }

    
    function onHide() {	}

    function onExitSleep() {	}

    function onEnterSleep() {	}
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////HELPER FUNCTIONS//////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function locations(dc) {
		if (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_ROUND) {
			if (System.getDeviceSettings().screenWidth > 239) {
				faceLocation = [16, 50];
				heartLocation = [dc.getWidth()/2-20, faceLocation[1]-40, dc.getWidth()/2+5, faceLocation[1]-45];
				messageLocation = [faceLocation[0]+171, faceLocation[1]-5, faceLocation[0]+185, faceLocation[1]-3];
				dateLocation = [dc.getWidth()/2, faceLocation[1]-30];
				timeLocation = [dc.getWidth()/2, faceLocation[1]+105];
				batteryLocation = [dc.getWidth()/2, faceLocation[1]+150];
			} else {
				faceLocation = [19, 50];
				heartLocation = [dc.getWidth()/2-20, faceLocation[1]-35, dc.getWidth()/2+5, faceLocation[1]-40];
				messageLocation = [faceLocation[0]+151, faceLocation[1]-5, faceLocation[0]+165, faceLocation[1]-3];
				dateLocation = [dc.getWidth()/2, faceLocation[1]-20];
				timeLocation = [dc.getWidth()/2, faceLocation[1]+90];
				batteryLocation = [dc.getWidth()/2, faceLocation[1]+140];
			}
		} else if (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_RECTANGLE) {
			if (System.getDeviceSettings().screenWidth > 150) {
				faceLocation = [28, 25];
				heartLocation = [dc.getWidth()*5/6-20, faceLocation[1]+110, dc.getWidth()*5/6+5, faceLocation[1]+105];
				messageLocation = [faceLocation[0]+135, faceLocation[1]-7, faceLocation[0]+150, faceLocation[1]-5];
				dateLocation = [dc.getWidth()/2, faceLocation[1]-22];
				timeLocation = [dc.getWidth()/2, faceLocation[1]+80];
				batteryLocation = [dc.getWidth()/6, faceLocation[1]+105];
			} else {
				faceLocation = [3, 70];
				heartLocation = [dc.getWidth()/2-20, faceLocation[1]-55, dc.getWidth()/2+5, faceLocation[1]-60];
				messageLocation = [faceLocation[0]+117, faceLocation[1]-12, faceLocation[0]+131, faceLocation[1]-10];
				dateLocation = [dc.getWidth()/2, faceLocation[1]-30];
				timeLocation = [dc.getWidth()/2, faceLocation[1]+75];
				batteryLocation = [dc.getWidth()/2, faceLocation[1]+110];
			}
		} else {
				faceLocation = [28, 25];
				heartLocation = [dc.getWidth()*5/6-20, faceLocation[1]+110, dc.getWidth()*5/6+5, faceLocation[1]+105];
				messageLocation = [faceLocation[0]+135, faceLocation[1]-7, faceLocation[0]+150, faceLocation[1]-5];
				dateLocation = [dc.getWidth()/2, faceLocation[1]-22];
				timeLocation = [dc.getWidth()/2, faceLocation[1]+80];
				batteryLocation = [dc.getWidth()/6, faceLocation[1]+105];
		}
    }
    
	function getNotifications(dc) {
    	var notifications = System.getDeviceSettings().notificationCount;
		if (notifications == 0) {
			dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_TRANSPARENT);
			dc.drawBitmap(messageLocation[0], messageLocation[1], noNotificationIcon);
			dc.drawText(messageLocation[2], messageLocation[3], messageFont, "", Gfx.TEXT_JUSTIFY_CENTER);
		} else {
			dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
			dc.drawBitmap(messageLocation[0], messageLocation[1], notificationIcon);
			dc.drawText(messageLocation[2], messageLocation[3], messageFont, notifications.toString(), Gfx.TEXT_JUSTIFY_CENTER);
		}
    }  
}
