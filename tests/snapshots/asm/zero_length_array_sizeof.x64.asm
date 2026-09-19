
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
               	xorl	%eax, %eax
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	leaq	-0x8(%rbp), %rdi
               	cmpl	$0x4, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rax, %r8
               	andq	$0x7, %r8
               	movzbq	(%rsi,%r8), %r8
               	movb	%r8b, (%rdi)
               	incq	%rax
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	0x1(%rcx), %rdx
               	movzbq	-0x8(%rbp), %r8
               	movb	%r8b, (%rdi,%rcx)
               	cmpl	$0x4, %edx
               	jge	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
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
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rdx
               	xorq	$0x41, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x2(%rcx), %rdx
               	xorq	$0x44, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	xorq	$0x43, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
