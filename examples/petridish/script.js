var loading = null;
var viz = Processing.getInstanceById("seuron");
	
function getProfile( username ) {

	$.ajax({
		url: 'datasamples/clemsos_profile.json',
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
		url: 'datasamples/clemsos_friends.json',
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
		url: 'datasamples/clemsos_followers.json',
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
		url: 'datasamples/clemsos_timeline.json',
		dataType: 'json',
		async:false,
		success: function(result) {
			d=result;
		}
	});
	return d;
}

function getMentions( username ) {
	var d;
	$.ajax({
		url: 'datasamples/clemsos_mentions.json',
		dataType: 'json',
		async:false,
		success: function(result) {
			d=result;
		}
	});
	return d;
}