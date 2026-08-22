
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x30(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x3, %edx
               	movb	%dl, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	(%rcx), %rdx
               	movl	$0xf0, %esi
               	movb	%sil, (%rdx)
               	movl	$0x14, %edx
               	movb	%dl, 0x1(%rax)
               	movl	$0xef, %edx
               	movb	%dl, 0x1(%rcx)
               	movl	$0x25, %edx
               	movb	%dl, 0x2(%rax)
               	movl	$0xee, %edx
               	movb	%dl, 0x2(%rcx)
               	movl	$0x36, %edx
               	movb	%dl, 0x3(%rax)
               	movl	$0xed, %eax
               	movb	%al, 0x3(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x47, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xec, %edx
               	movb	%dl, 0x4(%rcx)
               	movl	$0x58, %edx
               	movb	%dl, 0x5(%rax)
               	movl	$0xeb, %edx
               	movb	%dl, 0x5(%rcx)
               	movl	$0x69, %edx
               	movb	%dl, 0x6(%rax)
               	movl	$0xea, %edx
               	movb	%dl, 0x6(%rcx)
               	movl	$0x7a, %edx
               	movb	%dl, 0x7(%rax)
               	movl	$0xe9, %eax
               	movb	%al, 0x7(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x8b, %ecx
               	movb	%cl, 0x8(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xe8, %edx
               	movb	%dl, 0x8(%rcx)
               	movl	$0x9c, %edx
               	movb	%dl, 0x9(%rax)
               	movl	$0xe7, %edx
               	movb	%dl, 0x9(%rcx)
               	movl	$0xad, %edx
               	movb	%dl, 0xa(%rax)
               	movl	$0xe6, %edx
               	movb	%dl, 0xa(%rcx)
               	movl	$0xbe, %edx
               	movb	%dl, 0xb(%rax)
               	movl	$0xe5, %eax
               	movb	%al, 0xb(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	$0xcf, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0xe4, %edx
               	movb	%dl, 0xc(%rcx)
               	movl	$0xe0, %edx
               	movb	%dl, 0xd(%rax)
               	movl	$0xe3, %edx
               	movb	%dl, 0xd(%rcx)
               	movl	$0xf1, %edx
               	movb	%dl, 0xe(%rax)
               	movl	$0xe2, %edx
               	movb	%dl, 0xe(%rcx)
               	movl	$0x2, %edx
               	movb	%dl, 0xf(%rax)
               	movl	$0xe1, %eax
               	movb	%al, 0xf(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	leaq	-0x30(%rbp), %rax
               	leaq	(%rax), %rdx
               	movzbq	(%rdx), %rdi
               	leaq	-0x20(%rbp), %rdx
               	leaq	(%rdx), %r8
               	movzbq	(%r8), %r8
               	xorq	%r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x1(%rdx), %rdx
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x2(%rax), %rsi
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x2(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movzbq	0x3(%rdx), %rsi
               	movzbq	0x3(%rax), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdx
               	movzbq	0x4(%rax), %rax
               	xorq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x4(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0x5(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0x5(%rdx), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x5(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	0x6(%rax), %rsi
               	movzbq	0x6(%rdx), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rax), %rax
               	movzbq	0x7(%rdx), %rdx
               	xorq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x7(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0x8(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0x8(%rdx), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	0x9(%rax), %rsi
               	movzbq	0x9(%rdx), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rax), %rax
               	movzbq	0xa(%rdx), %rdx
               	xorq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xb(%rax), %rsi
               	leaq	-0x20(%rbp), %rdx
               	movzbq	0xb(%rdx), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0xb(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	0xc(%rax), %rsi
               	movzbq	0xc(%rdx), %rdi
               	xorq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rax), %rax
               	movzbq	0xd(%rdx), %rdx
               	xorq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xd(%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movzbq	0xe(%rdx), %rax
               	leaq	-0x20(%rbp), %rsi
               	movzbq	0xe(%rsi), %rdi
               	xorq	%rdi, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xe(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movzbq	0xf(%rdx), %rax
               	movzbq	0xf(%rsi), %rcx
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xf(%rdi)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rcx), %r9
               	movzbq	(%r9), %r9
               	leaq	(%rsi,%rcx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	%rbx, %r9
               	andq	$0xff, %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
