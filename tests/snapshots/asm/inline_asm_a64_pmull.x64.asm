
inline_asm_a64_pmull.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x3, %edx
               	movl	$0x3, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xorq	%rdx, %rax
               	jmp	<addr>
               	shlq	%rdx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%eax, %eax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x7, %edx
               	movl	$0x6, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xorq	%rdx, %rax
               	jmp	<addr>
               	shlq	%rdx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%eax, %eax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %ecx
               	xorq	%rax, %rax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rdx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xorq	%rcx, %rax
               	jmp	<addr>
               	shlq	%rcx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	%eax, %eax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
