
integer_literal_suffix.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%r13, (%rsp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	movabsq	$0xfffffffff, %r13      # imm = 0xFFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24, %eax
               	movl	$0x1, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	decq	%rax
               	movabsq	$0xfffffffff, %r13      # imm = 0xFFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789, %rax      # imm = 0x123456789
               	incq	%rax
               	movabsq	$0x12345678a, %r13      # imm = 0x12345678A
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdx
               	cmpq	%r13, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	incq	%rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
