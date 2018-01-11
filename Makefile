# Hey Emacs, this is a -*- makefile -*-
#============================================================================
# make              : Same as "make all"
#   make all          : Build the entire project
#   make clean        : Clean out built project files.
#   make coff         : Convert ELF to AVR COFF.
#   make extcoff      : Convert ELF to AVR Extended COFF.
#   make install      : Same as "make program"
#   make program      : Write the hex file to the device, using avrdude.
#                       Customize the avrdude settings below first!
#   make size         : Display size of target file.
#   make debugger     : Generate script for launching debugger.
#                     : Customize for simulavr or avarice below first!
#   make filename.s   : Just compile filename.c into the assembler code only.
#   make filename.i   : Create a preprocessed source file for use in submitting
#                       bug reports to the GCC project.
#   make help         : Print out a summary of make important targets.     
#
# To rebuild the project, do "make clean" then "make all".
#============================================================================
#============================================================================
#this source file is under General Public License version 3.


# Target file name (without extension).
TARGET = myproject

# List C source files here. (C dependencies are automatically generated.)
SRC = encMain.c i2c.c i2cBang1602.c encoder.c
#SRC +=  menu.c
#(#C++ dependencies are automatically generated.)
CPPSRC = 

# List Assembler source files here.
#     They must end in a capital .S. 
ASRC =

# MCU suffix

MS = 328p

# MCU name
MCU = atmega$(MS)

# programer MCU
PMCU = m$(MS)

# Processor frequency.
#     This will define a symbol, F_CPU, in all source code files equal to the 
#     processor frequency. You can then use this symbol in your source code to 
#     calculate timings. Do NOT tack on a 'UL' at the end, this will be done
#     automatically to create a 32-bit value in your source code.
#     Typical values are:
#         F_CPU =  1000000
#         F_CPU =  1843200
#         F_CPU =  2000000
#         F_CPU =  3686400
#         F_CPU =  4000000
#         F_CPU =  7372800
#         F_CPU =  8000000
#         F_CPU = 11059200
#         F_CPU = 14745600
#         F_CPU = 16000000
#         F_CPU = 18432000
#         F_CPU = 20000000
F_CPU = 8000000


# List any extra directories to look for include files (.h, etc) here.
#     Each directory must be seperated by a space.
#     Use forward slashes for directory separators.
#     For a directory that has spaces, enclose it in quotes.
#     See the "Library Options" section below if you are trying to add
#     libraries to the project.
EXTRAINCDIRS = 

#---------------- Programmer Options (avrdude) ----------------

# MCU part number to use with programmer
# Defaults to PROGRAMMER_MCU=$(MCU)
# Override this in case the programer used doesn't accept the same MCU name 
# as avr-gcc.
PROGRAMMER_MCU=$(PMCU)

# programmer hardware
# Type: 'avrdude -c ?' to get a full listing.
AVRDUDE_PROGRAMMER = arduino
# the port used by the programmer
AVRDUDE_PORT = /dev/ttyUSB0

#----------------------------------------------------------------------------
# End of basic configuration. Start of tweaky configuration
#----------------------------------------------------------------------------

#---------------- Build options ----------------
# Compiler optimization level, can be [0, 1, 2, 3, s]. 
#     0 = turn off optimization. s = optimize for size.
#     (Note: 3 is not always the best optimization level. See avr-libc FAQ.)
OPT = s

# Output format. (can be srec, ihex, binary)
FORMAT = ihex

# Debugging format.
#     Native formats for AVR-GCC's -g are dwarf-2 [default] or stabs.
#     AVR Studio 4.10 requires dwarf-2.
#     AVR [Extended] COFF format requires stabs, plus an avr-objcopy run.
DEBUG = dwarf-2

# Compiler flag to set the C Standard level.
#     c89   = "ANSI" C
#     gnu89 = c89 plus GCC extensions
#     c99   = ISO C99 standard (not yet fully implemented)
#     gnu99 = c99 plus GCC extensions
CSTANDARD = -std=gnu99

# Place -D or -U options here for C sources
CDEFS = -DF_CPU=$(F_CPU)UL
#CDEFS +=

# Place -D or -U options here for ASM sources
ADEFS = -DF_CPU=$(F_CPU)
#ADEFS += 

# Place -D or -U options here for C++ sources
CPPDEFS = -DF_CPU=$(F_CPU)UL
#CPPDEFS += -D__STDC_LIMIT_MACROS
#CPPDEFS += -D__STDC_CONSTANT_MACROS
#CPPDEFS += 

