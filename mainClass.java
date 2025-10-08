printf("ICS143A>");
	user_input = input_getc();
	if (user_input.equals("whoami")){
		print("Yatong Xing");
	} else if (user_input.equals("exit")){
		sys.exit()
	} else {
		print("invalid command");
	}
class Shapes {
	String name;
	Shapes (String n) {
		this.name = n;
	}

	abstract void print();
	abstract void draw();
	abstract double area();
}

class Circle extends Shapes {
	private 
	
}

class Square extends Shapes {
}

class Triangle extends Shapes {
}

