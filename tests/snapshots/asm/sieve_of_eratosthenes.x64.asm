
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
               	addq	%rdi, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	addq	%rsi, %rdx
               	movl	$0x1, %esi
               	movb	%sil, (%rdx)
               	addq	%rcx, %rax
               	movslq	%eax, %rdx
               	cmpq	$0x186a0, %rdx          # imm = 0x186A0
               	jl	<addr>
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rdi
               	movq	%rdi, %rax
               	imulq	%rdi, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rax, %rax
               	movl	$0x2, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	addq	%rdx, %rsi
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
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
