
nested_block_shadow_restore.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
