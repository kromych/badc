
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
               	movq	%rsi, %r8
               	movq	%rcx, %rsi
               	movq	%rdx, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	leaq	(%rax,%rsi), %rdx
               	movq	%r8, %r11
               	movq	%r9, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	addq	%rcx, %rax
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	%rsi, %rax
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
