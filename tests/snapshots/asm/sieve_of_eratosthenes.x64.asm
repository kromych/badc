
sieve_of_eratosthenes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x2, %ecx
               	movslq	%ecx, %rax
               	imulq	%rax, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jge	<addr>
               	jmp	<addr>
               	addq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%edx, %rsi
               	addq	%rsi, %rax
               	movl	$0x1, %esi
               	movb	%sil, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	addq	%rsi, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x2578, %rax           # imm = 0x2578
               	jne	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
