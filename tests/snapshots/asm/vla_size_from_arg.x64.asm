
vla_size_from_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fill_and_sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rsi
               	subq	%r11, %rsi
               	movq	%rsi, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %r9
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rsi,%rdx), %r8
               	movsbq	(%r8), %r8
               	addq	%r8, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
