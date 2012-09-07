var loading = null;
var viz = Processing.getInstanceById("seuron");
	
function getProfile( username ) {

	$.ajax({
		url: 'datasamples/makio135_profile.json',
		dataType: 'json',
		async:false,
		success: function(result) {
			d=result;
		}
	});
	
	return d;
}

function getFriends( username ) {
	var d;
	$.ajax({
		url: 'datasamples/makio135_friends.json',
		dataType: 'json',
		async:false,
		success: function(result) {
			d=result;
		}
	});
	return d;
}


function getFollowers( username ) {
	var d;
	$.ajax({
		url: 'datasamples/makio135_followers.json',
		dataType: 'json',
		async:false,
		success: function(result) {
			d=result;
		}
	});
	return d;
}		

function getTimeline( username ) {
	var d;
	$.ajax({
		url: 'datasamples/makio135_timeline.json',
		dataType: 'json',
		async:false,
		success: function(result) {
			d=result;
		}
	});
	return d;
}