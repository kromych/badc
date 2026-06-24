
fn_ptr_explicit_deref.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<real_fn>:
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	movl	$0x28, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x28, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rbx
               	movq	(%rbx), %rax
               	movl	$0x28, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	movl	$0x28, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
