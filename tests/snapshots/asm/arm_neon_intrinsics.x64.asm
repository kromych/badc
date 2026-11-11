
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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	movb	$0x7, -0x40(%rbp)
               	movb	$-0x3d, -0x30(%rbp)
               	movb	$0x1, -0x20(%rbp)
               	movb	$0x26, -0x3f(%rbp)
               	movb	$-0x3a, -0x2f(%rbp)
               	movb	$0x2, -0x1f(%rbp)
               	movb	$0x45, -0x3e(%rbp)
               	movb	$-0x37, -0x2e(%rbp)
               	movb	$0x5, -0x1e(%rbp)
               	movb	$0x64, -0x3d(%rbp)
               	movb	$-0x34, -0x2d(%rbp)
               	movb	$0xa, -0x1d(%rbp)
               	movb	$-0x7d, -0x3c(%rbp)
               	movb	$-0x29, -0x2c(%rbp)
               	movb	$0x11, -0x1c(%rbp)
               	movb	$-0x5e, -0x3b(%rbp)
               	movb	$-0x26, -0x2b(%rbp)
               	movb	$0x1a, -0x1b(%rbp)
               	movb	$-0x3f, -0x3a(%rbp)
               	movb	$-0x23, -0x2a(%rbp)
               	movb	$0x25, -0x1a(%rbp)
               	movb	$-0x20, -0x39(%rbp)
               	movb	$-0x20, -0x29(%rbp)
               	movb	$0x32, -0x19(%rbp)
               	movb	$-0x1, -0x38(%rbp)
               	movb	$-0x15, -0x28(%rbp)
               	movb	$0x41, -0x18(%rbp)
               	movb	$0x1e, -0x37(%rbp)
               	movb	$-0x12, -0x27(%rbp)
               	movb	$0x52, -0x17(%rbp)
               	movb	$0x3d, -0x36(%rbp)
               	movb	$-0xf, -0x26(%rbp)
               	movb	$0x65, -0x16(%rbp)
               	movb	$0x5c, -0x35(%rbp)
               	movb	$-0xc, -0x25(%rbp)
               	movb	$0x7a, -0x15(%rbp)
               	movb	$0x7b, -0x34(%rbp)
               	movb	$-0x1, -0x24(%rbp)
               	movb	$-0x6f, -0x14(%rbp)
               	movb	$-0x66, -0x33(%rbp)
               	movb	$-0x7e, -0x23(%rbp)
               	movb	$-0x56, -0x13(%rbp)
               	movb	$-0x47, -0x32(%rbp)
               	movb	$-0x7b, -0x22(%rbp)
               	movb	$-0x3b, -0x12(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movb	$-0x28, -0x31(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movb	$-0x78, -0x21(%rbp)
               	movb	$-0x1e, -0x11(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdi,%rax), %r8
               	xorq	%r8, %rsi
               	movb	%sil, (%rdx,%rax)
               	movzbq	(%rdx,%rax), %rdx
               	movzbq	(%rcx,%rax), %rsi
               	leaq	-0x30(%rbp), %r8
               	movzbq	(%r8,%rax), %r8
               	xorq	%r8, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	xorl	%ebx, %ebx
               	testb	$-0x80, %sil
               	movq	%rbx, %rsi
               	cmovneq	%r9, %rsi
               	xorq	%r8, %rsi
               	andq	$0xff, %rsi
               	movzbq	(%rdx,%rax), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	xorl	%ebx, %ebx
               	testb	$-0x80, %dl
               	movq	%rbx, %rdx
               	cmovneq	%r9, %rdx
               	xorq	%r8, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
