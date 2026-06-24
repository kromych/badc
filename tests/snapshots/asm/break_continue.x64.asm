
break_continue.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%eax, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	cmpq	$0x5, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	andq	$0x1, %rdx
               	subq	%rsi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	addb	%al, (%rax)
