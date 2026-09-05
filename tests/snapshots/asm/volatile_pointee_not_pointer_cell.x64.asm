
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
               	movq	(%rax), %rdi
               	leaq	<rip>, %rdx
               	movl	$0x2, %esi
               	movq	%rsi, (%rdx)
               	movq	(%rax), %r8
               	addq	%rdi, %r8
               	movl	$0x3, %edi
               	movq	%rdi, (%rdx)
               	movq	(%rax), %rdx
               	addq	%r8, %rdx
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0xa, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	movl	$0x14, %edx
               	movq	%rdx, (%rax)
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movl	$0x1e, %edx
               	movq	%rdx, (%rax)
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	movl	$0x7, %ecx
               	movq	%rcx, (%rax)
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
