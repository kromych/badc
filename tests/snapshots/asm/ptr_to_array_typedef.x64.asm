
ptr_to_array_typedef.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %rax
               	movl	$0x2, %edx
               	movq	%rdx, 0x18(%rax)
               	movq	%rax, (%rcx)
               	movq	-0x68(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rax
               	movq	0x18(%rax), %rax
               	addq	$0x1e, %rax
               	addq	$0x11, %rax
               	subq	$0x7, %rax
               	movslq	%eax, %rax
               	leave
               	retq
