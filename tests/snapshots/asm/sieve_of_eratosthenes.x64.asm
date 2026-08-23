
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
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	leaq	(%rsi,%r8), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	addq	%rsi, %rdx
               	movl	$0x1, %edi
               	movb	%dil, (%rdx)
               	addq	%rcx, %rax
               	movslq	%eax, %rdx
               	cmpq	$0x186a0, %rdx          # imm = 0x186A0
               	jl	<addr>
               	leaq	0x1(%r8), %rcx
               	movslq	%ecx, %r8
               	movq	%r8, %rax
               	imulq	%r8, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rax, %rax
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdi
               	jmp	<addr>
               	leaq	(%rdi,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x186a0, %rdx          # imm = 0x186A0
               	jl	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2578, %rax           # imm = 0x2578
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
