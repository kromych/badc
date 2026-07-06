
unsigned_signed_relational_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movabsq	$-0x1, %rcx
               	movl	%ecx, %edx
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	%ecx, %edx
               	cmpq	%rax, %rdx
               	jae	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	%ecx, %edx
               	cmpq	%rdx, %rax
               	setbe	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	%ecx, %edx
               	cmpq	%rdx, %rax
               	setae	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	%ecx, %edx
               	cmpq	%rdx, %rax
               	jbe	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x5, %eax
               	movl	$0xa, %edx
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movabsq	$-0x5, %rax
               	movl	$0x3, %edx
               	cmpq	%rdx, %rax
               	setl	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	%rax, %rdx
               	setl	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
