
inline_asm_x64_riprel_addr_const.x64:	file format elf64-x86-64

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
               	leaq	-<rip>, %rax # <addr>
               	leaq	-<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rdi, (%rsp)
               	callq	*%rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x10(%rsp), %rdx
               	movq	0x8(%rsp), %rsi
               	movq	(%rsp), %rdi
               	movq	%rsi, 0x8(%rsp)
               	movq	%rdi, (%rsp)
               	callq	*%rdx
               	movq	0x8(%rsp), %rsi
               	movq	(%rsp), %rdi
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	addq	%r10, %rax
               	movl	(%rsi), %ecx
               	addq	%rcx, %rax
               	movl	(%rdi), %ecx
               	addq	%rcx, %rax
               	leave
               	retq
