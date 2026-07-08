
block_extern_shadows_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<forward_probe>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x9, %rax
               	movslq	%eax, %rax
               	retq

<param_probe>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	addq	$0x0, %rax
               	movl	$0x7, %edx
               	movl	%edx, (%rcx)
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	cmpq	$0x69, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x9, %rax
               	movslq	%eax, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x50, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
