
zero_fill_narrow_member_guard.x64:	file format elf64-x86-64

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

<reader>:
               	xorq	%rcx, %rcx
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx
               	movl	(%rdx), %esi
               	movq	%rcx, %r8
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %r8
               	incq	%r8
               	movl	%r8d, (%rdi)
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %r8
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movl	(%rdx), %eax
               	movq	%rax, %rdi
               	andq	$0x1, %rdi
               	movl	$0x1, %eax
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	(%rdx), %eax
               	cmpl	%esi, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%r8d, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %r12
               	movl	$0x2, %eax
               	movl	%eax, (%r12)
               	leaq	<rip>, %r13
               	movl	$0x7, %eax
               	movl	%eax, (%r13)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	%eax, (%r12)
               	movl	$0x9, %eax
               	movl	%eax, (%r13)
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
