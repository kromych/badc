
decl_specifier_order.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x38, %rsp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	addq	$0x2, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	ja	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x64, %eax
               	jg	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1, 0x18(%rsp)
               	movl	$0x1, (%rsp)
               	movl	0x18(%rsp), %eax
               	addq	$0x2, %rax
               	leaq	(%rsp), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x4, 0x8(%rsp)
               	movl	$0x4, 0x10(%rsp)
               	movl	$0x4, 0x20(%rsp)
               	movl	$0x4, 0x28(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	leaq	0x20(%rsp), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	leaq	0x28(%rsp), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	addq	$0x4, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
