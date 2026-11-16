
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
               	movl	$0x1, %eax
               	movl	$0x2, %edx
               	addq	%rdx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x3, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$-0x1, %rax
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0xc, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0xd, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%ecx, %ecx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x9, %ecx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	$-0x1, %rcx
               	testq	%rcx, %rcx
               	sets	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	sets	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	seto	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	seto	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x5, %eax
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
               	retq
               	movl	$0x2a, %eax
               	retq
