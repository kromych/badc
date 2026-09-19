
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
               	movq	%rcx, %rax
               	xorl	%r8d, %r8d
               	movq	%r8, %r9
               	cmpq	%rdi, %r9
               	jge	<addr>
               	leaq	(%r8,%rax), %r9
               	movq	%rsi, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	addq	%rcx, %r8
               	cmpq	%rdi, %r9
               	jl	<addr>
               	retq

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1(%rax), %rcx
               	addq	$0x10, %rax
               	cmpq	$0x64, %rcx
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
