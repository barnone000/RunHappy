using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as ActMon;
using Toybox.System as Sys;
using Toybox.Application as App;

class HeartRateField extends Ui.Drawable {

	var heartRateFont = null;
	var heartRateColor = null;
	var heartRateX = 0;
	var heartRateY = 0;
	

	function initialize(pheartRateX, pheartRateY, pheartRateFont, pheartRateColor) {
		Ui.Drawable.initialize({:locX => 0, :locY => 0});
		heartRateFont = pheartRateFont;
		heartRateColor = pheartRateColor;
		heartRateX = pheartRateX;
		heartRateY = pheartRateY;
	}
	
	function draw(dc) {
		var heartRate = "";
		var HRHistory;

		if (ActMon has :getHeartRateHistory) {
			HRHistory = ActMon.getHeartRateHistory(1, true);
			if ((HRHistory != null) && (HRHistory.getMax() != null) && (HRHistory.getMax() > 0) && (HRHistory.getMax() < 255)) {
				heartRate = HRHistory.getMax();
			}
		} else {
			heartRate = Activity.getActivityInfo().currentHeartRate + "bpm";
		}
		
		dc.setColor(heartRateColor, Gfx.COLOR_TRANSPARENT);
		dc.drawText(heartRateX, heartRateY, heartRateFont, heartRate, Gfx.TEXT_JUSTIFY_CENTER);
	}
}