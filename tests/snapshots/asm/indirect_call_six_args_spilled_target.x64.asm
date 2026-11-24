
indirect_call_six_args_spilled_target.x64:	file format elf64-x86-64

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

<do_cmp>:
               	movl	$0x1, (%rsi)
               	movq	(%rdx), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movq	(%r8), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	retq

<main>:
               	subq	$0x58, %rsp
               	leaq	(%rsp), %rdi
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	leaq	0x10(%rsp), %rax
               	movq	$0x3, 0x20(%rsp)
               	leaq	0x30(%rsp), %r8
               	movq	$0x7, 0x40(%rsp)
               	movl	$0x5, %ecx
               	movl	$0x9, %r9d
               	movl	$0x0, 0x8(%rsp)
               	leaq	0x8(%rsp), %rsi
               	leaq	0x10(%rax), %rdx
               	addq	$0x10, %r8
               	callq	<addr>
               	movslq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0xc0d, %rax            # imm = 0xC0D
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x58, %rsp
               	retq
