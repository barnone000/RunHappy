using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time.Gregorian as Calendar;
using Toybox.ActivityMonitor as ActMon;
using Toybox.Activity as Act;

class DateField extends Ui.Drawable {

	var date = null;
	var dateString = null;
	
	var dateFont = null;
	var dateColor = null;
	var dateFormat = null;
	var dateX = null;
	var dateY = null;
	
	function initialize(pdateX, pdateY, pdateFont, pdateColor, pdateFormat) {
		Ui.Drawable.initialize({:locX => 0, :locY => 0});
		date = null;
		dateString = null;
		dateFont = pdateFont;
		dateColor = pdateColor;
		dateFormat = pdateFormat;
		dateX = pdateX;
		dateY = pdateY;
	}
	
	function draw(dc) {
		switch(dateFormat) {
				case 0:
					date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
					dateString = Lang.format("$1$, $2$ $3$",[date.day_of_week, date.month, date.day]);
					break;
				case 1:
					date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
					dateString = Lang.format("$1$, $2$ $3$",[date.day_of_week, date.day, date.month]);
					break;
				case 2:
					date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
					dateString = Lang.format("$1$ $2$",[date.month, date.day]);
					break;
				case 3:
					date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
					dateString = Lang.format("$1$ $2$",[date.day, date.month]);
					break;
				case 4:
					date = Calendar.info(Time.now(), Time.FORMAT_SHORT);
					dateString = Lang.format("$1$/$2$/$3$",[date.month, date.day, date.year]);
					break;
				case 5:
				default:
					date = Calendar.info(Time.now(), Time.FORMAT_SHORT);
					dateString = Lang.format("$1$/$2$/$3$",[date.day, date.month, date.year]);
					break;
			}

		dc.setColor(dateColor, Gfx.COLOR_TRANSPARENT);
		dc.drawText(dateX, dateY, dateFont,  dateString, Gfx.TEXT_JUSTIFY_CENTER);
	}
}