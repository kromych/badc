
sieve_of_eratosthenes.x64:	file format elf64-x86-64

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
               	movl	$0x2, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	%rdi, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	%eax, %rsi
               	addq	%rsi, %rdx
               	movl	$0x1, %esi
               	movb	%sil, (%rdx)
               	addq	%rcx, %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rdi
               	movq	%rdi, %rax
               	imulq	%rdi, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movslq	%eax, %rdx
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	cmpl	$0x2578, %ecx           # imm = 0x2578
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
