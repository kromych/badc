
variable_shift_rcx_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<g>:
               	movq	%rdx, %r8
               	movq	%rcx, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rax,%rdx), %rcx
               	movq	%rsi, %r9
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %r9
               	popq	%rcx
               	addq	%r9, %rax
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movq	%rdx, %rax
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
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
