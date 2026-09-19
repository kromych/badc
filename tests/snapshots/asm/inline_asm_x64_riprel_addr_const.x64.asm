
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	leaq	-<rip>, %rdi       # <addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %r13
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r14
               	leaq	-<rip>, %rax       # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	cmpq	%rdi, %rbx
               	jne	<addr>
               	leaq	0x10(%rdx), %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	0x8(%rsi), %rax
               	cmpq	%rax, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rcx, %rax
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
