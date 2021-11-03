--[[
	id: rTM-G3ekDQVYiKTVGtI4U
	name: test
	description: tes
	time1: 2021-05-06 16:49:17.149759+00
	time2: 2021-05-06 16:49:17.14976+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

let inVehicle = false
let phoneOpen = false
let updatedCashCount = 0

window.addEventListener('message', (event) => {
    if (event.data.type == "phone") {
        //$('.voice').attr("style", "");
        phoneOpen = event.data.phoneOpen
        if (phoneOpen) {
            $(".voice").animate({
                right: "%1",
                bottom: "92%"
            }, 500);
        }

        if (inVehicle) {
            if (phoneOpen) {
                $(".car-hud").fadeOut()
            } else {
                $(".car-hud").fadeIn()
                $(".voice").animate({
                    right: "40px",
                    bottom: "235px"
                }, 500);
            }
        } else {
            if (!phoneOpen) {
                $(".voice").animate({
                    right: "%1",
                    bottom: "2%"
                }, 500);
            }
        }
    } else if (event.data.type == "ui") {
        if (event.data.show) {
            $(".container").fadeIn();
            if (inVehicle && !phoneOpen) {
                $(".voice").animate({
                    right: "40px",
                    bottom: "235px"
                }, 500);
            }
        } else {
            $(".container").fadeOut();
            if (inVehicle && !phoneOpen) {
                $(".voice").animate({
                    right: "%1",
                    bottom: "2%"
                }, 500);
            }
        }
    } else if (event.data.type == 'updateStatus') {
        for(let prop in event.data.data){
            var val = event.data.data[prop]
            $("#"+prop).css("width", val+"%")
        }
    } else if (event.data.type == 'tick') {
        $("#heal").css("width", event.data.heal+"%")
        $("#zirh").css("width", event.data.zirh+"%")
        if (!inVehicle) {
            let oxyVal = event.data.oxy
            if (oxyVal < 100) {
                $("#oxy").css("width", oxyVal+"%")
                $("#stamina-bar").fadeOut()
                $("#oxy-bar").fadeIn()
            } else {
                $("#stamina").css("width", event.data.stamina+"%")
                $("#stamina-bar").fadeIn()
                $("#oxy-bar").fadeOut()
            }    
        }
        
    } else if (event.data.type == "carHud") {
        $(".street-text-text").html(event.data.street)
        $(".street-text-compass").html(event.data.compass)
        $(".status-hud-clock-text").html(event.data.time)
        $(".fuel-bar-inside").css("width", event.data.fuel+"%")
        carHudMiniIconOnOff("doors", event.data.doors)
        carHudMiniIconOnOff("engine", event.data.engine)
        carHudMiniIconOnOff("light", event.data.light)
        carHudMiniIconOnOff("belt", event.data.belt)
        carHudMiniIconOnOff("trunk", event.data.trunk)
        carHudMiniIconOnOff("cruise", event.data.cruise)
        if (event.data.seatbeltmod) {
            $("#beltColor path").css("fill", "orange")
        } else {
            $("#beltColor path").css("fill", "white")
        }
        if (event.data.engineHealth < 500) {
            $("#engineColor path").css("fill", "orange")
        } else {
            $("#engineColor path").css("fill", "white")
        }
    } else if (event.data.type == "vehSpeed") {
        $(".kmh-number").html(event.data.speed)
        $(".strela").css("transform", "rotate("+event.data.speed+"deg)")
    } else if (event.data.type == "inVeh") {
        if (event.data.data) {
            inVehicle = true
            $(".mapoutline").fadeIn(50);

            $(".status-hud").animate({
                left: "4.4%",
                bottom: "3%"
            }, 500);

            if (!phoneOpen) {
                $(".voice").animate({
                    right: "40px",
                    bottom: "235px"
                }, 500, function() {
                    $(".car-hud").fadeIn()
                });
            }

            $("#hunger-bar").fadeOut()
            $("#water-bar").fadeOut()
            $("#stamina-bar").fadeOut()
            //$("#oxy-bar").fadeOut()

            $(".street-text").animate({
                left: "19%",
                bottom: "3%"
            }, 500);
        } else {
            inVehicle = false
            $(".mapoutline").fadeOut(50);

            $(".status-hud").animate({
                left: "1%",
                bottom: "2%"
            }, 500);

            $("#hunger-bar").fadeIn()
            $("#water-bar").fadeIn()
            $("#stamina-bar").fadeIn()
            //$("#oxy-bar").fadeIn()
            if (!phoneOpen) {
                $(".car-hud").fadeOut(500, function() {
                    $(".voice").animate({
                        right: "%1",
                        bottom: "2%"
                    }, 500);
                });
            }

            $(".street-text").animate({
                left: "1%",
                bottom: "5.5%"
            }, 500);
         
        }
        $(".status-hud-clock-text").html(event.data.time)
    } else if (event.data.type == "clockStreet") {
        $(".status-hud-clock-text").html(event.data.time)
        $(".street-text-text").html(event.data.street)
        $(".street-text-compass").html(event.data.compass)
    } else if (event.data.type == "voice") {
        $(".voice-elipse").html(event.data.lvl)
    } else if (event.data.type == "money") {
        $("#cash").html(setCurrency(event.data.money))
        if (event.data.show) {
            $(".money-cash").animate({opacity: "1.0"}, 100);
        } else {
            $(".money-cash").animate({opacity: "0.0"}, 100);
        }
    } else if (event.data.type == "moneyUpdate") {
        updatedCashCount++
        $("#cash").html(setCurrency(event.data.newCashAmount))
        if (event.data.isMinus) {plusOrMinus = "-"} else {plusOrMinus = "+"}
        $(".money-cash").animate({opacity: "1.0"}, 100);
        if (updatedCashCount == 1) {
            $("#addCashValue").html(plusOrMinus+setCurrency(event.data.money))
            $("#addCash").animate({opacity: "1.0"}, 100);
        } else {
            $("#addCash").animate({opacity: "0.0"}, 100, function(){
                $("#addCashValue").html(plusOrMinus+setCurrency(event.data.money))
                $("#addCash").animate({opacity: "1.0"}, 100);
            });
        }
        setTimeout(() => {
            updatedCashCount--
            if (updatedCashCount == 0) {
                $(".money-cash").animate({opacity: "0.0"}, 100);
                $("#addCash").animate({opacity: "0.0"}, 100);
            }
        }, 2000);
    } else if (event.data.type == "speak") {
        if (event.data.active) {
            $(".circle-ripple").fadeIn(150)
        } else {
            $(".circle-ripple").fadeOut(150)
        }
    }
});

function setCurrency(price) {
    return (price).toLocaleString('tr-TR', {style: 'currency', currency: 'USD', maximumFractionDigits: 0, minimumFractionDigits: 0})
}

function carHudMiniIconOnOff(style, on) {
    if (on == "close") {
        $("#"+style).css("display", "none")
        $("#"+style+"-icon").css("display", "none")
    } else if (!on) {
        $("#"+style).css("display", "none")
        $("#"+style+"-icon").css("display", "block")
        $("#"+style+"-icon").css("opacity", "0.45")
    } else {
        $("#"+style).css("display", "block")
        $("#"+style+"-icon").css("display", "block")
        $("#"+style+"-icon").css("opacity", "1.0")
    }
}