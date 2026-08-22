
indirect_struct_return.x64:	file format elf64-x86-64

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

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, (%rax)
               	movq	%rdi, %rax
               	shlq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorq	%rax, %rax
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
