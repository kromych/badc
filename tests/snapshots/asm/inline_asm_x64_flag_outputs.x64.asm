
inline_asm_x64_flag_outputs.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	$0x2, %edx
               	addq	%rdx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	cmpq	$0x3, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	$-0x1, %rax
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, -0x10(%rbp)
               	addq	$0xc, %rcx
               	movq	%rcx, -0x8(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %ecx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	$-0x1, %rcx
               	testq	%rcx, %rcx
               	sets	%al
               	movzbq	%al, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	sets	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	seto	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	seto	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %ecx
               	movl	$0x7, %edx
               	cmpq	%rdx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	movl	$0x7, %edx
               	cmpq	%rdx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
