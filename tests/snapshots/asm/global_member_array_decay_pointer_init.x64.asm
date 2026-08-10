
global_member_array_decay_pointer_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x16, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0x21, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
