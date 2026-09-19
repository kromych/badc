
inline_memory_class_struct_param.x64:	file format elf64-x86-64

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

<weigh>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	imulq	%rdi, %rax
               	leave
               	retq

<use_sum>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	movq	0x10(%rdi), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rdi), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rdi), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	retq

<use_forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x7, %eax
               	leaq	-0x28(%rbp), %r9
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r9)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r9)
               	movq	0x10(%rdi), %rax
               	movq	%rax, 0x10(%r9)
               	movq	0x18(%rdi), %rax
               	movq	%rax, 0x18(%r9)
               	movq	0x20(%rdi), %rax
               	movq	%rax, 0x20(%r9)
               	popq	%rax
               	subq	$0x30, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<use_clobber>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	$0x63, (%rax)
               	movq	$0x4d, 0x20(%rax)
               	imulq	$0x2710, %rcx, %rax     # imm = 0x2710
               	imulq	$0x3e8, %rdx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	imulq	$0x64, %rsi, %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<use_pick>:
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	0x10(%rdi), %rax
               	retq
               	movq	0x18(%rsi), %rax
               	jmp	<addr>

<use_find>:
               	movq	(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x10(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	0x20(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	popq	%rcx
               	callq	<addr>
               	cmpq	$0x81, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x20(%rax), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	0x20(%rax), %rdx
               	movq	%rdx, 0x20(%rcx)
               	popq	%rdx
               	callq	<addr>
               	cmpq	$0x3039, %rax           # imm = 0x3039
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x63, %rcx
               	jne	<addr>
               	movq	0x20(%rax), %rcx
               	cmpq	$0x4d, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rsi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rsi)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
