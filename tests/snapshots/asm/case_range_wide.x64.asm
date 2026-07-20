
case_range_wide.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify_u>:
               	movl	%edi, %eax
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	jae	<addr>
               	cmpq	$0x7, %rax
               	jae	<addr>
               	movl	$0xf0000000, %r11d      # imm = 0xF0000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jae	<addr>
               	cmpq	$0x5, %rax
               	jb	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x64, %eax
               	retq
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	ja	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x9, %rax
               	jbe	<addr>
               	jmp	<addr>
               	cmpq	$0x1fffff, %rax         # imm = 0x1FFFFF
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>

<classify_s>:
               	movslq	%edi, %rdi
               	cmpq	$-0x64, %rdi
               	jge	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	cmpq	$-0x32, %rdi
               	jg	<addr>
               	movl	$0xa, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x100000, %edi         # imm = 0x100000
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1fffff, %edi         # imm = 0x1FFFFF
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16e360, %edi         # imm = 0x16E360
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xfffff, %edi          # imm = 0xFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x200000, %edi         # imm = 0x200000
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0xf0000000, %edi       # imm = 0xF0000000
               	callq	<addr>
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0xefffffff, %edi       # imm = 0xEFFFFFFF
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x64, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x32, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x4b, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x65, %rdi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x31, %rdi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
