
sieve_of_eratosthenes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x2, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	%rax, %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	imulq	%rcx, %rdx
               	movslq	%edx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movl	$0x1, %edi
               	movb	%dil, (%rdx)
               	addq	%rcx, %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x186a0, %rdx          # imm = 0x186A0
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	cmpq	$0x186a0, %rdx          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rdx, %rdx
               	movl	$0x2, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	addq	%rax, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%edx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x2578, %rax           # imm = 0x2578
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
