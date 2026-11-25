
creat_creates_and_truncates.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x180, %esi            # imm = 0x180
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rsi
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	movl	$0x3, %edx
               	callq	<addr>
               	movq	(%rsp), %rcx
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	(%rsp), %rcx
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	$0x180, %esi            # imm = 0x180
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jl	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	(%rsp), %rcx
               	movq	%rcx, %rdi
               	callq	<addr>
               	cmpq	$0x0, 0x8(%rsp)
               	jne	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
