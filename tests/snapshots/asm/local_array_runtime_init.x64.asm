
local_array_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<probe_short>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movzwq	(%rax,%rdi,2), %rax
               	leaq	-0x8(%rbp), %rcx
               	movw	%ax, (%rcx)
               	leaq	<rip>, %rax
               	movzwq	(%rax,%rdi,2), %rcx
               	leaq	-0x8(%rbp), %rax
               	movw	%cx, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	leaq	-0x8(%rbp), %rcx
               	movzwq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	(%rdi,%rsi), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	(%rdi,%rsi), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<probe_char>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	0x61(%rdi), %rax
               	movslq	%eax, %rcx
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, (%rax)
               	movl	$0x62, %ecx
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x64, %ecx
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movsbq	(%rax), %rax
               	addq	$0x0, %rax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x8(%rbp), %rcx
               	movsbq	0x3(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0xa(%rax)
               	leaq	<rip>, %rax
               	movl	$0x5678, %ecx           # imm = 0x5678
               	movw	%cx, 0xa(%rax)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x477198, %rax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x68, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x4(%rax), %rax
               	cmpq	$0x6f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x5(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
