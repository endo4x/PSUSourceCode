--[[
	id: xgnSS2O45qhyc-Y_Ki88s
	name: holo_1.0
	description: holo_1.0
	time1: 2021-06-05 01:31:16.987587+00
	time2: 2021-06-05 01:31:16.987588+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

const DisplayRoot = document.getElementById("displayRoot");
const GearDisplay = document.getElementById("gearDisplay");
const GearNum = document.getElementById("gearNum");
const UnitDisplay = document.getElementById("unitDisplay");
const AbsIndicator = document.getElementById("absIndicator");
const HBrakeIndicator = document.getElementById("hBrakeIndicator");
const RpmDisplay = document.getElementById("rpmBar");
const SpeedDisplay = [
	document.getElementById("speedDisplayDigit_0"),
	document.getElementById("speedDisplayDigit_1"),
	document.getElementById("speedDisplayDigit_2"),
];
const FuelDisplay = document.getElementById("fuelBar");
const EngineHealthDisplay = document.getElementById("engineBar");
const BodyHealthDisplay = document.getElementById("bodyBar");
const CruiseControlDisplay = document.getElementById("cruiseControl");

var useMetric = true;

function changeTheme(name) {
	const oldThemeElement = document.getElementById("themeStylesheet");
	
	if (name != "default") {
		const newThemeElement = document.createElement("link");
		newThemeElement.href = `css/themes/${name}.css`;
		newThemeElement.rel = "stylesheet";
		newThemeElement.type = "text/css";
		newThemeElement.id = "themeStylesheet";
		document.head.appendChild(newThemeElement);
	}

	if (oldThemeElement != undefined) oldThemeElement.remove();
}

window.addEventListener("message", function(ev) {
	const data = ev.data;

	const bicycleNumber = 13;
	const vehicleClass = data.vehicleClass;

	if (data.theme != undefined) changeTheme(data.theme);

	if (data.useMetric != undefined) {
		const useMetricNow = data.useMetric != false;
		if (useMetric != useMetricNow) {
			useMetric = useMetricNow;
			UnitDisplay.innerText = useMetric ? "KMH" : "MPH";
		}
	}

	if (data.rawSpeed != undefined) {
		var multiplier = useMetric ? 3.6 : 2.236936;
		var unitSpeed = Math.floor(parseFloat(data.rawSpeed) * multiplier);
		var speedString = unitSpeed.toString().padStart(3, '&');

		if (speedString.length > 3) speedString = "999";

		for (let i = 0; i < 3; i++) {
			SpeedDisplay[i].innerText = speedString[i] == "&" ? "" : speedString[i]; 
		}
	}
	
	if (bicycleNumber == vehicleClass) {
		// This will hide the unnecessary info(gear, rpm, fuel) when you are driving a bike.
		toggleSpeedometerInfo(false);
	} else {
		// This will stop the current animation.
		$("#seatbeltContainer").stop(false, true);

		// This will set the seatbelt container to be visible.
		$("#seatbeltContainer").css('display', 'flex');

		// If the seatbelt is not active this will show a red icon with blink effect.
    	if (data != undefined && data.displayWindow != undefined && data.displayWindow == 'true') {

  		$("#seatbeltOff").css('display', 'block');
  		$("#seatbeltOn").css('display', 'none');

		  $("#seatbeltContainer").animate({
			  bottom: "25%",
        	},
        	700, function() {
				
			});
		// If the seatbelt is active this will show a green icon.
		} else if (data != undefined && data.displayWindow != undefined && data.displayWindow == 'false') {
			$("#seatbeltContainer").animate({
				bottom: "-50%",
        	},
        	700, function() {
				$("#seatbeltOff").css('display', 'none');
				$("#seatbeltOn").css('display', 'block');
	         	
        });
    }
		if (data.gear != undefined) {
			const gear = parseInt(data.gear);
			if (gear == 0) {
				GearNum.innerText = "R";
				GearDisplay.classList.add("reverseGear");
				GearDisplay.classList.remove("normalGear");
			} else {
				GearNum.innerText = gear;
				GearDisplay.classList.remove("reverseGear");
				GearDisplay.classList.add("normalGear");
			}
		}

		if (data.rpm != undefined) {
			const rawRpm = parseFloat(data.rpm);
			RpmDisplay.style.width = `${(parseFloat(data.rpm) * 100.0).toFixed(2)}%`;
			GearDisplay.classList.toggle("rpmOverload", (rawRpm * 9) > 7.5);
		}

		if(data.fuel != undefined) {
			const rawFuel = parseFloat(data.fuel);

			FuelDisplay.style.height = `${rawFuel}%`;

			if(rawFuel <= 25) {
				FuelDisplay.classList.add('fuelLow');
			} else {
				FuelDisplay.classList.remove('fuelLow');
			}
		} 

		if(data.engineHealth != undefined) {
			const engineHealthRaw = parseFloat(data.engineHealth);
			
			const engineHealthParsed = (engineHealthRaw / 10).toFixed(2);
			
			EngineHealthDisplay.style.height = `${engineHealthParsed}%`

			if(engineHealthParsed <= 25) {
				EngineHealthDisplay.classList.add('lowHealth');
			} else {
				EngineHealthDisplay.classList.remove('lowHealth');
			}
		}

		if(data.bodyHealth != undefined) {
			const bodyHealthRaw = parseFloat(data.bodyHealth);
			
			const bodyHealthParsed = (bodyHealthRaw / 10).toFixed(2);

			BodyHealthDisplay.style.height = `${bodyHealthParsed}%`

			if(bodyHealthParsed <= 25) {
				BodyHealthDisplay.classList.add('lowHealth');
				
			} else {
				BodyHealthDisplay.classList.remove('lowHealth');
			}
		}

		if(data.cruiseControl == "true") {
			$("#cruiseControl").css('color', '#00ff72');
		} else if (data.cruiseControl == "false") {
			$("#cruiseControl").css('color', '#c1c1c1');
		}
 
		toggleSpeedometerInfo(true);

		if (data.hBrake != undefined) HBrakeIndicator.classList.toggle("inactive", data.hBrake == false);

		if (data.abs != undefined) AbsIndicator.classList.toggle("inactive", data.abs == false);
	}

	// Motorcycles, Cycles, Boats, Helicopters, Planes
	var vehiclesToExclude = [8, 13, 14, 15, 16];

	// This will hide the seatbelt section.
	if (vehiclesToExclude.includes(vehicleClass)) {
		$("#seatbeltContainer").css('display', 'none');
	}

	if (data.display != undefined) DisplayRoot.classList.toggle("hidden", !data.display);
});

function toggleSpeedometerInfo(status) {
	var display = status == true ? 'block' : 'none';

	document.getElementById('absContainer').style.display = display;
	document.getElementById('rpmBarBg').style.display = display;
	document.getElementById('hBrakeContainer').style.display = display;
	document.getElementById('fuelBarBg').style.display = display;
	document.getElementById('gearDisplay').style.display = display;
}

// Due to loading order, we need to let the resource side know when *we* are ready.
// Just having the browser "loaded" isn't enough.
fetch(`https://${document.location.host}/duiIsReady`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({ok: true})
})