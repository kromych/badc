
volatile_ptr_alias_loop.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jg	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
