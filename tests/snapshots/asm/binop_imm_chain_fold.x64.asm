
binop_imm_chain_fold.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x7, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x8, %rdx
               	movslq	%edx, %rdx
               	subq	$0x3, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	subq	$0x4, %rsi
               	movslq	%esi, %rsi
               	addq	$0x9, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	subq	$0x2, %rdi
               	movslq	%edi, %rdi
               	subq	$0x5, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	andq	$0x3f, %r8
               	movq	%rax, %r9
               	orq	$0x3, %r9
               	xorq	$0x3, %rax
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r9d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x53, %rbx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
