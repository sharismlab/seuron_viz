class SeuronTmp {
	int id, level=4;
	ArrayList<Message> msgsTmp;

	// Daddy:0, Friend&Follow:1 , friend:2, follow3, noName:4
	SeuronTmp(int _id, int _level) {
		id=_id;
		level=_level;
		msgsTmp = new ArrayList();
	}


// add a message into list
	void addMessage( Transmitter trans, Object data, int type ) {
		//console.log(msg);
		msgsTmp.add( new Message(trans, data, type) );
		//console.log(msgsTmp.get( msgsTmp.size() -1 ));
	}

}