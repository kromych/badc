
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
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	leaq	<rip>, %r8
               	movq	%rax, %rdx
               	leaq	-0x8(%rbp), %r9
               	movl	%eax, %esi
               	cmpl	$0x4, %esi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testl	%edi, %edi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	%rsi, %rdi
               	andq	$0x7, %rdi
               	addq	%r8, %rdi
               	movzbq	(%rdi), %rdi
               	movb	%dil, (%r9)
               	leaq	0x1(%rsi), %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	addq	%rsi, %rcx
               	movzbq	-0x8(%rbp), %rsi
               	movb	%sil, (%rcx)
               	cmpl	$0x4, %edx
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0x4, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x42, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rdx
               	xorq	$0x41, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x2(%rcx), %rdx
               	xorq	$0x44, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	xorq	$0x43, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	%eax, %eax
               	xorq	$0x4, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
