class SeuronTmp {
	int id, level=4;
	ArrayList<Message> msgsTmp;

	// Daddy:0, Friend&Follow:1 , friend:2, follow3, noName:4
	SeuronTmp(int _id, int _level) {
		id=_id;
		level=_level;
	}

	
	void addMessage( Message msg, int type ) {
		// console.log(msg);
		msgsTmp.add( msg );
	}

}