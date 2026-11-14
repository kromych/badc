
creat_creates_and_truncates.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x180, %esi            # imm = 0x180
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movq	%rcx, 0x10(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
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
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rcx
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
