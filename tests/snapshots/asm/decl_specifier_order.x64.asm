
decl_specifier_order.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	addq	$0x2, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	testl	%eax, %eax
               	ja	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x64, %eax
               	jg	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x1, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	incq	%rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	$0x4, -0x18(%rbp)
               	movl	$0x4, -0x10(%rbp)
               	movslq	-0x18(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	$0x4, %rax
               	addq	$0x4, %rax
               	addq	$0x4, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
