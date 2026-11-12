
statvfs_layout_and_call.x64:	file format elf64-x86-64

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
               	subq	$0xf0, %rsp
               	leaq	<rip>, %rdi
               	leaq	-0xe0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpq	$0x0, -0xe0(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0xd8(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0xd0(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0x90(%rbp)
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0xc8(%rbp), %rcx
               	movq	-0xd0(%rbp), %rax
               	cmpq	%rax, %rcx
               	ja	<addr>
               	movq	-0xc0(%rbp), %rcx
               	cmpq	%rax, %rcx
               	ja	<addr>
               	movq	-0xb0(%rbp), %rax
               	movq	-0xb8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jbe	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rsi
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, (%rsp)
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	movq	-0xd8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	-0xd0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0xa0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
