
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
               	leaq	<rip>, %rax
               	movq	$0x100, (%rax)          # imm = 0x100
               	leaq	<rip>, %rdx
               	movq	$0x100, (%rdx)          # imm = 0x100
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, %r8
               	andq	$0xff, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	(%rdx), %r8
               	movq	%r8, %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	cmpq	$0x2, %r8
               	ja	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
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
               	movq	$0x100, (%rcx)          # imm = 0x100
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movl	$0x3, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	jbe	<addr>
               	addq	$-0x11, %rcx
               	cmpq	$-0x11, %rcx
               	jbe	<addr>
               	movl	$0x4, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	shlq	$0x37, %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
