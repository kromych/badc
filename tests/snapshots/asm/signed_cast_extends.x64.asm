
signed_cast_extends.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xff, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %eax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %eax       # imm = 0x1234ABFF
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5678, %rax           # imm = 0x5678
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %eax       # imm = 0x1234FFFF
               	movswq	%ax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2a, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movl	$0xff, %ecx
               	movb	%cl, (%rax)
               	leaq	-0xb8(%rbp), %rax
               	movl	$0x42, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0xb8(%rbp), %rax
               	movl	$0x10, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movzbq	(%rax), %rax
               	movsbq	%al, %rax
               	shlq	$0x8, %rax
               	movslq	%eax, %rax
               	leaq	-0xb8(%rbp), %rcx
               	movzbq	0x1(%rcx), %rcx
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$-0xbe, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
