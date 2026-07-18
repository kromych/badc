
attribute_packed.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rax
               	addq	$0xd, %rax
               	leaq	-0x20(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movl	$0x1, %eax
               	movb	%al, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	incq	%rcx
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movq	%rdx, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	addq	$0x9, %rcx
               	movabsq	$-0x7, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	incq	%rax
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	addq	$0x9, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
