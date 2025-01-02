; project by Warun Kumar k22-4721

include Irvine32.inc
include macros.inc
BUFFER_SIZE = 100000
BUFFER_SIZE1 = 100000
start proto
check_for_the_word proto
convert_the_word_into_lowercase proto
find_synonymm proto
valid_inputt proto
escapee proto
quit11 proto
.data
	input_word byte 50 DUP(?)	
	ant byte 50 DUP(?)		
	length_of_input_word byte ? 
	
	Synonyms_of_the_word byte 200 DUP(?)
	Antonyms_of_the_word byte 200 DUP(?)

	buffer BYTE BUFFER_SIZE DUP(?)
	buffer1 BYTE BUFFER_SIZE1 DUP(?)
	
	fileHandle HANDLE ?
	fileHandle1 HANDLE ?
	
	synonym_file byte "Synonyms.txt",0
	antonym_file byte "Antonyms.txt",0

	count_spaces byte ?
	count_spaces1 byte ?
	
	syn_temp byte 300 dup(?)		
	ant_temp byte 300 dup(?)		
		


.code
main proc
	mwrite"                                             Good Morning                "
	call crlf
	mWrite "			Program To Find the synonyms & antonyms of a Word!"
	call crlf
	call crlf
    invoke start	
	exit
main endp

start proc
mwrite "if you want to search for synonyms press 1, for antonyms press 2, for exit press 3: "
	call readdec
		cmp al,1
		je find_synonym
		cmp al,2
		je find_antonym
		cmp al,3
		je quit1
		jmp escape1
	
	find_synonym:
		invoke find_synonymm

	escape1:
	    invoke escapee
		
	

	
	find_antonym:
		call crlf
		call crlf
		mov esi,0
		mov edi,0
		mov ecx,0
		mov eax,0
		mwrite "Enter a Word to search its Antonyms: "
		mov ecx,lengthof ant
		mov edx,offset ant
		call readstring
		mwrite "Length of your entered word is: "
		call writedec
		call crlf
		call crlf


	mov edx,OFFSET antonym_file
	call OpenInputFile
	mov fileHandle1,eax
	
	
	cmp eax,INVALID_HANDLE_VALUE 
	jne file_ok1 
	mWrite <"Cannot open file",0dh,0ah>
	jmp quit1
	
	file_ok1:
		
		mov edx,OFFSET buffer1
		mov ecx,BUFFER_SIZE1
		call ReadFromFile
		jnc check_buffer_size1 
		mWrite "Error reading file. " 
		call WriteWindowsMsg
		jmp close_file1
	
	check_buffer_size1:
		cmp eax,BUFFER_SIZE1 
		jb buf_size_ok1
		mWrite <"Error: Buffer too small for the file",0dh,0ah>
		jmp quit1 
	
	buf_size_ok1:
		mov buffer1[eax],0 
		mWrite "File size: "
		call WriteDec 
		call Crlf
	
	mov esi,0
	mov edi,0
	yahan1:
		mov edi,0
		mov count_spaces1,0

		break_into_strings1:
			mov dl,count_spaces1
			cmp dl,2
			je bahir1
			mov al,buffer1[esi]
			cmp al,' '
			jne s11
			add count_spaces1,1
			s11:
			mov ant_temp[edi],al
			inc esi
			inc edi
			cmp esi,752				
			jl break_into_strings1
		call crlf
		mWrite "could not find the word: "
		jmp close_file1

	bahir1:
		push esi
		dec esi
		mov ecx,esi
		mov esi,0
		check11:
			mov al,ant[esi]
			cmp al,ant_temp[esi]
			jne out21
			mov al,ant_temp[esi+1]
			cmp al,' '
			je out11
			inc esi
			loop check11

	out11:
		add esi,2
		mov edi,0
		call crlf
		mov eax, esi
		
		call writedec
		call crlf
		copy11:
			mov al,ant_temp[esi]
			mov Antonyms_of_the_word[edi],al
			mov al,ant_temp[esi+1]
			cmp al,' '
			je print11
			inc esi
			inc edi
			jmp copy11

	out21:
		pop esi
		jmp yahan1

	print11:
		call crlf
		mWrite "Antonym/s of the word is/are: "
		mov Antonyms_of_the_word[edi],0
		mov edx,offset Antonyms_of_the_word
		call writestring
		pop esi

	close_file1:
		mov eax,fileHandle1
		call CloseFile
		call crlf
		call crlf
		invoke start

	escape:
	    invoke escapee


quit1:
     invoke quit11

ret
start endp

quit11 proc
call crlf
	call crlf
	mwrite "THANK YOU!"
	call crlf
	exit
