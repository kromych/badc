
attribute_noop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<formatted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rdi, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	movq	%rdx, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%r8, -0x90(%rbp)
               	movq	%r9, -0x88(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0x80(%rbp,%riz)
               	movsd	%xmm1, -0x70(%rbp,%riz)
               	movsd	%xmm2, -0x60(%rbp,%riz)
               	movsd	%xmm3, -0x50(%rbp,%riz)
               	movsd	%xmm4, -0x40(%rbp,%riz)
               	movsd	%xmm5, -0x30(%rbp,%riz)
               	movsd	%xmm6, -0x20(%rbp,%riz)
               	movsd	%xmm7, -0x10(%rbp,%riz)
               	movl	$0x2a, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
