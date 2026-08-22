
zero_length_local_array.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %ecx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x6, %edx
               	movl	%edx, 0x4(%rax)
               	movl	$0x7, %esi
               	movl	%esi, 0x8(%rax)
               	leaq	-0x8(%rbp), %rsi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	jmp	<addr>
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
