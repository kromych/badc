
bitwise_not_mvn.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<notx>:
               	movq	%rdi, %rax
               	xorq	$-0x1, %rax
               	retq

<andnot>:
               	movq	%rdi, %rax
               	xorq	$-0x1, %rax
               	andq	%rsi, %rax
               	retq

<ch>:
               	movq	%rdi, %rax
               	andq	%rsi, %rax
               	movq	%rdi, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rcx
               	xorq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %rcx # imm = 0xFEDCBA9876543210
               	movabsq	$-0x5555aaaa5555aaab, %rdx # imm = 0xAAAA5555AAAA5555
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rcx, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rcx, %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	andq	%rcx, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdx, %rdi
               	xorq	%rdi, %rsi
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
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
               	addb	%al, 0x41(%rdx)
