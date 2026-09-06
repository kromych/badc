
range_unproved_comparisons_stay.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movl	$0x100, %esi            # imm = 0x100
               	movq	%rsi, (%rcx)
               	leaq	<rip>, %rdx
               	movq	%rsi, (%rdx)
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	(%rcx), %rcx
               	movq	%rcx, %r8
               	andq	$0xff, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	movq	%rcx, %r8
               	xorq	$0x2, %r8
               	movl	%r8d, %r8d
               	testq	%r8, %r8
               	je	<addr>
               	cmpq	$0x2, %rcx
               	ja	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rdi)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movq	(%rdi), %rcx
               	movq	%rsi, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movl	$0x3, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	jbe	<addr>
               	addq	$-0x11, %rcx
               	cmpq	$-0x11, %rcx
               	jbe	<addr>
               	movl	$0x4, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	shlq	$0x37, %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
