
register_var_asm_operand_sp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<call_with_sp_marker>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsp, %rax
               	movq	%rax, -0x10(%rbp)
               	callq	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<read_pointers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rsp, %rax
               	movq	-0x38(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rbp, %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rbp, %rax
               	movq	-0x38(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rsp, %rdx
               	addq	$0x8, %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	%rbx, %rax
               	movq	-0x30(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rdi)
               	movq	%rsp, %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	-0x18(%rbp), %rcx
               	movq	%rcx, 0x18(%rdi)
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rsp, %rbx
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rsp, %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	0x10(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
