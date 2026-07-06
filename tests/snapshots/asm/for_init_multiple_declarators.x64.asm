
for_init_multiple_declarators.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	imulq	%rdx, %rax
               	incq	%rdx
               	cmpq	$0x5, %rdx
               	jle	<addr>
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x2, %edx
               	jmp	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
