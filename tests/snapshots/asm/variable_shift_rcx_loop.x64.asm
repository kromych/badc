
variable_shift_rcx_loop.x64:	file format elf64-x86-64

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

<g>:
               	movq	%rdx, %r8
               	movq	%rcx, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpq	%rdi, %rcx
               	jge	<addr>
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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	addq	$0x10, %rax
               	cmpq	$0x64, %rcx
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
