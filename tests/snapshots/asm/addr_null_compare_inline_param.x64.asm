
addr_null_compare_inline_param.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movslq	(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
