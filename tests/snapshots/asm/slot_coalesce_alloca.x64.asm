
slot_coalesce_alloca.x64:	file format elf64-x86-64

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
               	subq	$0x170, %rsp            # imm = 0x170
               	movl	$0x40, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rsi
               	subq	%r11, %rsi
               	movq	%rsi, %rsp
               	leaq	(%rsi), %rax
               	movl	$0x74, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x75, %eax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x76, %eax
               	movq	%rax, 0x10(%rsi)
               	movl	$0x77, %eax
               	movq	%rax, 0x18(%rsi)
               	movl	$0x78, %eax
               	movq	%rax, 0x20(%rsi)
               	movl	$0x79, %eax
               	movq	%rax, 0x28(%rsi)
               	movl	$0x7a, %eax
               	movq	%rax, 0x30(%rsi)
               	movl	$0x7b, %eax
               	movq	%rax, 0x38(%rsi)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rdi
               	movq	%rdx, %r8
               	shlq	$0x3, %r8
               	addq	%rdi, %r8
               	leaq	0x1(%rdx), %rdi
               	movslq	%edi, %rdi
               	imulq	$0x74, %rdi, %rdi
               	movq	%rdi, (%r8)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x18, %rdx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rdi
               	movq	%rdx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x18, %rdx
               	jl	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	(%rsi,%rcx,8), %rdx
               	leaq	0x74(%rcx), %rdi
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
