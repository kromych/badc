
bitwise_not_mvn.x64:	file format elf64-x86-64

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
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x123456789abcdf0, %rax # imm = 0xFEDCBA9876543210
               	movq	%rax, -0x10(%rbp)
               	movabsq	$-0x5555aaaa5555aaab, %rax # imm = 0xAAAA5555AAAA5555
               	movq	%rax, -0x18(%rbp)
               	movq	-0x8(%rbp), %rax
               	xorq	$-0x1, %rax
               	movq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	xorq	$-0x1, %rax
               	andq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	movq	-0x10(%rbp), %rdx
               	andq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	-0x10(%rbp), %rdx
               	andq	%rdx, %rcx
               	movq	-0x8(%rbp), %rdx
               	xorq	$-0x1, %rdx
               	movq	-0x18(%rbp), %rsi
               	andq	%rsi, %rdx
               	xorq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	xorq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	xorq	$-0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
