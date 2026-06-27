
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
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
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
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	cmpq	$0x3, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	leaq	-0x6f(%rdx), %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rsi
               	cmpq	$0x4, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edi, %rsi
               	leaq	0x1(%rsi), %rdi
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	%edi, %r8
               	movslq	(%rsi,%r8,4), %rsi
               	addq	%rsi, %rdx
               	jmp	<addr>
               	jmp	<addr>
