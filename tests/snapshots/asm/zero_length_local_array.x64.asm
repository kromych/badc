
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
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %ecx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movslq	(%rdx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x6, %esi
               	movl	%esi, 0x4(%rax)
               	movl	$0x7, %edi
               	movl	%edi, 0x8(%rax)
               	leaq	-0x8(%rbp), %rdi
               	cmpq	%rax, %rdi
               	je	<addr>
               	movslq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rdi
               	addq	%rdi, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