# Object files directory
#     To put object files in current directory, use a dot (.), do NOT make
#     this an empty or blank macro!
OBJDIR = obj
#~ OBJDIR = .

# Dependency files directory
#     To put dependency files in current directory, use a dot (.), do NOT
#     make this an empty or blank macro!
DEPSDIR = deps

#---------------- Library options ----------------
# Minimalistic printf version
PRINTF_LIB_MIN = -Wl,-u,vfprintf -lprintf_min

# Floating point printf version (requires MATH_LIB = -lm below)
PRINTF_LIB_FLOAT = -Wl,-u,vfprintf -lprintf_flt

# If this is left blank, then it will use the Standard printf version.
PRINTF_LIB = 
#PRINTF_LIB = $(PRINTF_LIB_MIN)
PRINTF_LIB = $(PRINTF_LIB_FLOAT)

# Minimalistic scanf version
SCANF_LIB_MIN = -Wl,-u,vfscanf -lscanf_min

# Floating point + %[ scanf version (requires MATH_LIB = -lm below)
SCANF_LIB_FLOAT = -Wl,-u,vfscanf -lscanf_flt

# If this is left blank, then it will use the Standard scanf version.
SCANF_LIB = 
#SCANF_LIB = $(SCANF_LIB_MIN)
#SCANF_LIB = $(SCANF_LIB_FLOAT)

# If this is left blank, then it will not include the std math lib.
MATH_LIB = 
MATH_LIB = -lm

# List any extra libraries you want to use here.
#     The name of the library must be of the form lib<name>.a, in
#     which case you would use "-l<name>" (e.g. libfoo.a => -lfoo).
#     Each name must be seperated by a space and have -l in front. 
EXTRA_LIBS =

# List any extra directories to look for libraries here.
#     Each directory must be seperated by a space.
#     Use forward slashes for directory separators.
#     For a directory that has spaces, enclose it in quotes.
EXTRALIBDIRS = 


#---------------- Compiler options: C ----------------
#  -g*:          generate debugging information
#  -O*:          optimization level
#  -f...:        tuning, see GCC manual and avr-libc documentation
#  -Wall...:     warning level
#  -Wa,...:      tell GCC to pass this to the assembler.
#    -adhlns...: create assembler listing
CFLAGS = 
CFLAGS += -g$(DEBUG)
CFLAGS += $(CDEFS)
CFLAGS += -O$(OPT)
CFLAGS += -funsigned-char
CFLAGS += -funsigned-bitfields
CFLAGS += -fpack-struct
CFLAGS += -fshort-enums
CFLAGS += -Wall
CFLAGS += -Wstrict-prototypes
#CFLAGS += -mshort-calls
#CFLAGS += -fno-unit-at-a-time
#CFLAGS += -Wundef
#CFLAGS += -Wunreachable-code
#CFLAGS += -Wsign-compare
CFLAGS += -Wa,-adhlns=$(<:%.c=$(OBJDIR)/%.lst)
CFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))
CFLAGS += $(CSTANDARD)


#---------------- Compiler options: C++ ----------------
#  -g*:          generate debugging information
#  -O*:          optimization level
#  -f...:        tuning, see GCC manual and avr-libc documentation
#  -Wall...:     warning level
#  -Wa,...:      tell GCC to pass this to the assembler.
#    -adhlns...: create assembler listing
CPPFLAGS = 
CPPFLAGS += -g$(DEBUG)
CPPFLAGS += $(CPPDEFS)
CPPFLAGS += -O$(OPT)
CPPFLAGS += -funsigned-char
CPPFLAGS += -funsigned-bitfields
CPPFLAGS += -fpack-struct
CPPFLAGS += -fshort-enums
CPPFLAGS += -fno-exceptions
CPPFLAGS += -Wall
CPPFLAGS += -Wundef
#CPPFLAGS += -mshort-calls
#CPPFLAGS += -fno-unit-at-a-time
#CPPFLAGS += -Wstrict-prototypes
#CPPFLAGS += -Wunreachable-code
#CPPFLAGS += -Wsign-compare
CPPFLAGS += -Wa,-adhlns=$(<:%.cpp=$(OBJDIR)/%.lst)
CPPFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))
#CPPFLAGS += $(CSTANDARD)


