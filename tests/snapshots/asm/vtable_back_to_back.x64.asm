
vtable_back_to_back.x64:	file format elf64-x86-64

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

<my_init>:
               	leaq	<rip>, %rax
               	movq	%rax, (%rdi)
               	leaq	(%rdx,%rcx), %rax
               	movl	%eax, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<my_generate>:
               	movslq	0x8(%rdi), %rax
               	movl	%eax, (%rsi)
               	movslq	%edx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	movl	$0x8, %ecx
               	callq	*%rax
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x1, %edx
               	callq	*%rax
               	leaq	<rip>, %rdi
               	movslq	-0x8(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq
