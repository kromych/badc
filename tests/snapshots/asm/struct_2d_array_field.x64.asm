
struct_2d_array_field.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	imulq	$0xa, %rsi, %rsi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax,%rdi,4)
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	%edi, %r8
               	movslq	(%rsi,%r8,4), %rsi
               	addq	%rsi, %rdx
               	movslq	%edi, %rsi
               	leaq	0x1(%rsi), %rdi
               	movslq	%edi, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rsi
               	cmpq	$0x3, %rsi
               	jl	<addr>
               	leaq	-0x6f(%rdx), %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
