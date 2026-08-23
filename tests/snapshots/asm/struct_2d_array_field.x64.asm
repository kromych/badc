
struct_2d_array_field.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %r9
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%r9,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	imulq	$0xa, %rdx, %rax
               	leaq	(%rax), %r8
               	movl	%r8d, (%rbx)
               	leaq	0x1(%rax), %r8
               	movl	%r8d, 0x4(%rdi)
               	leaq	-0x30(%rbp), %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x2(%rax), %rsi
               	movl	%esi, 0x8(%r8)
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	addq	$0x3, %rax
               	movl	%eax, 0xc(%rsi)
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	leaq	-0x30(%rbp), %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rdi,%r8), %rsi
               	leaq	(%rsi), %r9
               	movslq	(%r9), %r9
               	addq	%r9, %rcx
               	movslq	0x4(%rsi), %r9
               	addq	%r9, %rcx
               	movslq	0x8(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	(%rdi,%r8), %rsi
               	movslq	0xc(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x6f(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
