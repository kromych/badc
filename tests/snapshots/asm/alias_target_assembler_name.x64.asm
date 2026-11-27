
alias_target_assembler_name.x64:	file format elf64-x86-64

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

<weak_name>:
               	movl	$0x9, %eax
               	retq

<strong_name>:
               	movl	$0xb, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	callq	<addr>
               	addq	$0xb, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
