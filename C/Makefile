# Variables
CC=gcc
CFLAGS=-Wall -Wextra -Werror
TARGET=Colleen
SOURCES=$(TARGET).c

# Règles
all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) $< -o $@

$(TARGET).o: $(SOURCES)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(TARGET).o

.PHONY: all clean