#---------------- Assembler options ----------------
#  -Wa,...:   tell GCC to pass this to the assembler.
#  -adhlns:   create listing
#  -gstabs:   have the assembler create line number information; note that
#             for use in COFF files, additional information about filenames
#             and function names needs to be present in the assembler source
#             files
#  -listing-cont-lines: Sets the maximum number of continuation lines of hex 
#       dump that will be displayed for a given single line of source input.
ASFLAGS = $(ADEFS) -Wa,-adhlns=$(<:%.S=$(OBJDIR)/%.lst),-gstabs,--listing-cont-lines=100


#---------------- External memory options ----------------

# 64 KB of external RAM, starting after internal RAM (ATmega128!),
# used for variables (.data/.bss) and heap (malloc()).
#EXTMEMOPTS = -Wl,-Tdata=0x801100,--defsym=__heap_end=0x80ffff

# 64 KB of external RAM, starting after internal RAM (ATmega128!),
# only used for heap (malloc()).
#EXTMEMOPTS = -Wl,--section-start,.data=0x801100,--defsym=__heap_end=0x80ffff

EXTMEMOPTS =


#---------------- Linker options ----------------
#  -Wl,...:     tell GCC to pass this to linker.
#    -Map:      create map file
#    --cref:    add cross reference to  map file
LDFLAGS = -Wl,-Map=$(TARGET).map,--cref
LDFLAGS += $(EXTMEMOPTS)
LDFLAGS += $(patsubst %,-L%,$(EXTRALIBDIRS))
LDFLAGS += $(PRINTF_LIB) $(SCANF_LIB) $(MATH_LIB) $(EXTRA_LIBS)
#LDFLAGS += -T linker_script.x


#---------------- AVRDUDE tweaks ----------------
# Uncomment the following if you want avrdude's erase cycle counter.
# Note that this counter needs to be initialized first using -Yn,
# see avrdude manual.
#AVRDUDE_ERASE_COUNTER = -y

# Uncomment the following if you do /not/ wish a verification to be
# performed after programming the device.
#AVRDUDE_NO_VERIFY = -V

# Increase verbosity level.  Please use this when submitting bug
# reports about avrdude. See <http://savannah.nongnu.org/projects/avrdude> 
# to submit bug reports.
#AVRDUDE_VERBOSE = -v -v

# Enable one or both for flash or/and EEPROM
AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex
#AVRDUDE_WRITE_EEPROM = -U eeprom:w:$(TARGET).eep

AVRDUDE_FLAGS = -p $(PROGRAMMER_MCU) -P $(AVRDUDE_PORT) -c $(AVRDUDE_PROGRAMMER) -b 57600
AVRDUDE_FLAGS += $(AVRDUDE_NO_VERIFY)
AVRDUDE_FLAGS += $(AVRDUDE_VERBOSE)
AVRDUDE_FLAGS += $(AVRDUDE_ERASE_COUNTER)


#---------------- Debugging options ----------------

# Set the debugging back-end to either avarice or simulavr.
DEBUG_BACKEND = simulavr
# DEBUG_BACKEND = avarice

# Debugging port used to communicate between GDB / avarice / simulavr.
DEBUG_PORT = 1212
# DEBUG_PORT = 4242

# Debugging host used to communicate between GDB / avarice / simulavr, normally
#     just set to localhost unless doing some sort of crazy debugging when 
#     avarice is running on a different computer.
DEBUG_HOST = localhost

# For simulavr only - target MCU frequency.
DEBUG_MFREQ = $(F_CPU)

# Only ddd is supported at present!
DEBUG_UI = ddd

# Name of script generated that starts debugger.
DEBUG_SCRIPT="_start_debugger_"

# GDB Init Filename.
GDBINIT_FILE = __gdbinit_$(TARGET)

# When using avarice settings for the JTAG
JTAG_DEV = /dev/com1

#============================================================================
# End configuration.
#     You really shouldn't need to do anything below here (unless you are 
#     building a library).
#============================================================================

# Define programs and commands.
SHELL = sh
CC = avr-gcc
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
SIZE = avr-size
AR = avr-ar rcs
NM = avr-nm
AVRDUDE = avrdude
REMOVE = rm -f
REMOVEDIR = rm -rf
COPY = cp


