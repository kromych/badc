
variable_shift_rcx_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<g>:
               	movq	%rcx, %rax
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movq	%rsi, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r9
               	popq	%rcx
               	addq	%r9, %r8
               	jmp	<addr>
               	leaq	(%r8,%rax), %rcx
               	jmp	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x64, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x1, %ecx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
