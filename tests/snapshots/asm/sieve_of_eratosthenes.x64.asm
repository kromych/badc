
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
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%edx, %rsi
               	addq	%rsi, %rax
               	movl	$0x1, %esi
               	movb	%sil, (%rax)
               	addq	%rcx, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	imulq	%rax, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rdx, %rdx
               	movl	$0x2, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	addq	%rsi, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
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