# Define Messages
# English
MSG_ERRORS_NONE = Errors: none
MSG_ELFNOTFOUND = 'Target .elf file not found. Is it built?'
MSG_COFF = '~~~ Converting to AVR COFF: '
MSG_EXTENDED_COFF = '~~~ Converting to AVR extended COFF: '
MSG_FLASH = '~~~ Creating load file for flash: '
MSG_EEPROM = '~~~ Creating load file for EEPROM: '
MSG_EXTENDED_LISTING = '~~~ Creating extended listing: '
MSG_SYMBOL_TABLE = '~~~ Creating symbol table: '
MSG_LINKING = '~~~ Linking: '
MSG_COMPILING = '~~~ Compiling C: '
MSG_COMPILING_CPP = '~~~ Compiling C++: '
MSG_ASSEMBLING = '~~~ Assembling: '
MSG_CLEANING = '~~~ Cleaning project: '
MSG_CREATING_LIBRARY = '~~~ Creating library: '


# Define all object files.
OBJ = $(SRC:%.c=$(OBJDIR)/%.o) $(CPPSRC:%.cpp=$(OBJDIR)/%.o) $(ASRC:%.S=$(OBJDIR)/%.o) 

# Define all listing files.
LST = $(SRC:%.c=$(OBJDIR)/%.lst) $(CPPSRC:%.cpp=$(OBJDIR)/%.lst) $(ASRC:%.S=$(OBJDIR)/%.lst) 


# Compiler flags to generate dependency files.
GENDEPFLAGS = -MMD -MP -MF $(DEPSDIR)/$(@F).d
#~ GENDEPFLAGS = -MMD -MF $(DEPSDIR)/$(@F).d


# Combine all necessary flags and optional flags.
# Add target processor to flags.
ALL_CFLAGS = -mmcu=$(MCU) -I. $(CFLAGS) $(GENDEPFLAGS)
ALL_CPPFLAGS = -mmcu=$(MCU) -I. -x c++ $(CPPFLAGS) $(GENDEPFLAGS)
ALL_ASFLAGS = -mmcu=$(MCU) -I. -x assembler-with-cpp $(ASFLAGS)

#---------------- Targets ----------------
# Default target.
all: build

# Change the build target as needed to build a HEX file or a library.
build: elf hex eep lss sym
#build: lib

# Parts
elf: $(TARGET).elf
hex: $(TARGET).hex
eep: $(TARGET).eep
lss: $(TARGET).lss
sym: $(TARGET).sym
LIBNAME=lib$(TARGET).a
lib: $(LIBNAME)

# Display size of file.
HEXSIZE = $(SIZE) --target=$(FORMAT) $(TARGET).hex
ELFSIZE = $(SIZE) --mcu=$(MCU) --format=avr $(TARGET).elf

size:
	@if test -f $(TARGET).elf; then $(ELFSIZE); 2>/dev/null; \
	else echo $(MSG_ELFNOTFOUND) ; fi

# Display compiler version information.
gccversion : 
	@$(CC) --version

# Program the device.  
install: program

program: $(TARGET).hex $(TARGET).eep
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH) $(AVRDUDE_WRITE_EEPROM)

# Convert ELF to COFF for use in debugging / simulating in AVR Studio or VMLAB.
COFFCONVERT = $(OBJCOPY) --debugging
COFFCONVERT += --change-section-address .data-0x800000
COFFCONVERT += --change-section-address .bss-0x800000
COFFCONVERT += --change-section-address .noinit-0x800000
COFFCONVERT += --change-section-address .eeprom-0x810000


coff: $(TARGET).elf
	@echo
	@echo $(MSG_COFF) $(TARGET).cof
	$(COFFCONVERT) -O coff-avr $< $(TARGET).cof


extcoff: $(TARGET).elf
	@echo
	@echo $(MSG_EXTENDED_COFF) $(TARGET).cof
	$(COFFCONVERT) -O coff-ext-avr $< $(TARGET).cof


# Create final output files (.hex, .eep) from ELF output file.
%.hex: %.elf
	@echo
	@echo $(MSG_FLASH) $@
	$(OBJCOPY) -O $(FORMAT) -R .eeprom -R .fuse -R .lock $< $@

%.eep: %.elf
	@echo
	@echo $(MSG_EEPROM) $@
	-$(OBJCOPY) -j .eeprom --set-section-flags=.eeprom="alloc,load" \
	--change-section-lma .eeprom=0 --no-change-warnings -O $(FORMAT) $< $@ || exit 0

# Create extended listing file from ELF output file.
%.lss: %.elf
	@echo
	@echo $(MSG_EXTENDED_LISTING) $@
	$(OBJDUMP) -h -S -z $< > $@

# Create a symbol table from ELF output file.
%.sym: %.elf
	@echo
	@echo $(MSG_SYMBOL_TABLE) $@
	$(NM) -n $< > $@


