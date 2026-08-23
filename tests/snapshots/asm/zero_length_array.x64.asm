
zero_length_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movl	$0x3, %edx
               	movl	%edx, (%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x14, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x1e, %ecx
               	movb	%cl, 0x6(%rax)
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movzbq	0x4(%rax), %rcx
               	xorq	$0xa, %rcx
               	movl	%ecx, %ecx
               	movl	$0x1, %esi
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0x14, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	xorq	$0x1e, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	%esi, (%rax)
               	movl	$0xab, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0xcd, %ecx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x4(%rax), %rcx
               	xorq	$0xab, %rcx
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0xcd, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzwq	0x4(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0xab, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