quit11 endp

escapee proc
call crlf
	  mwrite "Invalid Input"
	  call crlf
	  call crlf
	  invoke start
escapee endp

find_synonymm proc
call crlf
		call crlf
		mov eax,0
		mwrite "Enter a Word to search its synonyms: "

	mov ecx,lengthof input_word
	mov edx,offset input_word
	call readstring

	mov length_of_input_word,al
	movzx ecx,al		

	invoke check_for_the_word 
	
	cmp eax,1			
	je valid_input		
	
	
	call crlf
	mwrite "The word you entered includes atleast one letter that is not from english alphabets."
	call crlf
	mwrite "Your word should include english alphabets eg: (amazing)"
	call crlf
	call crlf
	invoke start

	valid_input:
		invoke valid_inputt
ret
find_synonymm endp

valid_inputt proc
mwrite "The length of your entered word is: "
		mov al,length_of_input_word
		call writedec
	
	movzx ecx,al 
	invoke convert_the_word_into_lowercase 
	call crlf
	call crlf

	
	mov edx,OFFSET synonym_file
	call OpenInputFile
	mov fileHandle,eax
	
	
	cmp eax,INVALID_HANDLE_VALUE
	jne valid_file 
	mWrite <"Cannot open file",0dh,0ah>
	jmp quit 
	
	
	valid_file:
		
		mov edx,OFFSET buffer 
		mov ecx,BUFFER_SIZE
		call writedec
		
		call ReadFromFile 
		jnc check_buffer_size 
		mWrite "Error reading file. " 
		call dumpregs
		call WriteWindowsMsg
		call dumpregs
		jmp close_file
	
	call writedec
	
	check_buffer_size:
		cmp eax,BUFFER_SIZE 
		jb buf_size_ok
		mWrite <"Error: Buffer too small for the file",0dh,0ah>
		jmp quit 
	
	buf_size_ok:
		mov buffer[eax],0 
		mWrite "File size: "
		call WriteDec
		call Crlf
	
 	mov esi,0
	mov edi,0
	
	yahan: 
		mov edi,0
		mov count_spaces,0

		break_into_strings:
			mov dl,count_spaces
			cmp dl,2
			je bahir
			mov al,buffer[esi]
			cmp al,' '
			jne s1
			add count_spaces,1
			s1:
			mov syn_temp[edi],al
			inc esi
			inc edi
			cmp esi,752			
			jl break_into_strings
		call crlf
		mWrite "could not find the word: "
		jmp close_file

	bahir:
		push esi
		dec esi
		mov ecx,esi
		mov esi,0
		check1:
			mov al,input_word[esi]
			cmp al,syn_temp[esi]
			jne out2
			mov al,syn_temp[esi+1]
			cmp al,' '
			je out1
			inc esi
		loop check1

	out1:
		add esi,2
		mov edi,0
		copy1:
			mov al,syn_temp[esi]
			mov Synonyms_of_the_word[edi],al
			mov al,syn_temp[esi+1]
			cmp al,' '
			je print1
			inc esi
			inc edi
		jmp copy1
			
	out2:
		pop esi
		jmp yahan

	print1:
		call crlf
		mWrite "Synonyms of the word are: "
		mov Synonyms_of_the_word[edi],0
		mov edx,offset Synonyms_of_the_word
		call writestring
		pop esi
		
	close_file:
		mov eax,fileHandle
		call CloseFile
		jmp f1
		quit:
			
			mov eax,fileHandle
			call CloseFile
		f1:
			call crlf
			call crlf
			invoke start
ret
valid_inputt endp

check_for_the_word proc
	
	push ebp
	mov ebp,esp
	mov esi,0

	check_letter:
		

		cmp input_word[esi],'A' 
		jl ENDD					
		cmp input_word[esi],'z'   
		jg ENDD					
		cmp input_word[esi],'Z'	
		jg l2					
		jmp l3
		l2:
		cmp input_word[esi],'a'
		jl ENDD					
		l3:
		inc esi
		loop check_letter
		pop ebp
		mov eax,1				
		ret 

	ENDD:
		pop ebp
		mov eax,0				
		ret 
check_for_the_word endp


convert_the_word_into_lowercase proc
	push ebp
	mov ebp,esp
	mov esi,0

	convert1:
		cmp input_word[esi],'Z' 
		jle c1					
		inc esi
	loop convert1

	pop ebp		
	ret
	c1:
		mov al,input_word[esi]
		add al,32
		mov input_word[esi],al  
		inc esi
	loop convert1

	pop ebp	
	ret
	convert_the_word_into_lowercase endp
end main