# Create library from object files.
.SECONDARY : $(TARGET).a
.PRECIOUS : $(OBJ)
%.a: $(OBJ)
	@echo
	@echo $(MSG_CREATING_LIBRARY) $@
	$(AR) $@ $(OBJ)


# Link: create ELF output file from object files.
.SECONDARY : $(TARGET).elf
.PRECIOUS : $(OBJ)
%.elf: $(OBJ)
	@echo
	@echo $(MSG_LINKING) $@
	$(CC) $(ALL_CFLAGS) $^ --output $@ $(LDFLAGS)


# Compile: create object files from C source files.
$(OBJDIR)/%.o : %.c
	@echo
	@echo $(MSG_COMPILING) $<
	$(CC) -c $(ALL_CFLAGS) $< -o $@ 

# (mfk) Compile "make foo.o" from C in $(OBJDIR)/foo.o
%.o : %.c
	@echo
	@echo $(MSG_COMPILING) $<
	$(CC) -c $(ALL_CFLAGS) $< -o $(OBJDIR)/$@ 


# Compile: create object files from C++ source files.
$(OBJDIR)/%.o : %.cpp
	@echo
	@echo $(MSG_COMPILING_CPP) $<
	$(CC) -c $(ALL_CPPFLAGS) $< -o $@ 

# (mfk) Compile "make foo.o" from C ++in $(OBJDIR)/foo.o
%.o : %.cpp
	@echo
	@echo $(MSG_COMPILING_CPP) $<
	$(CC) -c $(ALL_CPPFLAGS) $< -o $(OBJDIR)/$@ 


# Compile: create assembler files from C source files.
%.s : %.c
	@echo "DEBUG ASSEMBLER FROM C"
	$(CC) -S $(ALL_CFLAGS) $< -o $@


# Compile: create assembler files from C++ source files.
%.s : %.cpp
	@echo "DEBUG ASSEMBLER FROM CPP"
	$(CC) -S $(ALL_CPPFLAGS) $< -o $@


# Assemble: create object files from assembler source files.
$(OBJDIR)/%.o : %.S
	@echo
	@echo $(MSG_ASSEMBLING) $<
	$(CC) -c $(ALL_ASFLAGS) $< -o $@

# (mfk) Assemble "make foo.o" from assembler sources in $(OBJDIR)/foo.o
%.o : %.S
	@echo
	@echo $(MSG_ASSEMBLING) $<
	$(CC) -c $(ALL_ASFLAGS) $< -o $(OBJDIR)/$@


# Create preprocessed source for use in sending a bug report.
%.i : %.c
	@echo "DEBUG Create preprocessed source for use in sending a bug report"
	$(CC) -E -mmcu=$(MCU) -I. $(CFLAGS) $< -o $@ 


# Target: clean project.
clean:
	$(REMOVE) $(TARGET).hex
	$(REMOVE) $(TARGET).eep
	$(REMOVE) $(TARGET).cof
	$(REMOVE) $(TARGET).elf
	$(REMOVE) $(TARGET).map
	$(REMOVE) $(TARGET).sym
	$(REMOVE) $(TARGET).lss
ifeq ($(OBJDIR), .)
	$(REMOVE) $(SRC:%.c=$(OBJDIR)/%.o)
	$(REMOVE) $(SRC:%.c=$(OBJDIR)/%.lst)
else
	$(REMOVEDIR) $(OBJDIR)
endif
	$(REMOVE) $(SRC:.c=.s)
	$(REMOVE) $(SRC:.c=.d)
	$(REMOVE) $(SRC:.c=.i)
	$(REMOVE) $(GDBINIT_FILE) $(DEBUG_SCRIPT)
	$(REMOVEDIR) $(DEPSDIR)

#----- debugging support -----
# Generate avr-gdb config/init file which does the following:
#     define the reset signal, load the target file, connect to target, and set 
#     a breakpoint at main().
gdbinit: 
	@$(REMOVE) $(GDBINIT_FILE)
	@echo define reset                              >> $(GDBINIT_FILE)
	@echo SIGNAL SIGHUP                             >> $(GDBINIT_FILE)
	@echo end                                       >> $(GDBINIT_FILE)
	@echo file $(TARGET).elf                        >> $(GDBINIT_FILE)
	@echo target remote $(DEBUG_HOST):$(DEBUG_PORT) >> $(GDBINIT_FILE)
ifeq ($(DEBUG_BACKEND),simulavr)
	@echo load                                      >> $(GDBINIT_FILE)
endif
	@echo break main                                >> $(GDBINIT_FILE)

