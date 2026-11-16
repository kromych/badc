
setjmp_value_live_across.x64:	file format elf64-x86-64

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

<h>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	ud2

<test>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	imulq	$0x7, %rdi, %rax
               	leaq	(%rax,%rsi), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x8(%rsp), %rax
               	leave
               	retq
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x2a, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
