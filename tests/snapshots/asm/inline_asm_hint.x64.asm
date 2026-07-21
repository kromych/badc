
inline_asm_hint.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pause
               	addq	%rax, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pause
               	addq	%rax, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0xa, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2d, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
