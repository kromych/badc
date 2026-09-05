
zero_length_array_sizeof.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x7, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	<rip>, %rsi
               	movq	%rsi, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	0x4(%rax), %edx
               	cmpl	$0x4, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	%edx, %r8d
               	testq	%r8, %r8
               	je	<addr>
               	movl	0x4(%rax), %r8d
               	andq	$0x7, %r8
               	addq	%rsi, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, (%rdi)
               	movl	0x4(%rax), %edi
               	incq	%rdi
               	movl	%edi, 0x4(%rax)
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x28(%rbp), %rdi
               	movslq	%ecx, %rdx
               	leaq	0x1(%rdx), %rcx
               	addq	%rdi, %rdx
               	movzbq	-0x20(%rbp), %rdi
               	movb	%dil, (%rdx)
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x42, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x41, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x44, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x3(%rax), %rax
               	xorq	$0x43, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	0x4(%rax), %eax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
