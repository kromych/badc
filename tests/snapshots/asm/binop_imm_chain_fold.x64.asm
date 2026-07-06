
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %eax
               	leaq	0x3(%rax), %rcx
               	addq	$0x7, %rcx
               	leaq	0x8(%rax), %rdx
               	subq	$0x3, %rdx
               	leaq	-0x4(%rax), %rsi
               	addq	$0x9, %rsi
               	leaq	-0x2(%rax), %rdi
               	subq	$0x5, %rdi
               	movq	%rax, %r8
               	andq	$0x3f, %r8
               	movq	%rax, %r9
               	orq	$0x3, %r9
               	xorq	$0x3, %rax
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
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
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
