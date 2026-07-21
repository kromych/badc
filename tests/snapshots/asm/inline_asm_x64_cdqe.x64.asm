
inline_asm_x64_cdqe.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movabsq	$-0x5, %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	cltq
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x28(%rbp), %rax
               	movl	$0x2f, %ecx
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	cltq
               	movq	-0x48(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	cmpq	$-0x5, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2f, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
