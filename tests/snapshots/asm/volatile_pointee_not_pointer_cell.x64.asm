
volatile_pointee_not_pointer_cell.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %eax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	addq	%rsi, %rdx
               	movq	$0x3, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	addq	%rsi, %rdx
               	cmpq	$0x6, %rdx
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	movq	$0xa, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x14, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rax
               	movq	$0x1e, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
               	movq	$0x7, <rip> # <addr>
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	movq	(%rax), %rax
               	movq	0x8(%rsp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
