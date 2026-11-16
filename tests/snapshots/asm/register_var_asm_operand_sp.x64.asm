
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
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsp, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rsp, %rax
               	callq	<addr>
               	movq	%rsp, %rax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rsp, %rax
               	cmpq	0x8(%rsp), %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rsp, %rax
               	movq	%rsp, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	%rbp, %rax
               	movq	%rbp, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rsp, %rax
               	leaq	0x8(%rax), %rcx
               	movq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	%rsp, %rdx
               	movq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rsi
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	cmpq	%rax, %rcx
               	jae	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
