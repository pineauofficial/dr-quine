# Variables
ASM=nasm
ASMFLAGS=-f elf64
CC=gcc
CFLAGS=-no-pie
TARGET=Sully
SOURCES=$(TARGET).s

# Règles
all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) $< -o $@

$(TARGET).o: $(SOURCES)
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(TARGET) $(TARGET).o

.PHONY: all clean
