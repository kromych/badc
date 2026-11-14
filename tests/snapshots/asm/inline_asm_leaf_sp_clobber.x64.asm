
inline_asm_leaf_sp_clobber.x64:	file format elf64-x86-64

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

<leaf_push>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	$0x77
               	leave
               	retq

<leaf_val>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	$0x77
               	pushq	$0x78
               	leaq	0x1(%rdi), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rax # <addr>
               	leaq	(%rax,%rax,2), %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
