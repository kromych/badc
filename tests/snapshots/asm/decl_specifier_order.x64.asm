
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

<takes_qualified>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rcx, -0x10(%rbp)
               	movl	%edx, -0x20(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	-0x20(%rbp), %eax
               	addq	$0x2, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	addq	$0x2, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	ja	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x64, %eax
               	jg	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
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
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	$0x4, -0x20(%rbp)
               	movl	$0x4, -0x18(%rbp)
               	movl	$0x4, -0x10(%rbp)
               	movl	$0x4, -0x8(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	-0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	addq	$0x4, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
