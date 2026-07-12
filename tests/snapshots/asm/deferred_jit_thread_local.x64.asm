
deferred_jit_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<s_local_to_force_layout_shift>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	movl	%edi, (%rax,%rdi,4)
               	movslq	(%rax,%rdi,4), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movslq	(%rcx), %rax
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
