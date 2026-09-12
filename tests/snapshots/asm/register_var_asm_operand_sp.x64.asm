
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
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rsp, %rbx
               	movq	%rsp, %rax
               	callq	<addr>
               	movq	%rsp, %rax
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
               	movq	%rsp, %rax
               	movq	%rsp, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	%rbp, %rax
               	movq	%rbp, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rsp, %rax
               	addq	$0x8, %rax
               	movq	%rax, %rbx
               	movq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
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
