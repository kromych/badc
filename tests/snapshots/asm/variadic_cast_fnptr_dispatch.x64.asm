
variadic_cast_fnptr_dispatch.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %esi
               	leaq	<rip>, %rdx
               	movl	$0x4, %ecx
               	leaq	<rip>, %r8
               	movl	$0x9, %r9d
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	(%rsp), %r10
               	movb	$0x0, %al
               	callq	*%r10
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<__c5_sys_snprintf>:
               	jmp	<addr>
