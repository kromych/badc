
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
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rsi
               	movl	$0x2, %edx
               	movq	%rdx, (%rax)
               	movq	(%rax), %rdi
               	addq	%rdi, %rsi
               	movq	$0x3, (%rax)
               	movq	(%rax), %rdi
               	addq	%rdi, %rsi
               	cmpq	$0x6, %rsi
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	$0xa, (%rax)
               	movq	(%rax), %rcx
               	movq	$0x14, (%rax)
               	movq	(%rax), %rsi
               	addq	%rsi, %rcx
               	movq	$0x1e, (%rax)
               	movq	(%rax), %rsi
               	addq	%rsi, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	$0x7, (%rax)
               	movq	%rax, -0x8(%rbp)
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
