
builtin_frame_address.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rax, %rax
               	movq	%rbp, %rcx
               	movq	%rbp, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	subq	%rax, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	cmpq	$0x100000, %rcx         # imm = 0x100000
               	jle	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
