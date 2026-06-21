
attribute_noop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_two>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<formatted>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
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
               	movq	%r13, (%rsp)
               	movl	$0x2a, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x2, %eax
               	movl	$0x3, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
