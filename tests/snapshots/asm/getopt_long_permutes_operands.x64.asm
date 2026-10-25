
getopt_long_permutes_operands.x64:	file format elf64-x86-64

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
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	leaq	-0x1a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rcx), %r10
               	movb	%r10b, 0x4(%rax)
               	leaq	-0x198(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x190(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	-0x188(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movzbq	0x4(%rdi), %r10
               	movb	%r10b, 0x4(%rsi)
               	leaq	-0x180(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	movzbq	0x4(%r8), %r10
               	movb	%r10b, 0x4(%rdi)
               	leaq	-0x178(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	leaq	-0xe8(%rbp), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rdi)
               	movzwq	0x8(%r8), %r10
               	movw	%r10w, 0x8(%rdi)
               	leaq	-0x170(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	movzwq	0x4(%r8), %r10
               	movw	%r10w, 0x4(%rdi)
               	movzbq	0x6(%r8), %r10
               	movb	%r10b, 0x6(%rdi)
               	leaq	-0x168(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	movzwq	0x4(%r8), %r10
               	movw	%r10w, 0x4(%rdi)
               	movzbq	0x6(%r8), %r10
               	movb	%r10b, 0x6(%rdi)
               	leaq	-0x160(%rbp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	leaq	-0x158(%rbp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	leaq	-0x60(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movups	%xmm14, 0x50(%rdi)
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	leaq	-0x180(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x178(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	leaq	-0xe8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x170(%rbp), %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x168(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x160(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x158(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x150(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rdx), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	-0x148(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movzwq	(%rsi), %r10
               	movw	%r10w, (%rdx)
               	movzbq	0x2(%rsi), %r10
               	movb	%r10b, 0x2(%rdx)
               	leaq	-0x140(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movzwq	(%rdi), %r10
               	movw	%r10w, (%rsi)
               	movzbq	0x2(%rdi), %r10
               	movb	%r10b, 0x2(%rsi)
               	leaq	-0xd8(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	$0x0, -0xc0(%rbp)
               	leaq	-0x138(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rdx), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	-0x130(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	movzwq	0x4(%rsi), %r10
               	movw	%r10w, 0x4(%rdx)
               	movzbq	0x6(%rsi), %r10
               	movb	%r10b, 0x6(%rdx)
               	leaq	-0x128(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x120(%rbp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	leaq	-0xb8(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movq	$0x0, 0x20(%rdi)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	leaq	-0x120(%rbp), %rcx
               	movq	%rcx, -0xa0(%rbp)
               	movq	$0x0, -0x98(%rbp)
               	leaq	-0x118(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rdx), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	-0x110(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movzwq	(%rsi), %r10
               	movw	%r10w, (%rdx)
               	movzbq	0x2(%rsi), %r10
               	movb	%r10b, 0x2(%rdx)
               	leaq	-0x108(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	leaq	-0xf8(%rbp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	leaq	-0x90(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	leaq	-0x100(%rbp), %rcx
               	movq	%rcx, -0x78(%rbp)
               	leaq	-0xf8(%rbp), %rcx
               	movq	%rcx, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	leaq	<rip>, %rdx
               	movl	$0xffffffff, -0xf0(%rbp) # imm = 0xFFFFFFFF
               	movq	<rip>, %rcx # <addr>
               	movl	$0x0, (%rcx)
               	movq	<rip>, %rcx # <addr>
               	movl	$0x0, (%rcx)
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x62, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x42, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0xf0(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x47, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0xf0(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x63, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	-0xf0(%rbp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xb, %edi
               	leaq	-0x60(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	xorl	%r8d, %r8d
               	movl	%r8d, (%rax)
               	movl	$0x3, %edi
               	leaq	-0xd8(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3f, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	-0xd8(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x4, %edi
               	leaq	-0xb8(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	jne	<addr>
               	cmpl	$0x0, -0xf0(%rbp)
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x4, %edi
               	leaq	-0xb8(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x42, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x4, %edi
               	leaq	-0xb8(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x4, %edi
               	leaq	-0xb8(%rbp), %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0xf0(%rbp), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x1, (%rax)
               	movl	$0x5, %edi
               	leaq	-0x90(%rbp), %rsi
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	leaq	-0x90(%rbp), %rsi
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x62, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	leaq	-0x90(%rbp), %rsi
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	leaq	-0x90(%rbp), %rsi
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
