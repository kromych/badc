
aligned_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0xd0(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x14(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x14, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rcx
               	leaq	0x10(%rcx), %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x10, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, 0x10(%rax)
               	movabsq	$-0x3, %rdx
               	movq	%rdx, 0x18(%rax)
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$-0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
