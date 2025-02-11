# Template makefile

# **************************************
#
# Compiler flags
#
CXX = g++
CXXFLAGS = -Wall -Wextra -Werror -std=c++20 -lpthread


# **************************************
#
# Project files
#
SRCS = main.cpp mandelbrot.cpp
OBJS = $(SRCS:.cpp=.o)
EXE  = MandelBrot


# **************************************
#
# Debug build settings
#
DBGDIR = debug
DBGEXE = $(DBGDIR)/$(EXE)
DBGOBJS = $(addprefix $(DBGDIR)/, $(OBJS))
DBGCFLAGS = -g -O0 -DDEBUG

# **************************************
#
# Release build settings
#
RELDIR = release
RELEXE = $(RELDIR)/$(EXE)
RELOBJS = $(addprefix $(RELDIR)/, $(OBJS))
RELCFLAGS = -O3 -DNDEBUG

.PHONY: all clean debug prep release remake


# **************************************
#
# Default build
#
all: prep release


# **************************************
#
# Debug rules
#
debug: $(DBGEXE)

$(DBGEXE): $(DBGOBJS)
	$(CXX) $(CXXFLAGS) $(DBGCFLAGS) -o $(DBGEXE) $^

$(DBGDIR)/%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $(DBGCFLAGS) -o $@ $<


# **************************************
#
# Release rules
#
release: $(RELEXE)

$(RELEXE): $(RELOBJS)
	$(CXX) $(CXXFLAGS) $(RELCFLAGS) -o $(RELEXE) $^

$(RELDIR)/%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $(RELCFLAGS) -o $@ $<

# **************************************
#
# Other rules
#
prep:
	@mkdir -p $(DBGDIR) $(RELDIR)

remake: clean all

clean:
	rm -f $(RELEXE) $(RELOBJS) $(DBGEXE) $(DBGOBJS)