# Generate a script for launching debugger+simulator/emulator
debugger: gdbinit $(TARGET).elf
	@echo "#!/bin/bash"                                        > $(DEBUG_SCRIPT)
	@echo ""                                                  >> $(DEBUG_SCRIPT)
	@echo "if which gxmessage > /dev/null ; then"             >> $(DEBUG_SCRIPT)
	@echo "    XMESSAGE=gxmessage"                            >> $(DEBUG_SCRIPT)
	@echo "else"                                              >> $(DEBUG_SCRIPT)
	@echo "    XMESSAGE=xmessage"                             >> $(DEBUG_SCRIPT)
	@echo "fi"                                                >> $(DEBUG_SCRIPT)
	@echo ""                                                  >> $(DEBUG_SCRIPT)
ifeq ($(DEBUG_BACKEND), avarice)
	@echo "# TODO: avarice pre-debugger launch stuff"         >> $(DEBUG_SCRIPT)
else
	@echo "if [[ ! -z \`pgrep -u \$${USERNAME} simulavr\` ]];then">> $(DEBUG_SCRIPT)
	@echo "    echo \"Not launching simulavr: seems already to be running.\"" >> $(DEBUG_SCRIPT)
	@echo "else"                                              >> $(DEBUG_SCRIPT)
	@echo "    xterm -e \"simulavr --gdbserver --device $(MCU) --clock-freq $(DEBUG_MFREQ) --disp-prog simulavr-disp; read -p 'Press <ENTER> to close.'\"  &" >> $(DEBUG_SCRIPT)
	@echo "fi"                                                >> $(DEBUG_SCRIPT)
endif
	@echo ""                                                  >> $(DEBUG_SCRIPT)
	@echo "launch=0"                                          >> $(DEBUG_SCRIPT)
	@echo "if [[ ! -z \`pgrep -u \$${USERNAME} $(DEBUG_UI)\` ]];then">> $(DEBUG_SCRIPT)
	@echo "    \$$XMESSAGE -buttons No:101,Yes:0 -default No \"An instance of $(DEBUG_UI) is already running." >> $(DEBUG_SCRIPT)
	@echo ""                                                  >> $(DEBUG_SCRIPT)
	@echo "Launch anyway?\""                                  >> $(DEBUG_SCRIPT)
	@echo "    launch=\$$?"                                   >> $(DEBUG_SCRIPT)
	@echo "fi"                                                >> $(DEBUG_SCRIPT)
	@echo ""                                                  >> $(DEBUG_SCRIPT)
	@echo "if [[ \$$launch -eq 0 ]] ; then"                   >> $(DEBUG_SCRIPT)
	@echo "    $(DEBUG_UI) --debugger avr-gdb -x $(GDBINIT_FILE)"     >> $(DEBUG_SCRIPT)
	@echo "fi"                                                >> $(DEBUG_SCRIPT)
	@echo ""                                                  >> $(DEBUG_SCRIPT)
ifeq ($(DEBUG_BACKEND), avarice)
	@echo "# TODO: avarice pre-debugger launch stuff"         >> $(DEBUG_SCRIPT)
else
	@echo "if [[ ! -z \`pgrep -u \$${USERNAME} simulavr\` ]];then">> $(DEBUG_SCRIPT)
	@echo "    \$$XMESSAGE -timeout 3 -buttons Ok:0 -default Ok \"Note: simulavr is still running.\"  &" >> $(DEBUG_SCRIPT)
	@echo "fi"                                                >> $(DEBUG_SCRIPT)
endif
	@chmod u+x $(DEBUG_SCRIPT)

#----- misc. -----
help:
	@echo  "make         : Build the entire project"
	@echo  "make clean   : Clean out built project files."
	@echo  "make size    : Display size of target file."
	@echo  "make install : Write the hex file to the device using avrdude;"
	@echo  "               Customize the avrdude settings in the Makefile first!"
	@echo  "make debugger: Generate script for launching debugger;"
	@echo  "               Customize for simulavr or avarice in the Makefile first!"
	@echo  "To rebuild the project, do \"make clean\" then \"make all\"."

# Create object files directory
$(shell mkdir $(OBJDIR) 2>/dev/null)

# Include the dependency files.
-include $(shell mkdir $(DEPSDIR) 2>/dev/null) $(wildcard $(DEPSDIR)/*)

# Listing of phony targets.
.PHONY : all gccversion build elf hex eep lss sym coff extcoff \
clean clean_list program gdbinit \
size debugger install help
