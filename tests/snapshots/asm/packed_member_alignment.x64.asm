
packed_member_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0xaa, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	incq	%rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xaa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	incq	%rax
               	movl	(%rax), %eax
               	cmpq	$0x11223344, %rax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
