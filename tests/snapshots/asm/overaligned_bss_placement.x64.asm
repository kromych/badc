
overaligned_bss_placement.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0x7f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x1, %eax
               	movb	%al, (%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x2, %eax
               	movb	%al, (%rdx)
               	leaq	<rip>, %rsi
               	movl	$0x3, %eax
               	movb	%al, (%rsi)
               	leaq	<rip>, %rdi
               	movl	$0x4, %eax
               	movl	%eax, (%rdi)
               	movzbq	(%rcx), %rcx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movzbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
