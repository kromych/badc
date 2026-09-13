
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
               	leaq	<rip>, %rdi
               	movq	%rax, %rcx
               	leaq	-0x8(%rbp), %r8
               	movl	%eax, %esi
               	cmpl	$0x4, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	%edx, %r9d
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rsi, %r9
               	andq	$0x7, %r9
               	addq	%rdi, %r9
               	movzbq	(%r9), %r9
               	movb	%r9b, (%r8)
               	leaq	0x1(%rsi), %rax
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ecx, %rdx
               	leaq	0x1(%rdx), %rcx
               	addq	%rsi, %rdx
               	movzbq	-0x8(%rbp), %rsi
               	movb	%sil, (%rdx)
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rcx), %rdx
               	xorq	$0x42, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rdx
               	xorq	$0x41, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x2(%rcx), %rdx
               	xorq	$0x44, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	xorq	$0x43, %rcx
               	movl	%ecx, %ecx
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
