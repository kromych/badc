
unary_minus_unsigned_literal_wraps.x64:	file format elf64-x86-64

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
               	movl	$0x7, %eax
               	movl	%eax, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	cmpl	$-0x1, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %ecx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %ecx
               	cmpl	$-0x1, %ecx
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %ecx
               	cmpl	$-0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %ecx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	movl	$0xffffffff, 0x10(%rsp) # imm = 0xFFFFFFFF
               	movl	0x10(%rsp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x10(%rsp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xffffffff, 0x18(%rsp) # imm = 0xFFFFFFFF
               	movl	0x18(%rsp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
