
inline_one_word_struct.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_sr>:
               	movslq	%esi, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rdi,%rcx,8), %r8
               	addq	%r8, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x28(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x64, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0xc8, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x190, %ecx            # imm = 0x190
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x1f4, %ecx            # imm = 0x1F4
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x5dc, %rax            # imm = 0x5DC
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
