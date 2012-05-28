
BIN = bin

BUILD = build

OPENCV_INCLUDE = `pkg-config opencv --cflags`
OPENCV = `pkg-config opencv --cflags --libs`

OBJECTS = $(BUILD)/main.o \
			 $(BUILD)/core/core.o \
			 $(BUILD)/gui/configuration.o \
		    $(BUILD)/gui/core.o \
          $(BUILD)/gui/main_menu.o \
			 $(BUILD)/structures/Program_Options.o \
			 $(BUILD)/utilities/string_utilities.o


all: $(BIN)/VLTIF


######################################### 
#          PRIMARY EXECUTABLE           #
#########################################
$(BIN)/VLTIF: $(OBJECTS) $(BUILD) $(BUILD)/gui $(BUILD)/utilities
	g++ -o $@ $(OBJECTS) $(OPENCV) -lncurses



$(BUILD)/main.o: src/main.cpp $(BUILD)/gui $(BUILD)/utilities
	g++ $< -c -o $@ $(OPENCV_INCLUDE)

$(BUILD)/core/core.o: src/core/core.cpp $(BUILD)/core
	g++ $< -c -o $@

$(BUILD)/gui/configuration.o: src/gui/configuration.cpp $(BUILD)/gui
	g++ $< -c -o $@

$(BUILD)/gui/core.o: src/gui/core.cpp
	g++ $< -c -o $@

$(BUILD)/gui/main_menu.o: src/gui/main_menu.cpp
	g++ $< -c -o $@ $(OPENCV_INCLUDE)

$(BUILD)/structures/Program_Options.o: src/structures/Program_Options.cpp $(BUILD)/structures
	g++ $< -c -o $@ 

$(BUILD)/utilities/string_utilities.o: src/utilities/string_utilities.cpp
	g++ $< -c -o $@ 


check:
	mkdir -p build
	g++ src/test/unit_test.cpp -o build/unit_test
	./build/unit_test

clean:
	rm -rf $(BUILD)/*


$(BIN):
	@mkdir -p $(BIN)

$(BUILD):
	@mkdir -p $(BUILD)

$(BUILD)/core:
	@mkdir -p $(BUILD)/core

$(BUILD)/gui:
	@mkdir -p $(BUILD)/gui

$(BUILD)/structures:
	@mkdir -p $(BUILD)/structures

$(BUILD)/utilities:
	@mkdir -p $(BUILD)/utilities
