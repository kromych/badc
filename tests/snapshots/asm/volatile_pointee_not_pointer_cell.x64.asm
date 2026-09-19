
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
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rsi
               	movl	$0x2, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rcx), %rdi
               	addq	%rdi, %rsi
               	movq	$0x3, (%rcx)
               	movq	(%rcx), %rdi
               	addq	%rdi, %rsi
               	cmpq	$0x6, %rsi
               	je	<addr>
               	leave
               	retq
               	movq	$0xa, (%rcx)
               	movq	(%rcx), %rax
               	movq	$0x14, (%rcx)
               	movq	(%rcx), %rsi
               	addq	%rsi, %rax
               	movq	$0x1e, (%rcx)
               	movq	(%rcx), %rsi
               	addq	%rsi, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	$0x7, (%rcx)
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
