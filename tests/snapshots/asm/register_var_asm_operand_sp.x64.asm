
register_var_asm_operand_sp.x64:	file format elf64-x86-64

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

<bump>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rsp, %rbx
               	movq	%rsp, %rax
               	movq	%rax, -0x90(%rbp)
               	callq	<addr>
               	movq	%rsp, %rax
               	movq	%rax, -0x88(%rbp)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rsp, %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rsp, %rax
               	movq	-0x80(%rbp), %r10
               	movq	%rax, (%r10)
               	leaq	-0x10(%rbp), %rax
               	movq	%rbp, %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbp, %rax
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	addq	$0x8, %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	movq	%rbx, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x18(%rbp), %rax
               	movq	%rsp, %rsi
               	movq	-0x10(%rbp), %rdx
               	movq	-0x8(%rbp), %rdi
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rdx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpq	%rax, %rdx
               	jae	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	addq	$0x8, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
