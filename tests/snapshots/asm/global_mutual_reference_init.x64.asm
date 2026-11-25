
global_mutual_reference_init.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	(%rdx), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	(%rcx), %rax
               	movq	(%rax), %rax
               	movl	0x10(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
