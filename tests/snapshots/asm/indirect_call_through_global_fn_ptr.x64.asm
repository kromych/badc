
indirect_call_through_global_fn_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<do_add>:
               	leaq	(%rsi,%rdx), %rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0x23, %ecx
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rbx
               	movslq	(%rax), %rsi
               	movslq	%ecx, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	movslq	(%rbx), %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
