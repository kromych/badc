
inline_asm_a64_pmull.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	movl	$0x3, %eax
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	movq	%rcx, %rsi
               	xorq	%rax, %rsi
               	testb	$0x1, %dl
               	cmovneq	%rsi, %rcx
               	shlq	%rax
               	shrq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x7, %edx
               	movl	$0x6, %eax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	xorq	%rdx, %rsi
               	testb	$0x1, %al
               	cmovneq	%rsi, %rcx
               	shlq	%rdx
               	shrq	%rax
               	testq	%rax, %rax
               	jne	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	movq	%rcx, %rsi
               	xorq	%rax, %rsi
               	testb	$0x1, %dl
               	cmovneq	%rsi, %rcx
               	shlq	%rax
               	shrq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
