
bitwise_not_mvn.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	subq	$0x28, %rsp
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, 0x8(%rsp)
               	movabsq	$-0x123456789abcdf0, %rax # imm = 0xFEDCBA9876543210
               	movq	%rax, 0x10(%rsp)
               	movabsq	$-0x5555aaaa5555aaab, %rax # imm = 0xAAAA5555AAAA5555
               	movq	%rax, 0x18(%rsp)
               	movq	0x8(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	0x8(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	xorq	$-0x1, %rax
               	andq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	movq	0x10(%rsp), %rdx
               	andq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	andq	%rdx, %rcx
               	movq	0x8(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movq	0x18(%rsp), %rsi
               	andq	%rsi, %rdx
               	xorq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	$-0x1, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	addq	$0x28, %rsp
               	retq
