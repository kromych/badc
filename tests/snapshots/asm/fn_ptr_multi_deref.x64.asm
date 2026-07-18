
fn_ptr_multi_deref.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	movl	$0x7, %esi
               	movq	%rbx, %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	movl	$0xa, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x68(%rbp), %rcx
               	movl	$0x1e, %edx
               	movl	%edx, 0x8(%rcx)
               	movslq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
