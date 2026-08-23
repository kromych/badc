
inline_asm_rw_aggregate_param.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	movb	%dl, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	movl	$0xa, %edx
               	movb	%dl, (%rsi)
               	movl	$0x1, %esi
               	movb	%sil, 0x1(%rax)
               	movb	%dl, 0x1(%rcx)
               	movl	$0x2, %esi
               	movb	%sil, 0x2(%rax)
               	movb	%dl, 0x2(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xa, %edx
               	movb	%dl, 0x3(%rcx)
               	movl	$0x4, %esi
               	movb	%sil, 0x4(%rax)
               	movb	%dl, 0x4(%rcx)
               	movl	$0x5, %esi
               	movb	%sil, 0x5(%rax)
               	movb	%dl, 0x5(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xa, %edx
               	movb	%dl, 0x6(%rcx)
               	movl	$0x7, %esi
               	movb	%sil, 0x7(%rax)
               	movb	%dl, 0x7(%rcx)
               	movl	$0x8, %esi
               	movb	%sil, 0x8(%rax)
               	movb	%dl, 0x8(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xa, %edx
               	movb	%dl, 0x9(%rcx)
               	movb	%dl, 0xa(%rax)
               	movb	%dl, 0xa(%rcx)
               	movl	$0xb, %edx
               	movb	%dl, 0xb(%rax)
               	movl	$0xa, %edx
               	movb	%dl, 0xb(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movb	%dl, 0xc(%rcx)
               	movl	$0xd, %esi
               	movb	%sil, 0xd(%rax)
               	movb	%dl, 0xd(%rcx)
               	movl	$0xe, %edx
               	movb	%dl, 0xe(%rax)
               	movl	$0xa, %edx
               	movb	%dl, 0xe(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0xf, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movb	%dl, 0xf(%rcx)
               	leaq	-0x10(%rbp), %rdx
               	leaq	(%rdx), %rdi
               	leaq	(%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	addq	$0x0, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x1(%rcx), %rcx
               	addq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x1(%rdx)
               	movzbq	0x2(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x2(%rax), %rsi
               	addq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x2(%rdx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rax), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdx
               	movzbq	0x4(%rax), %rax
               	addq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x4(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0x5(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0x5(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x5(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	0x6(%rax), %rsi
               	movzbq	0x6(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rax), %rax
               	movzbq	0x7(%rdx), %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x7(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0x8(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0x8(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	0x9(%rax), %rsi
               	movzbq	0x9(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rax), %rax
               	movzbq	0xa(%rdx), %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xb(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0xb(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0xb(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	0xc(%rax), %rsi
               	movzbq	0xc(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rax), %rax
               	movzbq	0xd(%rdx), %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xd(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xe(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0xe(%rdx), %rdi
               	addq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0xe(%rcx)
               	leaq	-0x10(%rbp), %rsi
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rdx), %rcx
               	addq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xf(%rsi)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdi
               	leaq	0xa(%rcx), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
