
int128_unary.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	shlq	$0x24, %rcx
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rcx, %rsi
               	negq	%rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	negq	%rsi
               	negq	%rdx
               	movq	%rdx, %r8
               	sarq	$0x4, %r8
               	movq	%rsi, %rax
               	shrq	$0x4, %rax
               	movq	%rdx, %rdi
               	shlq	$0x3c, %rdi
               	orq	%rdi, %rax
               	movq	$-0x1, %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	cmpl	%edi, %r8d
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	cmpq	%rdx, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rdx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rsi, %rsi
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rax, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0xa, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	retq
