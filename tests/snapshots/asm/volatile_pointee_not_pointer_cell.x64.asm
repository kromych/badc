
volatile_pointee_not_pointer_cell.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x1, %eax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	movl	$0x2, %ecx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	addq	%rdi, %rsi
               	movq	$0x3, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	addq	%rdi, %rsi
               	cmpq	$0x6, %rsi
               	je	<addr>
               	leave
               	retq
               	movq	$0xa, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x14, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	addq	%rsi, %rax
               	movq	$0x1e, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	addq	%rsi, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	$0x7, <rip> # <addr>
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
