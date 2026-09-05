
designator_scopes.x64:	file format elf64-x86-64

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

<scalar_forms>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x17, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movslq	0x8(%rcx), %rdi
               	addq	%rdi, %rdx
               	movslq	0xc(%rcx), %rdi
               	addq	%rdi, %rdx
               	movslq	0x10(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x17, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	0x10(%rax), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x10(%rdx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>

<nested_struct_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movslq	0x28(%rax), %rcx
               	movslq	0x2c(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0xc(%rax), %rsi
               	addq	%rsi, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x28(%rcx), %rsi
               	movslq	0x2c(%rcx), %rdi
               	addq	%rdi, %rsi
               	movslq	0x8(%rcx), %rdi
               	addq	%rdi, %rsi
               	movslq	0xc(%rcx), %rcx
               	addq	%rsi, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x1c(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rsi
               	movslq	0xc(%rax), %rdi
               	addq	%rdi, %rsi
               	movslq	0x14(%rax), %rdi
               	addq	%rdi, %rsi
               	movslq	0x1c(%rax), %rax
               	addq	%rsi, %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>

<member_array_forms>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movslq	0x4(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movslq	(%rax), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
