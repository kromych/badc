
extern_in_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<wrap>:
               	movslq	%edi, %rdi
               	imulq	$-0x1, %rdi, %rax
               	retq

<negate>:
               	movslq	%edi, %rdi
               	imulq	$-0x1, %rdi, %rax
               	retq

<main>:
               	movabsq	$-0x5, %rax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x7, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x3, %eax
               	imulq	$-0x1, %rax, %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movabsq	$-0x1, %rax
               	imulq	$-0x1, %rax, %rcx
               	imulq	$-0x1, %rax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
