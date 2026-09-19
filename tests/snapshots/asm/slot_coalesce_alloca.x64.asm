
slot_coalesce_alloca.x64:	file format elf64-x86-64

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
               	subq	$0xd0, %rsp
               	movl	$0x40, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	movq	$0x74, (%rdx)
               	movq	$0x75, 0x8(%rdx)
               	movq	$0x76, 0x10(%rdx)
               	movq	$0x77, 0x18(%rdx)
               	movq	$0x78, 0x20(%rdx)
               	movq	$0x79, 0x28(%rdx)
               	movq	$0x7a, 0x30(%rdx)
               	movq	$0x7b, 0x38(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rsi, %rdi
               	leaq	0x1(%rax), %rsi
               	imulq	$0x74, %rsi, %r8
               	movq	%r8, (%rdi)
               	movq	%rsi, %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x18, %eax
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0xd0(%rbp), %rsp
               	leave
               	retq
               	movq	(%rdx), %rax
               	cmpq	$0x74, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xd0(%rbp), %rsp
               	leave
               	retq
               	movq	0x8(%rdx), %rax
               	cmpq	$0x75, %rax
               	jne	<addr>
               	movq	0x10(%rdx), %rax
               	cmpq	$0x76, %rax
               	jne	<addr>
               	movq	0x18(%rdx), %rax
               	cmpq	$0x77, %rax
               	jne	<addr>
               	movq	0x20(%rdx), %rax
               	cmpq	$0x78, %rax
               	jne	<addr>
               	movq	0x28(%rdx), %rax
               	cmpq	$0x79, %rax
               	jne	<addr>
               	movq	0x30(%rdx), %rax
               	cmpq	$0x7a, %rax
               	jne	<addr>
               	movq	0x38(%rdx), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0xd0(%rbp), %rsp
               	leave
               	retq
