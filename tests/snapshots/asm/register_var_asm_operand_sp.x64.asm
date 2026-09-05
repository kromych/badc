
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
               	subq	$0x70, %rsp
               	movq	%rsp, %rax
               	movq	%rsp, %rcx
               	movq	%rcx, -0x70(%rbp)
               	callq	<addr>
               	movq	%rsp, %rcx
               	movq	%rcx, -0x70(%rbp)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	%rsp, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rsp, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	leaq	-0x10(%rbp), %rax
               	movq	%rbp, %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rbp, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	addq	$0x8, %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	-0x58(%rbp), %rbx
               	movq	%rbx, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
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
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	cmpq	%rax, %rdx
               	jae	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x8, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
