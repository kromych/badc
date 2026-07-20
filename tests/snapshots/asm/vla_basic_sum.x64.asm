
vla_basic_sum.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<compute>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, 0x10(%rbp)
               	movslq	0x10(%rbp), %rax
               	shlq	$0x2, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdx
               	movslq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, (%rdx,%rax,4)
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rdx
               	movq	-0x8(%rbp), %rax
               	movslq	-0x28(%rbp), %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	%rdx, %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movslq	-0x20(%rbp), %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
