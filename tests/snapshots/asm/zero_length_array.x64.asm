
zero_length_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x14, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x1e, %ecx
               	movb	%cl, 0x6(%rax)
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movzbq	0x4(%rax), %rcx
               	xorq	$0xa, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0x14, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	xorq	$0x1e, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	0x4(%rax), %rcx
               	addq	$0x4, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xab, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0xcd, %ecx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x4(%rax), %rcx
               	xorq	$0xab, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	xorq	$0xcd, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzwq	0x4(%rax), %rax
               	andq	$0xff, %rax
               	cmpq	$0xab, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
