class Shape {
	String name;
	Shape (String name) {
		this.name = name;
	}

	abstract void print();
	abstract void draw();
	abstract double area();
}

class Circle extends Shape {
	int radius;
	Circle (String name, int radius) {
		super(name);
		this.radius = radius;
	}

	@Override
	void print() {
		System.out.println(name + " (" + radius + ") : " + area());
	}

	@Override
	void draw() {
		//
	}

	@Override
	double area() {
		return Math.PI * radius * radius;
	}
	
}

class Square extends Shape {
	int side;
	Square(String name, int side) {
		super(name);
		this.side = side;
	}

	@Override
	void print() {
		System.out.println(name + " (" + side + ") : " + area());
	}

	@Override
	void draw() {
		int s = Math.max(1, side);
        String row = "*".repeat(s);
        for (int i = 0; i < s; ++i) System.out.println(row);
        System.out.println();
	}

	@Override
	double area() {
		return (double) side * side;
	}
}

class Triangle extends Shape {
	int base;
	int height;

	Triangle(String name, int base, int height) {
		super(name);
		this.base = base;
		this.height = height;
	}

	@Override
	void print() {
		System.out.println(name + " (" + base + ", " + height + ") : " + area());
	}

	@Override
	void draw() {
		int h = Math.max(1, height);
		for (int i = 1; i <= h; ++i) {
			System.out.println("*".repeat(i));
		}
		System.out.println()
	}

	@Override
	double area() {
		return 0.5 * base * height;
	}
}

class Rectangle extends Square {
	int width;
	Rectangle(String name, int height, int width) {
		super(name, height);
		this.width = width;
	}

	@Override
	void print() {
		System.out.println(name + " (" + side + ", " + width + ") : " + area());
	}

	@Override
    void draw() {
        int h = Math.max(1, side);
        int w = Math.max(1, width);
        String row = "*".repeat(w);
        for (int i = 0; i < h; ++i) System.out.println(row);
        System.out.println();
    }

    @Override
    double area() {
        return (double) side * width;
    }
}

class ListNode {
	Shape info;
	ListNode next;

	ListNode(Shape s, ListNode n) {
		info = s;
		next = n;
	}
}

class Picture {
	private ListNode head;

	Picture() {
		head = null;
	}

	void add(Shape sh) {
		head = new ListNode(sh, head);
	}

	void printAll() {
		for (ListNode p = head; p != null; p = p.next) {
			p.info.print();
		}
	}
	System.out.println();

	void drawAll() {
		for (ListNode p = head; p != null; p = p.next) {
			p.info.draw();
		}
	}

	double totalArea() {
		double sum = 0.0;
		for (ListNode p = head; p != null; p = p.next) {
			sum += p.info.area();
		}
		return sum;
	}
}

public class mainClass {
	public static void main(String[] args) {
		int arg1 = Integer.parseInt(args[0]);
        int arg2 = Integer.parseInt(args[1]);
        int arg1b = Math.max(1, arg1 - 1);
        int arg2b = Math.max(1, arg2 - 1);

        Picture pic = new Picture();

        pic.add(new Triangle("SecondTriangle", arg1b, arg2b));
        pic.add(new Triangle("FirstTriangle", arg1,  arg2));

        pic.add(new Circle("SecondCircle", arg1b));
        pic.add(new Circle("FirstCircle",  arg1));

        pic.add(new Square("SecondSquare", arg1b));
        pic.add(new Square("FirstSquare",  arg1));

        pic.add(new Rectangle("SecondRectangle", arg1b, arg2b));
        pic.add(new Rectangle("FirstRectangle",  arg1,  arg2));

        pic.printAll();

        pic.drawAll();

        System.out.printf("Total : %.2f%n", pic.totalArea());
	}
}
