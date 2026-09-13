
runtime_array_member.x64:	file format elf64-x86-64

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
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	movslq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movslq	-0x8(%rbp), %rdx
               	addq	$0x3, %rdx
               	movslq	-0x8(%rbp), %rsi
               	addq	$0x64, %rsi
               	cmpl	$0xa, %edi
               	jne	<addr>
               	cmpl	$0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xc, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xd, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x6e, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rcx
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	movslq	-0x8(%rbp), %rdx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	cmpl	$0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rsi
               	movslq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movslq	-0x8(%rbp), %rdx
               	addq	$0x4, %rdx
               	cmpl	$0xa, %esi
               	jne	<addr>
               	movq	%rax, %rsi
               	cmpl	$0xc, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	cmpl	$0xe, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rcx
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rcx
               	incq	%rcx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %r9
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	movslq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movslq	-0x8(%rbp), %rdx
               	addq	$0x3, %rdx
               	movslq	-0x8(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	-0x8(%rbp), %rdi
               	addq	$0x5, %rdi
               	movslq	-0x8(%rbp), %r8
               	addq	$0x6, %r8
               	cmpl	$0xa, %r9d
               	jne	<addr>
               	cmpl	$0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xc, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	cmpl	$0xd, %edx
               	jne	<addr>
               	cmpl	$0xe, %esi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0xf, %edi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	cmpl	$0x10, %r8d
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	cmpl	$0xa, %edx
               	jne	<addr>
               	cmpl	$0xc, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
