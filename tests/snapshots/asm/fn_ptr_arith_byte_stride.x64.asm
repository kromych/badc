
fn_ptr_arith_byte_stride.x64:	file format elf64-x86-64

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

<f1>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<f2>:
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-<rip>, %rcx       # <addr>
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, %rax
               	subq	%rcx, %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-<rip>, %rsi       # <addr>
               	subq	%rsi, %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	addq	%rcx, %rax
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	movl	$0x5, %ecx
               	movl	$0x6, %r8d
               	callq	*%rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	incq	%rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	decq	%rax
               	leaq	-<rip>, %rcx       # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	addq	$0x3, %rax
               	leaq	-<rip>, %rcx       # <addr>
               	addq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	subq	$0x5, %rax
               	leaq	-<rip>, %rcx       # <addr>
               	subq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rcx, (%rax)
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	leaq	0x10(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	0x8(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	movl	$0x5, %ecx
               	movl	$0x6, %r8d
               	callq	*%rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0xc(%rax), %rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rcx, %rsi
               	sarq	$0x2, %rsi
               	cmpq	$0x3, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x4(%rdx), %rcx
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	subq	$0x8, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
