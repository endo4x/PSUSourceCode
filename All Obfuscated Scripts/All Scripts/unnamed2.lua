--[[
	id: KXfBH7DJaupImCg65vN3o
	name: 3434
	description: 43434
	time1: 2021-06-27 02:08:44.596964+00
	time2: 2021-06-27 02:08:44.596964+00
	uploader: endILJ7HNjVIZCz1DajtBSeklWVeOgx1J3h9pS6d
	uploadersession: pPgYfyAQ9sdYSqaqndOnhd6Gu11Uxe
	flag: f
--]]

var isIpadOpen = false

showHud();

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        if (event.data.action == 'showIpad') {
            showIpad();
            isIpadOpen = true
        }
        if (event.data.action == 'responseIpadApps') {
            components.IpadDesktopApp.responseIpadApps(event.data.apps);
        }
        if (event.data.action == 'responseAcceptedTickets') {
            components.SupportAcceptedTickets.responseAcceptedTicketList(event.data.tickets);
        }
        if (event.data.action == 'responseVehicleData') {
            components.SupportVehicleProfile.responseVehicleData(event.data.data);
        }
        if (event.data.action == 'responseVehicleData') {
            components.SupportVehicleProfile.responseVehicleData(event.data.data);
        }
        if (event.data.action == 'responseVehicleList') {
            components.SupportVehicleList.responseVehicleList(event.data.data);
        }
        if (event.data.action == 'responseOpenTickets') {
            components.SupportOpenTickets.responseOpenTicketList(event.data.tickets);
        }
    })
});

document.addEventListener('keydown', (event) => {
    if (event.which === 122 && isIpadOpen) {
        closeIpad();
    }
});

function closeIpad() {
    isIpadOpen = false
    $.post('http://ipad/close');
    components.Ipad.show(null);
}

function showHud() {
    components.Hud.visible = true
}

function showIpad() {
    components.Ipad.show("IpadMainScreen");
}