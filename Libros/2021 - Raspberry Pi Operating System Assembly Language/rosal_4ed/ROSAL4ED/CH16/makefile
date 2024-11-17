OBJX = prog16a
OBJS = prog16a.o

ifdef GFLAG
	STATUS = -g
else
	STATUS =
endif

%.o : %.s
	as $(STATUS) $< -o $@ 
	
debugfile: $(OBJS)
	ld -o $(OBJX) $(OBJS)
	
gdbdebug: $(OBJX)
		gdb $(OBJX)

clean:
	rm -f *.o $(OBJS)
	rm -f *.o $(OBJX)
