
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
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rcx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	leaq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %r13
               	leaq	<rip>, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r14
               	leaq	-<rip>, %rax       # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	cmpq	%rax, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
