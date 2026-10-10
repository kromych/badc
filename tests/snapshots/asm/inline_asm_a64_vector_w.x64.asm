
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
               	movb	$0x3, -0x30(%rbp)
               	movb	$-0x10, -0x20(%rbp)
               	movb	$0x14, -0x2f(%rbp)
               	movb	$-0x11, -0x1f(%rbp)
               	movb	$0x25, -0x2e(%rbp)
               	movb	$-0x12, -0x1e(%rbp)
               	movb	$0x36, -0x2d(%rbp)
               	movb	$-0x13, -0x1d(%rbp)
               	movb	$0x47, -0x2c(%rbp)
               	movb	$-0x14, -0x1c(%rbp)
               	movb	$0x58, -0x2b(%rbp)
               	movb	$-0x15, -0x1b(%rbp)
               	movb	$0x69, -0x2a(%rbp)
               	movb	$-0x16, -0x1a(%rbp)
               	movb	$0x7a, -0x29(%rbp)
               	movb	$-0x17, -0x19(%rbp)
               	movb	$-0x75, -0x28(%rbp)
               	movb	$-0x18, -0x18(%rbp)
               	movb	$-0x64, -0x27(%rbp)
               	movb	$-0x19, -0x17(%rbp)
               	movb	$-0x53, -0x26(%rbp)
               	movb	$-0x1a, -0x16(%rbp)
               	movb	$-0x42, -0x25(%rbp)
               	movb	$-0x1b, -0x15(%rbp)
               	movb	$-0x31, -0x24(%rbp)
               	movb	$-0x1c, -0x14(%rbp)
               	movb	$-0x20, -0x23(%rbp)
               	movb	$-0x1d, -0x13(%rbp)
               	movb	$-0xf, -0x22(%rbp)
               	movb	$-0x1e, -0x12(%rbp)
               	movb	$0x2, -0x21(%rbp)
               	movb	$-0x1f, -0x11(%rbp)
               	movzbq	-0x30(%rbp), %rax
               	movzbq	-0x20(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x10(%rbp)
               	movzbq	-0x2f(%rbp), %rax
               	movzbq	-0x1f(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xf(%rbp)
               	movzbq	-0x2e(%rbp), %rax
               	movzbq	-0x1e(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xe(%rbp)
               	movzbq	-0x2d(%rbp), %rax
               	movzbq	-0x1d(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xd(%rbp)
               	movzbq	-0x2c(%rbp), %rax
               	movzbq	-0x1c(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xc(%rbp)
               	movzbq	-0x2b(%rbp), %rax
               	movzbq	-0x1b(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xb(%rbp)
               	movzbq	-0x2a(%rbp), %rax
               	movzbq	-0x1a(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0xa(%rbp)
               	movzbq	-0x29(%rbp), %rax
               	movzbq	-0x19(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x9(%rbp)
               	movzbq	-0x28(%rbp), %rax
               	movzbq	-0x18(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x27(%rbp), %rax
               	movzbq	-0x17(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x7(%rbp)
               	movzbq	-0x26(%rbp), %rax
               	movzbq	-0x16(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x6(%rbp)
               	movzbq	-0x25(%rbp), %rax
               	movzbq	-0x15(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x5(%rbp)
               	movzbq	-0x24(%rbp), %rax
               	movzbq	-0x14(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x4(%rbp)
               	movzbq	-0x23(%rbp), %rax
               	movzbq	-0x13(%rbp), %rcx
               	xorq	%rcx, %rax
               	movb	%al, -0x3(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	-0x22(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movzbq	-0x12(%rbp), %rsi
               	xorq	%rsi, %rax
               	movb	%al, -0x2(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movzbq	-0x21(%rbp), %rax
               	movzbq	-0x11(%rbp), %rdi
               	xorq	%rdi, %rax
               	movb	%al, -0x1(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdi
               	movzbq	(%rcx,%rax), %r8
               	movzbq	(%rdx,%rax), %r9
               	xorq	%r9, %r8
               	cmpl	%r8d, %edi
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
