
slot_coalesce_disjoint_temps.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movq	%rax, %r9
               	andq	$0x1, %r9
               	testq	%r9, %r9
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	cmpl	$0xa, %ecx
               	jle	<addr>
               	cmpl	$0x64, %ecx
               	jge	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %rsi
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %rsi
               	andq	$0x1, %rsi
               	subq	%rbx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$0x32, %edx
               	jle	<addr>
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %r8
               	testq	%r9, %r9
               	je	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	cmpl	$0xa, %ecx
               	jle	<addr>
               	cmpl	$0x64, %ecx
               	jge	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	andq	$0x1, %rsi
               	subq	%r9, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$0x32, %edx
               	jle	<addr>
               	movq	%rdx, %rsi
               	shlq	%rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	0x7(%rax), %rcx
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	0x7(%rax), %rcx
               	jmp	<addr>
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rdi
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	%edi, %r8d
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
