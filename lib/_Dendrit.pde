/*
Thanks to 
 http://processingjs.org/learning/topic/scribbleplotter/
 http://vormplus.be/blog/article/processing-month-day-2-connecting-points-part-2
 */

class Dendrit {

	float SECTION_LENGTH = 12;
	int scount = 12;
	float w, e;
	Seuron from, to;
	PVector[] sections = new PVector[scount];

	Dendrit(Seuron _from, Seuron _to, float _w, float _e) {
		from = _from;
		to = _to;
		_w = w; //weight
		_e =e ; //excitation state

		float e = 0.5; // excitation rate, later should be activate by mouse
		
		// calculate dendrite length 
		// float len = dist(from.cx, from.cy, to.cx, to.cy);
		// scount = 12; //number of sections for this dendrite
	}

	void draw() {
		float dst = dist(from.cx, from.cy, to.cx, to.cy);
		stroke(255, 35);
		strokeWeight(dst/50);
		scribble(from.cx, from.cy, to.ax, to.ay, scount, e);
	}

	void excitate() {
		strokeWeight( random(e) );
		e += 0.5;
	}

	void inhibate() {
		if ( e >0.5) {
			e -= 1;
			strokeWeight( random(e) );
		} 
		else {
			strokeWeight( 1 );
		}
	}
}

/* 
 scribble function plots lines between end points, 
 determined by steps and scribVal arguments.
 */

void scribble(float x1, float y1, float x2, float y2, int steps, float scribVal) {

	float xStep = (x2-x1)/steps;
	float yStep = (y2-y1)/steps;

	// println(steps);

	for (int i = 0; i<steps; i++) {

		if (i<steps-1) {
			line(x1, y1, x1+=xStep+random(-scribVal, scribVal), y1+=yStep+random(-scribVal, scribVal));
		} 
		else {

			// extra line needed to attach line back to point
			line(x1, y1, x2, y2);
		}
	}
}
