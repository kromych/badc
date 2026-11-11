
warn_dead_store.x64:	file format elf64-x86-64

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

<dead_initializer>:
               	movl	$0x1, %eax
               	retq

<self_referencing_rhs>:
               	movl	$0x6, %eax
               	retq

<store_consumed_after_branch_is_silenced>:
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	testl	%edi, %edi
               	cmovneq	%rcx, %rax
               	retq

<address_escapes_silences>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	movl	$0x1, %eax
               	leave
               	retq

<block_local_dies>:
               	movl	$0x1, %eax
               	retq

<shadowed_outer_is_read>:
               	leaq	0x1(%rdi), %rax
               	incq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	movl	$0xe, %eax
               	leave
               	retq
