printf("ICS143A>");
	user_input = input_getc();
	if (user_input.equals("whoami")){
		print("Yatong Xing");
	} else if (user_input.equals("exit")){
		sys.exit()
	} else {
		print("invalid command");
	}


