
statvfs_layout_and_call.x64:	file format elf64-x86-64

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
               	subq	$0xf8, %rsp
               	leaq	<rip>, %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xf8, %rsp
               	retq
               	cmpq	$0x0, 0x10(%rsp)
               	je	<addr>
               	cmpq	$0x0, 0x18(%rsp)
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x0, 0x60(%rsp)
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0xf8, %rsp
               	retq
               	movq	0x28(%rsp), %rcx
               	cmpq	%rax, %rcx
               	ja	<addr>
               	movq	0x30(%rsp), %rcx
               	cmpq	%rax, %rcx
               	ja	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x38(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jbe	<addr>
               	movl	$0x5, %eax
               	addq	$0xf8, %rsp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x6, %eax
               	addq	$0xf8, %rsp
               	retq
               	leaq	0x80(%rsp), %rsi
               	movq	%rax, (%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	(%rsp), %rax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x90(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0x50(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xf8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xf8, %rsp
               	retq
