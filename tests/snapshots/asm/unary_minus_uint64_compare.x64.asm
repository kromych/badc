
unary_minus_uint64_compare.x64:	file format elf64-x86-64

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
               	movl	$0xa8, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa8, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
