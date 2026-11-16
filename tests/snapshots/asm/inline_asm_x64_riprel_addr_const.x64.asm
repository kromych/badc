
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
               	leaq	-<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-<rip>, %rdi # <addr>
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	addq	$0x10, %rdi
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	addq	$0x8, %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rcx, 0x10(%rsp)
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, (%rsp)
               	callq	*%rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x10(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	(%rsp), %rsi
               	movq	%rdx, 0x8(%rsp)
               	movq	%rsi, (%rsp)
               	callq	*%rcx
               	movq	0x8(%rsp), %rdx
               	movq	(%rsp), %rsi
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	addq	%r10, %rax
               	movl	(%rdx), %ecx
               	addq	%rcx, %rax
               	movl	(%rsi), %ecx
               	addq	%rcx, %rax
               	leave
               	retq
