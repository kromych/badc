
inline_two_word_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<mkpair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rcx
               	imulq	$0xa, %rdx, %rdx
               	leaq	-0xe8(%rbp), %rsi
               	movl	%edx, (%rsi)
               	leaq	-0xe8(%rbp), %rdx
               	movl	$0x1, %esi
               	movq	%rsi, 0x8(%rdx)
               	leaq	-0xe8(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	%ecx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movslq	(%rax), %rax
               	leaq	-0x80(%rbp), %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xaaaa, %eax           # imm = 0xAAAA
               	movl	$0xbbbb, %ecx           # imm = 0xBBBB
               	leaq	-0xf8(%rbp), %rdx
               	movq	%rax, (%rdx)
               	leaq	-0xf8(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xf8(%rbp), %rax
               	leaq	-0xb8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xb8(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0xb8(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
