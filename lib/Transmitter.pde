Transmitter twitterTransmitter = new Transmitter( "Twitter", color(0, 172, 237) );

class Transmitter {

	color c;
	String name;

	//default
	Transmitter() {
		c = color(255);
	}

	//constructor
	Transmitter( String _name, color _c ) {
		name = _name;
		c = _c;
	}

	int getColor()
	{
		return c;
	}
}

