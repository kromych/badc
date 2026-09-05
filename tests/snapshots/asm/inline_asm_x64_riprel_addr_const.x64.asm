
inline_asm_x64_riprel_addr_const.x64:	file format elf64-x86-64

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

<stat_fn>:
               	movl	$0x5, %eax
               	retq

<glob_fn>:
               	movl	$0x7, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rdx
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	0x10(%rdx), %rdi
               	movq	%rax, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x10(%rbp), %r13
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x8(%rsi), %r8
               	movq	%rax, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%r8, -0x40(%rbp)
               	leaq	<rip>, %rax
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x8(%rbp), %r14
               	leaq	-<rip>, %rdi       # <addr>
               	cmpq	%rdi, %rax
               	jne	<addr>
               	cmpq	%rcx, %rbx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x10(%rdx), %rcx
               	cmpq	%rcx, %r13
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x8(%rsi), %rcx
               	cmpq	%rcx, %r14
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	callq	*%rax
               	movq	%rax, %r12
               	movq	%rbx, %rax
               	callq	*%rax
               	addq	%r12, %rax
               	movslq	(%r13), %rcx
               	addq	%rcx, %rax
               	movslq	(%r14), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
