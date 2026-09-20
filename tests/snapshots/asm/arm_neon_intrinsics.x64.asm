
arm_neon_intrinsics.x64:	file format elf64-x86-64

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
               	leaq	-0x40(%rbp), %rax
               	movb	$0x7, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	movb	$-0x3d, (%rcx)
               	leaq	-0x20(%rbp), %rdx
               	movb	$0x1, (%rdx)
               	movb	$0x26, 0x1(%rax)
               	movb	$-0x3a, 0x1(%rcx)
               	movb	$0x2, 0x1(%rdx)
               	movb	$0x45, 0x2(%rax)
               	movb	$-0x37, 0x2(%rcx)
               	movb	$0x5, 0x2(%rdx)
               	leaq	-0x40(%rbp), %rax
               	movb	$0x64, 0x3(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movb	$-0x34, 0x3(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	movb	$0xa, 0x3(%rdx)
               	movb	$-0x7d, 0x4(%rax)
               	movb	$-0x29, 0x4(%rcx)
               	movb	$0x11, 0x4(%rdx)
               	movb	$-0x5e, 0x5(%rax)
               	movb	$-0x26, 0x5(%rcx)
               	movb	$0x1a, 0x5(%rdx)
               	leaq	-0x40(%rbp), %rax
               	movb	$-0x3f, 0x6(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movb	$-0x23, 0x6(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	movb	$0x25, 0x6(%rdx)
               	movb	$-0x20, 0x7(%rax)
               	movb	$-0x20, 0x7(%rcx)
               	movb	$0x32, 0x7(%rdx)
               	movb	$-0x1, 0x8(%rax)
               	movb	$-0x15, 0x8(%rcx)
               	movb	$0x41, 0x8(%rdx)
               	leaq	-0x40(%rbp), %rax
               	movb	$0x1e, 0x9(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movb	$-0x12, 0x9(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	movb	$0x52, 0x9(%rdx)
               	movb	$0x3d, 0xa(%rax)
               	movb	$-0xf, 0xa(%rcx)
               	movb	$0x65, 0xa(%rdx)
               	movb	$0x5c, 0xb(%rax)
               	movb	$-0xc, 0xb(%rcx)
               	movb	$0x7a, 0xb(%rdx)
               	leaq	-0x40(%rbp), %rax
               	movb	$0x7b, 0xc(%rax)
               	leaq	-0x30(%rbp), %rcx
               	movb	$-0x1, 0xc(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	movb	$-0x6f, 0xc(%rdx)
               	movb	$-0x66, 0xd(%rax)
               	movb	$-0x7e, 0xd(%rcx)
               	movb	$-0x56, 0xd(%rdx)
               	movb	$-0x47, 0xe(%rax)
               	movb	$-0x7b, 0xe(%rcx)
               	movb	$-0x3b, 0xe(%rdx)
               	leaq	-0x40(%rbp), %rdx
               	movb	$-0x28, 0xf(%rdx)
               	leaq	-0x30(%rbp), %rdi
               	movb	$-0x78, 0xf(%rdi)
               	leaq	-0x20(%rbp), %rax
               	movb	$-0x1e, 0xf(%rax)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rdi,%rax), %r8
               	xorq	%r8, %rsi
               	movb	%sil, (%rcx,%rax)
               	movzbq	(%rcx,%rax), %rcx
               	movzbq	(%rdx,%rax), %rsi
               	leaq	-0x30(%rbp), %r8
               	movzbq	(%r8,%rax), %r8
               	xorq	%r8, %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movzbq	(%rsi,%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	testb	$-0x80, %cl
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%r8, %rcx
               	movq	%rcx, %r8
               	andq	$0xff, %r8
               	movzbq	(%rsi,%rax), %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	testb	$-0x80, %cl
               	je	<addr>
               	movl	$0x1d, %ecx
               	xorq	%rsi, %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
