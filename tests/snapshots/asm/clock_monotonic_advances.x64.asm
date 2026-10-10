
clock_monotonic_advances.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rsi
               	movq	$-0x1, -0x28(%rbp)
               	movq	$-0x1, -0x20(%rbp)
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, -0x8(%rbp)
               	incq	%rax
               	cmpl	$0xf4240, %eax          # imm = 0xF4240
               	jl	<addr>
               	movl	$0x1, %edi
               	leaq	-0x18(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
