
volatile_ptr_alias_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	movq	-0x10(%rbp), %rax
               	movslq	-0x8(%rbp), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	incq	%rcx
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	jle	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
