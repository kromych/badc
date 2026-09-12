
inline_struct_param_returned.x64:	file format elf64-x86-64

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

<use_word>:
               	movq	(%rdi), %rax
               	retq

<use_pair>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<use_big>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rsi, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x3e8, %rdi, %rdx      # imm = 0x3E8
               	addq	%rdx, %rcx
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	addq	%rcx, %rax
               	retq

<use_hint>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_twice>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	retq

<use_pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movl	$0x7, %eax
               	movq	%rax, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	callq	<addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x18(%rax)
               	movl	$0x5, %ecx
               	movq	%rcx, 0x20(%rax)
               	callq	<addr>
               	cmpq	$0xd431, %rax           # imm = 0xD431
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x59, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpq	$0x62, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
