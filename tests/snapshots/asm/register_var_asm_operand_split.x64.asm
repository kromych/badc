
register_var_asm_operand_split.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<through_rdx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<via_named_rdx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rax
               	movq	-0x20(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rdi
               	callq	<addr>
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x7b, %edi
               	callq	<addr>
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rdi
               	callq	<addr>
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
