
inline_asm_a64_vector_w.x64:	file format elf64-x86-64

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
               	movb	$0x3, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movb	$-0x10, (%rcx)
               	movb	$0x14, 0x1(%rax)
               	movb	$-0x11, 0x1(%rcx)
               	movb	$0x25, 0x2(%rax)
               	movb	$-0x12, 0x2(%rcx)
               	movb	$0x36, 0x3(%rax)
               	movb	$-0x13, 0x3(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movb	$0x47, 0x4(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movb	$-0x14, 0x4(%rcx)
               	movb	$0x58, 0x5(%rax)
               	movb	$-0x15, 0x5(%rcx)
               	movb	$0x69, 0x6(%rax)
               	movb	$-0x16, 0x6(%rcx)
               	movb	$0x7a, 0x7(%rax)
               	movb	$-0x17, 0x7(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movb	$-0x75, 0x8(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movb	$-0x18, 0x8(%rcx)
               	movb	$-0x64, 0x9(%rax)
               	movb	$-0x19, 0x9(%rcx)
               	movb	$-0x53, 0xa(%rax)
               	movb	$-0x1a, 0xa(%rcx)
               	movb	$-0x42, 0xb(%rax)
               	movb	$-0x1b, 0xb(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movb	$-0x31, 0xc(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movb	$-0x1c, 0xc(%rcx)
               	movb	$-0x20, 0xd(%rax)
               	movb	$-0x1d, 0xd(%rcx)
               	movb	$-0xf, 0xe(%rax)
               	movb	$-0x1e, 0xe(%rcx)
               	movb	$0x2, 0xf(%rax)
               	movb	$-0x1f, 0xf(%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movzbq	0x2(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x30(%rbp), %rdx
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rcx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rdx
               	movzbq	0x4(%rcx), %rcx
               	xorq	%rdx, %rcx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	0x5(%rcx), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0x5(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rcx
               	movzbq	0x7(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	0x8(%rcx), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0x8(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rcx
               	movzbq	0xa(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movb	%cl, 0xa(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	0xb(%rcx), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0xb(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rcx
               	movzbq	0xd(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	0xe(%rcx), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0xe(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	leaq	-0x10(%rbp), %rsi
               	movzbq	0xf(%rcx), %rax
               	movzbq	0xf(%rdx), %rdi
               	xorq	%rdi, %rax
               	movb	%al, 0xf(%rsi)
               	xorl	%eax, %eax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movzbq	(%rsi,%rax), %r8
               	movzbq	(%rcx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r9
               	xorq	%r9, %rdi
               	cmpl	%edi, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
