
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movq	(%rcx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x30(%rbp), %rdx
               	addq	$0x20, %rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movl	$0x10, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	leaq	-0x30(%rbp), %rcx
               	addq	$0x20, %rcx
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	subq	%rax, %rdx
               	movl	$0x10, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r10
               	popq	%rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movq	%rdi, %rax
               	addq	$0x10, %rax
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rdx
               	addq	$0x30, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addq	$0x20, %rdi
               	leaq	-0x30(%rbp), %rax
               	addq	$0x20, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
