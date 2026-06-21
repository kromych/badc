
bitop_common_type.x64:	file format elf64-x86-64

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
               	movabsq	$0x14006f000, %rax      # imm = 0x14006F000
               	xorq	%rcx, %rcx
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	incq	%rdx
               	movabsq	$0x14006f001, %r13      # imm = 0x14006F001
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rax, %rdx
               	incq	%rdx
               	movabsq	$0x14006f001, %r13      # imm = 0x14006F001
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	xorq	%rcx, %rdx
               	incq	%rdx
               	movabsq	$0x14006f001, %r13      # imm = 0x14006F001
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x14006f001, %rdx      # imm = 0x14006F001
               	decq	%rdx
               	orq	$0xf, %rdx
               	incq	%rdx
               	movabsq	$0x14006f010, %r13      # imm = 0x14006F010
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movabsq	$0x14006f000, %r13      # imm = 0x14006F000
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movabsq	$0x14006f000, %r13      # imm = 0x14006F000
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	orq	%rcx, %rax
               	movabsq	$0x100000000, %r13      # imm = 0x100000000
               	cmpq	%r13, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
