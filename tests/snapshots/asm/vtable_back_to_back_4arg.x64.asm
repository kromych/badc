
vtable_back_to_back_4arg.x64:	file format elf64-x86-64

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

<g_init>:
               	leaq	<rip>, %rax
               	movq	%rax, (%rdi)
               	leaq	(%rdx,%rcx), %rax
               	movl	%eax, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<g_generate>:
               	movslq	0x8(%rdi), %rax
               	addq	$0x64, %rax
               	movl	%eax, (%rsi)
               	movslq	%edx, %rax
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rsi
               	movl	$0x1, %ebx
               	movl	$0x64, %ecx
               	movq	%rbx, %rdx
               	callq	*%rax
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x8(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	*%rax
               	movslq	-0x8(%rbp), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rsi
               	movl	$0x1, %ebx
               	movl	$0x64, %ecx
               	movq	%rbx, %rdx
               	callq	*%rax
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x40(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	*%rax
               	movslq	-0x40(%rbp), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
