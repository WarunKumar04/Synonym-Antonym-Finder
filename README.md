# Synonym and Antonym Finder
This project is a simple yet functional Synonym and Antonym Finder written in 8086 Assembly Language. It allows users to input a word and retrieve its synonyms or antonyms using a command-line interface. The program leverages the Irvine32 library for input and output operations and is structured modularly for better readability and maintainability.

# Features
Synonym Lookup: Finds and displays synonyms for a given word by reading from a predefined Synonyms.txt file.

Antonym Lookup: Finds and displays antonyms for a given word using the Antonyms.txt file.

Input Validation: Ensures the input word consists of valid English alphabet characters only.

Case-Insensitive Matching: Converts user input to lowercase for consistent and accurate results.

File Handling: Reads and processes data from external text files to find relevant results.

# Program Structure
The program is divided into multiple procedures for modularity:

start: Entry point to prompt the user for input and guide through options (find synonyms, find antonyms, or exit).

find_synonymm: Reads the synonym file and displays synonyms for the entered word.

valid_inputt: Validates the user input for alphabetic characters.

check_for_the_word: Helper function to verify if characters in the input are valid.

convert_the_word_into_lowercase: Converts user input to lowercase for case-insensitive matching.

find_antonym: Reads the antonym file and displays antonyms for the entered word.

quit11: Exits the program gracefully with a thank-you message.

escapee: Handles invalid inputs and prompts for re-entry.

main: Displays a welcome message and initiates the program.

# How to Use
Run the Program: Compile and execute the program using an assembler that supports the Irvine32 library.

Select an Option:
Find Synonyms: Enter a word to search for synonyms in Synonyms.txt.

Find Antonyms: Enter a word to search for antonyms in Antonyms.txt.

Exit: Exit the program gracefully.

Follow Prompts:

Enter words when prompted.

If the input is invalid, re-enter a valid word as instructed.

# Prerequisites
Assembler: TASM/MASM or any assembler that supports the Irvine32 library.

Irvine32 Library: Ensure that the Irvine32 library is properly installed and configured.

Text Files: Include Synonyms.txt and Antonyms.txt in the same directory as the executable.

# File Handling
Synonyms.txt: Contains pairs of words and their synonyms.

Antonyms.txt: Contains pairs of words and their antonyms.

The program reads these files, processes them into buffers, and performs matching to find results.
