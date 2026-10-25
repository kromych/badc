
function_designator_address_constants.x64:	file format elf64-x86-64

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

<fn>:
               	movl	$0x1, %eax
               	retq

<g>:
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edx, %edx
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	leaq	-<rip>, %r9 # <addr>
               	imulq	$0x38, %rdx, %rax
               	addq	%r8, %rax
               	movq	(%rdi,%rdx,8), %rcx
               	movq	(%rax), %rbx
               	subq	%rsi, %rbx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movq	0x8(%rax), %rbx
               	subq	%rsi, %rbx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movq	0x10(%rax), %rbx
               	subq	%rsi, %rbx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movq	0x18(%rax), %rbx
               	subq	%rsi, %rbx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movq	0x20(%rax), %rbx
               	subq	%rsi, %rbx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movq	0x28(%rax), %rbx
               	subq	%rsi, %rbx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movq	0x30(%rax), %rax
               	subq	%r9, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rax # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	-<rip>, %rcx # <addr>
               	subq	%rcx, %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x7(%rdx), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x2(%rdx), %rax
               	popq	%rbx
               	leave
               	retq
