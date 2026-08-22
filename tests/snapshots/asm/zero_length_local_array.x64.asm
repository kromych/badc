
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
               	movl	$0x4, %eax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
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
               	cmpq	$0xb, %rax
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
               	leaq	-0x18(%rbp), %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
