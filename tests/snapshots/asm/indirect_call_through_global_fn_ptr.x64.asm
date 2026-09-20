
indirect_call_through_global_fn_ptr.x64:	file format elf64-x86-64

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

<do_add>:
               	leaq	(%rsi,%rdx), %rax
               	movl	%eax, (%rdi)
               	xorl	%eax, %eax
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movl	$0x7, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x23, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movl	$0x7, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x23, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq
