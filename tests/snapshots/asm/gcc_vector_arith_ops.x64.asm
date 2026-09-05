
gcc_vector_arith_ops.x64:	file format elf64-x86-64

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

<same>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0xed0, %rsp            # imm = 0xED0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	subq	$0x8e0, %rsp            # imm = 0x8E0
               	andq	$-0x20, %rsp
               	leaq	0x80(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0xa0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0xb0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0xc0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0xd0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0xe0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0xf0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x100(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x110(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x120(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x130(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x140(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x150(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x170(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x108(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0x1678(%rbp), %rax
               	movl	$0x1, %edi
               	movb	%dil, (%rax)
               	movl	$0x3, %edi
               	movb	%dil, 0x1(%rax)
               	movl	$0x5, %edi
               	movb	%dil, 0x2(%rax)
               	movl	$0x7, %edi
               	movb	%dil, 0x3(%rax)
               	movl	$0x12c, %r8d            # imm = 0x12C
               	movb	%r8b, 0x4(%rax)
               	movl	$0x100, %edi            # imm = 0x100
               	movb	%dil, 0x5(%rax)
               	movb	%dil, 0x6(%rax)
               	movb	%r8b, 0x7(%rax)
               	movb	%dil, 0x8(%rax)
               	movl	$0x8, %edi
               	movb	%dil, 0x9(%rax)
               	movl	$0xd, %edi
               	movb	%dil, 0xa(%rax)
               	movl	$0x10, %edi
               	movb	%dil, 0xb(%rax)
               	movl	$0x13, %edi
               	movb	%dil, 0xc(%rax)
               	movl	$0x16, %edi
               	movb	%dil, 0xd(%rax)
               	movl	$0x1b, %edi
               	movb	%dil, 0xe(%rax)
               	movl	$0x1e, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	0x180(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x90(%rsp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x170(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x180(%rsp), %rdi
               	leaq	-0x170(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	leaq	-0x1688(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	0x190(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1a8(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rcx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r9
               	movzbq	(%r9), %r9
               	subq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x190(%rsp), %rdi
               	leaq	-0x1a8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	leaq	-0x1698(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	0x1a0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1e0(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rcx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r9
               	movzbq	(%r9), %r9
               	imulq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x1a0(%rsp), %rdi
               	leaq	-0x1e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	leaq	-0x16a8(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	0x1b0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x218(%rbp), %rdi
               	movslq	%eax, %rsi
               	addq	%rsi, %rdi
               	leaq	(%rcx,%rsi), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rsi), %r9
               	movzbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x1b0(%rsp), %rdi
               	leaq	-0x218(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	leaq	-0x16b8(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	0x1c0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r9
               	leaq	(%rcx,%rsi), %rdi
               	movzbq	(%rdi), %r8
               	leaq	(%rdx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%r9)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x1c0(%rsp), %rdi
               	leaq	-0x250(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rdx
               	leaq	0x90(%rsp), %rsi
               	leaq	-0x16c8(%rbp), %rax
               	movq	(%rdx), %rcx
               	movq	(%rsi), %rdi
               	andq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	0x8(%rsi), %rdi
               	andq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x1d0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x288(%rbp), %rdi
               	movslq	%eax, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	andq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x1d0(%rsp), %rdi
               	leaq	-0x288(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rdx
               	leaq	0x90(%rsp), %rsi
               	leaq	-0x16d8(%rbp), %rax
               	movq	(%rdx), %rcx
               	movq	(%rsi), %rdi
               	orq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	0x8(%rsi), %rdi
               	orq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x1e0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x2c0(%rbp), %rdi
               	movslq	%eax, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x1e0(%rsp), %rdi
               	leaq	-0x2c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rdx
               	leaq	0x90(%rsp), %rsi
               	leaq	-0x16e8(%rbp), %rax
               	movq	(%rdx), %rcx
               	movq	(%rsi), %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	0x8(%rsi), %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x1f0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x2f8(%rbp), %rdi
               	movslq	%eax, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	xorq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x1f0(%rsp), %rdi
               	leaq	-0x2f8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	-0x16f8(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movsbq	0x1(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movsbq	0x2(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movsbq	0x3(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movsbq	0x5(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movsbq	0x6(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movsbq	0x7(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movsbq	0x9(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movsbq	0xa(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movsbq	0xb(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movsbq	0xc(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movsbq	0xd(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movsbq	0xe(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movsbq	0xf(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	0x200(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x330(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r9
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r8
               	movsbq	(%r8), %r8
               	addq	%r8, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x200(%rsp), %rdi
               	leaq	-0x330(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	-0x1708(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movsbq	0x1(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movsbq	0x2(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movsbq	0x3(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movsbq	0x5(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movsbq	0x6(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movsbq	0x7(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movsbq	0x9(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movsbq	0xa(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movsbq	0xb(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movsbq	0xc(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movsbq	0xd(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movsbq	0xe(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movsbq	0xf(%rdx), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	0x210(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x368(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r9
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r8
               	movsbq	(%r8), %r8
               	subq	%r8, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x210(%rsp), %rdi
               	leaq	-0x368(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	-0x1718(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movsbq	0x1(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movsbq	0x2(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movsbq	0x3(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movsbq	0x5(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movsbq	0x6(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movsbq	0x7(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movsbq	0x9(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movsbq	0xa(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movsbq	0xb(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movsbq	0xc(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movsbq	0xd(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movsbq	0xe(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movsbq	0xf(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	0x220(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x3a0(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r9
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r8
               	movsbq	(%r8), %r8
               	imulq	%r8, %rdi
               	movslq	%edi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	-0x3a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	-0x1728(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movsbq	0x1(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movsbq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movsbq	0x3(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movsbq	0x5(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movsbq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movsbq	0x7(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movsbq	0x9(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movsbq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movsbq	0xb(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movsbq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movsbq	0xd(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movsbq	0xe(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movsbq	0xf(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	0x230(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x3d8(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x230(%rsp), %rdi
               	leaq	-0x3d8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	leaq	-0x1738(%rbp), %rax
               	movsbq	(%rcx), %rdi
               	movsbq	(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	0x240(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x410(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r9
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %r8
               	leaq	(%rdx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%r9)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rdi
               	leaq	-0x410(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rsi
               	leaq	0xb0(%rsp), %rdi
               	leaq	-0x1748(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x250(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x448(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movsbq	(%r9), %r9
               	andq	%r9, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x250(%rsp), %rdi
               	leaq	-0x448(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xc0(%rsp), %rdx
               	leaq	0xd0(%rsp), %rsi
               	leaq	-0x1758(%rbp), %rax
               	movzwq	(%rdx), %rcx
               	movzwq	(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rdx), %rcx
               	movzwq	0x2(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rdx), %rcx
               	movzwq	0x4(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rdx), %rcx
               	movzwq	0x6(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rdx), %rcx
               	movzwq	0x8(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rdx), %rcx
               	movzwq	0xa(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rdx), %rcx
               	movzwq	0xc(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rdx), %rcx
               	movzwq	0xe(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x260(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x480(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	addq	%r9, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x260(%rsp), %rdi
               	leaq	-0x480(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xc0(%rsp), %rdx
               	leaq	0xd0(%rsp), %rsi
               	leaq	-0x1768(%rbp), %rax
               	movzwq	(%rdx), %rcx
               	movzwq	(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rdx), %rcx
               	movzwq	0x2(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rdx), %rcx
               	movzwq	0x4(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rdx), %rcx
               	movzwq	0x6(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rdx), %rcx
               	movzwq	0x8(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rdx), %rcx
               	movzwq	0xa(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rdx), %rcx
               	movzwq	0xc(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rdx), %rcx
               	movzwq	0xe(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x270(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4b8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x270(%rsp), %rdi
               	leaq	-0x4b8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xc0(%rsp), %rdx
               	leaq	0xd0(%rsp), %rsi
               	leaq	-0x1778(%rbp), %rax
               	movzwq	(%rdx), %rcx
               	movzwq	(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, (%rax)
               	movzwq	0x2(%rdx), %rcx
               	movzwq	0x2(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rdx), %rcx
               	movzwq	0x4(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rdx), %rcx
               	movzwq	0x6(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rdx), %rcx
               	movzwq	0x8(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rdx), %rcx
               	movzwq	0xa(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rdx), %rcx
               	movzwq	0xc(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rdx), %rcx
               	movzwq	0xe(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x280(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4f0(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	imulq	%r9, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x280(%rsp), %rdi
               	leaq	-0x4f0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xc0(%rsp), %rdx
               	leaq	0xd0(%rsp), %rsi
               	leaq	-0x1788(%rbp), %rax
               	movzwq	(%rdx), %rcx
               	movzwq	(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movzwq	0x2(%rdx), %rcx
               	movzwq	0x2(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rdx), %rcx
               	movzwq	0x4(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rdx), %rcx
               	movzwq	0x6(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rdx), %rcx
               	movzwq	0x8(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rdx), %rcx
               	movzwq	0xa(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rdx), %rcx
               	movzwq	0xc(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rdx), %rcx
               	movzwq	0xe(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	0x290(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x528(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x290(%rsp), %rdi
               	leaq	-0x528(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xc0(%rsp), %rdx
               	leaq	0xd0(%rsp), %rsi
               	leaq	-0x1798(%rbp), %rax
               	movzwq	(%rdx), %rdi
               	movzwq	(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	0x2a0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x560(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	leaq	(%r8,%rcx), %r9
               	leaq	(%rdx,%rcx), %r8
               	movzwq	(%r8), %r8
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%r9)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x2a0(%rsp), %rdi
               	leaq	-0x560(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0xf0(%rsp), %rsi
               	leaq	-0x17a8(%rbp), %rax
               	movswq	(%rdx), %rcx
               	movswq	(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rcx
               	movswq	0x2(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rcx
               	movswq	0x4(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rcx
               	movswq	0x6(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rcx
               	movswq	0x8(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rcx
               	movswq	0xa(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rcx
               	movswq	0xc(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rcx
               	movswq	0xe(%rsi), %rdi
               	addq	%rdi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x2b0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x598(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	leaq	(%r8,%rcx), %r9
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x2b0(%rsp), %rdi
               	leaq	-0x598(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x14, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0xf0(%rsp), %rsi
               	leaq	-0x17b8(%rbp), %rax
               	movswq	(%rdx), %rcx
               	movswq	(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rcx
               	movswq	0x2(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rcx
               	movswq	0x4(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rcx
               	movswq	0x6(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rcx
               	movswq	0x8(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rcx
               	movswq	0xa(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rcx
               	movswq	0xc(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rcx
               	movswq	0xe(%rsi), %rdi
               	subq	%rdi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x2c0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x5d0(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	leaq	(%r8,%rcx), %r9
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r8, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x2c0(%rsp), %rdi
               	leaq	-0x5d0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0xf0(%rsp), %rsi
               	leaq	-0x17c8(%rbp), %rax
               	movswq	(%rdx), %rcx
               	movswq	(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rcx
               	movswq	0x2(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rcx
               	movswq	0x4(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rcx
               	movswq	0x6(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rcx
               	movswq	0x8(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rcx
               	movswq	0xa(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rcx
               	movswq	0xc(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rcx
               	movswq	0xe(%rsi), %rdi
               	imulq	%rdi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x2d0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x608(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	leaq	(%r8,%rcx), %r9
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	imulq	%r8, %rcx
               	movslq	%ecx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x2d0(%rsp), %rdi
               	leaq	-0x608(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0xf0(%rsp), %rsi
               	leaq	-0x17d8(%rbp), %rax
               	movswq	(%rdx), %rcx
               	movswq	(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rcx
               	movswq	0x2(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rcx
               	movswq	0x4(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rcx
               	movswq	0x6(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rcx
               	movswq	0x8(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rcx
               	movswq	0xa(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rcx
               	movswq	0xc(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rcx
               	movswq	0xe(%rsi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	0x2e0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x640(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movswq	(%r9), %r9
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x2e0(%rsp), %rdi
               	leaq	-0x640(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0xf0(%rsp), %rsi
               	leaq	-0x17e8(%rbp), %rax
               	movswq	(%rdx), %rdi
               	movswq	(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	0x2f0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x678(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	leaq	(%r8,%rcx), %r9
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, (%r9)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x2f0(%rsp), %rdi
               	leaq	-0x678(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x100(%rsp), %rsi
               	leaq	0x110(%rsp), %rdi
               	leaq	-0x17f8(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x300(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x6b0(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	addq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x300(%rsp), %rdi
               	leaq	-0x6b0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x100(%rsp), %rsi
               	leaq	0x110(%rsp), %rdi
               	leaq	-0x1808(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x310(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x6e8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x310(%rsp), %rdi
               	leaq	-0x6e8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x100(%rsp), %rsi
               	leaq	0x110(%rsp), %rdi
               	leaq	-0x1818(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x320(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x720(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	imulq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x320(%rsp), %rdi
               	leaq	-0x720(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x100(%rsp), %rsi
               	leaq	0x110(%rsp), %rdi
               	leaq	-0x1828(%rbp), %rax
               	movl	(%rsi), %ecx
               	movl	(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	movl	0x4(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	movl	0x8(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	movl	0xc(%rdi), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x330(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x758(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x330(%rsp), %rdi
               	leaq	-0x758(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1c, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x100(%rsp), %rdi
               	leaq	0x110(%rsp), %r8
               	leaq	-0x1838(%rbp), %rax
               	movl	(%rdi), %edx
               	movl	(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movl	0x4(%rdi), %edx
               	movl	0x4(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rdi), %edx
               	movl	0x8(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rdi), %edx
               	movl	0xc(%r8), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x340(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x798(%rbp), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rsi,%rcx), %r9
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, %ecx
               	movl	%ecx, (%r9)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x340(%rsp), %rdi
               	leaq	-0x798(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x1848(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x350(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x7d8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	addq	%r9, %rcx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x350(%rsp), %rdi
               	leaq	-0x7d8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x1858(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x360(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x810(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x360(%rsp), %rdi
               	leaq	-0x810(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x1868(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x370(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x848(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	imulq	%r9, %rcx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x370(%rsp), %rdi
               	leaq	-0x848(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x20, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x1878(%rbp), %rax
               	movslq	(%rsi), %rcx
               	movslq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	movslq	0x4(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	movslq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	movslq	0xc(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x380(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x880(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x380(%rsp), %rdi
               	leaq	-0x880(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rdi
               	leaq	0x130(%rsp), %r8
               	leaq	-0x1888(%rbp), %rax
               	movslq	(%rdi), %rdx
               	movslq	(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rdi), %rdx
               	movslq	0x4(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rdi), %rdx
               	movslq	0x8(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rdi), %rdx
               	movslq	0xc(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x390(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8b8(%rbp), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rsi,%rcx), %r9
               	leaq	(%rdi,%rcx), %rsi
               	movslq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movslq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%r9)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x390(%rsp), %rdi
               	leaq	-0x8b8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x140(%rsp), %rsi
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x1898(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x3a0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8f0(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	addq	%r9, %rcx
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x3a0(%rsp), %rdi
               	leaq	-0x8f0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x140(%rsp), %rsi
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x18a8(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x3b0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x928(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x3b0(%rsp), %rdi
               	leaq	-0x928(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x140(%rsp), %rsi
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x18b8(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x3c0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x960(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	imulq	%r9, %rcx
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x3c0(%rsp), %rdi
               	leaq	-0x960(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x25, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x140(%rsp), %rsi
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x18c8(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	0x3d0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x998(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x3d0(%rsp), %rdi
               	leaq	-0x998(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x26, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x140(%rsp), %rdi
               	leaq	0x150(%rsp), %r8
               	leaq	-0x18d8(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	0x3e0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x9d0(%rbp), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %r9
               	leaq	(%rdi,%rcx), %rsi
               	movq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%r9)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x3e0(%rsp), %rdi
               	leaq	-0x9d0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x27, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rsi
               	leaq	0x170(%rsp), %rdi
               	leaq	-0x18e8(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x3f0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa08(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	addq	%r9, %rcx
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x3f0(%rsp), %rdi
               	leaq	-0xa08(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x28, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rsi
               	leaq	0x170(%rsp), %rdi
               	leaq	-0x18f8(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x400(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa40(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x400(%rsp), %rdi
               	leaq	-0xa40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rsi
               	leaq	0x170(%rsp), %rdi
               	leaq	-0x1908(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x410(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xa78(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	imulq	%r9, %rcx
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x410(%rsp), %rdi
               	leaq	-0xa78(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rsi
               	leaq	0x170(%rsp), %rdi
               	leaq	-0x1918(%rbp), %rax
               	movq	(%rsi), %rcx
               	movq	(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	0x420(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xab0(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x420(%rsp), %rdi
               	leaq	-0xab0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2b, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rdi
               	leaq	0x170(%rsp), %r8
               	leaq	-0x1928(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%r8), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	0x430(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xae8(%rbp), %rsi
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %r9
               	leaq	(%rdi,%rcx), %rsi
               	movq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%r9)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x430(%rsp), %rdi
               	leaq	-0xae8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2c, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	-0x108(%rbp), %rsi
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x1930(%rbp), %rax
               	movzbq	(%rsi), %rcx
               	movzbq	(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rsi), %rcx
               	movzbq	0x1(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rsi), %rcx
               	movzbq	0x2(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rsi), %rcx
               	movzbq	0x3(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rsi), %rcx
               	movzbq	0x4(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x5(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rsi), %rcx
               	movzbq	0x6(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rsi), %rcx
               	movzbq	0x7(%rdi), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0xb08(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb10(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xb08(%rbp), %rdi
               	leaq	-0xb10(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2d, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	-0x108(%rbp), %rsi
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x1938(%rbp), %rax
               	movzbq	(%rsi), %rcx
               	movzbq	(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rsi), %rcx
               	movzbq	0x1(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rsi), %rcx
               	movzbq	0x2(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rsi), %rcx
               	movzbq	0x3(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	0x4(%rsi), %rcx
               	movzbq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x5(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	0x6(%rsi), %rcx
               	movzbq	0x6(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	0x7(%rsi), %rcx
               	movzbq	0x7(%rdi), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0xb30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb38(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	imulq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xb30(%rbp), %rdi
               	leaq	-0xb38(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2e, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	-0x1958(%rbp), %rax
               	movl	(%rdx), %ecx
               	movl	(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rdx), %ecx
               	movl	0x4(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rdx), %ecx
               	movl	0x8(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rdx), %ecx
               	movl	0xc(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0xc(%rax)
               	movl	0x10(%rdx), %ecx
               	movl	0x10(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x10(%rax)
               	movl	0x14(%rdx), %ecx
               	movl	0x14(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x14(%rax)
               	movl	0x18(%rdx), %ecx
               	movl	0x18(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x18(%rax)
               	movl	0x1c(%rdx), %ecx
               	movl	0x1c(%rsi), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, 0x1c(%rax)
               	leaq	0x40(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb90(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rsi, %rcx
               	movl	(%rcx), %ecx
               	addq	%r9, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0xb90(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2f, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	-0x1978(%rbp), %rax
               	movl	(%rdx), %ecx
               	movl	(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rdx), %ecx
               	movl	0x4(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rdx), %ecx
               	movl	0x8(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rdx), %ecx
               	movl	0xc(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0xc(%rax)
               	movl	0x10(%rdx), %ecx
               	movl	0x10(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0x10(%rax)
               	movl	0x14(%rdx), %ecx
               	movl	0x14(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0x14(%rax)
               	movl	0x18(%rdx), %ecx
               	movl	0x18(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0x18(%rax)
               	movl	0x1c(%rdx), %ecx
               	movl	0x1c(%rsi), %edi
               	subq	%rdi, %rcx
               	movl	%ecx, 0x1c(%rax)
               	leaq	0x60(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xbe8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rsi, %rcx
               	movl	(%rcx), %ecx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0xbe8(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x30, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x440(%rsp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	0x450(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x1988(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	shlq	$0x0, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	shlq	%rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	shlq	$0x2, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	shlq	$0x3, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	shlq	$0x4, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	shlq	$0x5, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	shlq	$0x6, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	shlq	$0x7, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	shlq	$0x0, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	shlq	%rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	shlq	$0x2, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	shlq	$0x3, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	shlq	$0x4, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	shlq	$0x5, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	shlq	$0x6, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x7, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x460(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc40(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdi,%rdx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x460(%rsp), %rdi
               	leaq	-0xc40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x31, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x440(%rsp), %rdx
               	leaq	-0x1998(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xf(%rax)
               	leaq	0x470(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc78(%rbp), %rdi
               	movslq	%eax, %rsi
               	addq	%rsi, %rdi
               	leaq	(%rcx,%rsi), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rsi), %r9
               	movzbq	(%r9), %r9
               	pushq	%rcx
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x470(%rsp), %rdi
               	leaq	-0xc78(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x32, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0x450(%rsp), %rsi
               	leaq	-0x19a8(%rbp), %rax
               	movswq	(%rdx), %rcx
               	movswq	(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rcx
               	movswq	0x2(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rcx
               	movswq	0x4(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rcx
               	movswq	0x6(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rcx
               	movswq	0x8(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rcx
               	movswq	0xa(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rcx
               	movswq	0xc(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rcx
               	movswq	0xe(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x480(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xcb0(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movswq	(%r9), %r9
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, (%r8)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x480(%rsp), %rdi
               	leaq	-0xcb0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x33, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rdx
               	leaq	0x450(%rsp), %rsi
               	leaq	-0x19b8(%rbp), %rax
               	movswq	(%rdx), %rcx
               	movswq	(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, (%rax)
               	movswq	0x2(%rdx), %rcx
               	movswq	0x2(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	0x4(%rdx), %rcx
               	movswq	0x4(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x4(%rax)
               	movswq	0x6(%rdx), %rcx
               	movswq	0x6(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x6(%rax)
               	movswq	0x8(%rdx), %rcx
               	movswq	0x8(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0x8(%rax)
               	movswq	0xa(%rdx), %rcx
               	movswq	0xa(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xa(%rax)
               	movswq	0xc(%rdx), %rcx
               	movswq	0xc(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xc(%rax)
               	movswq	0xe(%rdx), %rcx
               	movswq	0xe(%rsi), %rdi
               	movq	%rcx, %r11
               	movq	%rdi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x490(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xce8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	leaq	(%r8,%rcx), %r9
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r8, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movslq	%ecx, %r8
               	movw	%r8w, (%r9)
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x490(%rsp), %rdi
               	leaq	-0xce8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x34, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	leaq	-0x19c8(%rbp), %rax
               	movslq	(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x4a0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd20(%rbp), %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x4a0(%rsp), %rdi
               	leaq	-0xd20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x35, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x100(%rsp), %rsi
               	leaq	-0x19d8(%rbp), %rax
               	movl	(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x8(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0xc(%rsi), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x4b0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd50(%rbp), %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x4b0(%rsp), %rdi
               	leaq	-0xd50(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x36, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	-0x19e8(%rbp), %rax
               	movsbq	(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, (%rax)
               	movsbq	0x1(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x4c0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd80(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	shlq	$0x2, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	-0xd80(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x37, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x19f8(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x4d0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xdb0(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	subq	$0x40, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x4d0(%rsp), %rdi
               	leaq	-0xdb0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x38, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x1a08(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x4e0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xde0(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	addq	$0x64, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x4e0(%rsp), %rdi
               	leaq	-0xde0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x39, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x1a18(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x4f0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xe10(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	$0x7, %rsi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x4f0(%rsp), %rdi
               	leaq	-0xe10(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3a, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x1a28(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	0x500(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	jmp	<addr>
               	leaq	-0xe40(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	%rdi, %rsi
               	sarq	$0x22, %rsi
               	movq	%rsi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x500(%rsp), %rdi
               	leaq	-0xe40(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x1a38(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	0x510(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	jmp	<addr>
               	leaq	-0xe70(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %rdi
               	imulq	%r8, %rdi
               	sarq	$0x22, %rdi
               	movq	%rdi, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %rdi
               	imulq	$0x7, %rdi, %rdi
               	subq	%rdi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x510(%rsp), %rdi
               	leaq	-0xe70(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3c, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0xf, %edx
               	leaq	-0x1a48(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x520(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xea0(%rbp), %rsi
               	movslq	%eax, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	andq	$0xf, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x520(%rsp), %rdi
               	leaq	-0xea0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3d, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0xf0, %edx
               	leaq	-0x1a58(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	orq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	orq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x530(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xed0(%rbp), %rsi
               	movslq	%eax, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	orq	$0xf0, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x530(%rsp), %rdi
               	leaq	-0xed0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3e, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0x55, %edx
               	leaq	-0x1a68(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	xorq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x540(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xf00(%rbp), %rsi
               	movslq	%eax, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x55, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x540(%rsp), %rdi
               	leaq	-0xf00(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3f, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	-0x1a78(%rbp), %rax
               	movsbq	(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, (%rax)
               	movsbq	0x1(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x550(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xf30(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	subq	$0x64, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x550(%rsp), %rdi
               	leaq	-0xf30(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x40, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	movl	$0x3, %edx
               	leaq	-0x1a88(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	0x560(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xf60(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x560(%rsp), %rdi
               	leaq	-0xf60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x41, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	movl	$0x3, %edx
               	leaq	-0x1a98(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	0x570(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xf90(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	sarq	$0x20, %rdi
               	movq	%rdi, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x570(%rsp), %rdi
               	leaq	-0xf90(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x42, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xc0(%rsp), %rdx
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	leaq	-0x1aa8(%rbp), %rax
               	movzwq	(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, (%rax)
               	movzwq	0x2(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rdx), %rsi
               	imulq	%rcx, %rsi
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rdx), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	0x580(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xfc0(%rbp), %rdi
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	addq	%rdx, %rcx
               	movzwq	(%rcx), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%rdi)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x580(%rsp), %rdi
               	leaq	-0xfc0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x43, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rsi
               	movl	$0x7, %ecx
               	leaq	-0x1ab8(%rbp), %rax
               	movq	(%rsi), %rdx
               	imulq	%rcx, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rsi), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x590(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xff0(%rbp), %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rdx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x590(%rsp), %rdi
               	leaq	-0xff0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x44, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x40, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x1ac8(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x5a0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1020(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x5a0(%rsp), %rdi
               	leaq	-0x1020(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x45, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x64, %edi
               	leaq	0xa0(%rsp), %rcx
               	leaq	-0x1ad8(%rbp), %rax
               	movsbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movsbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x5b0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1050(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %r8
               	movb	%r8b, (%r9)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x5b0(%rsp), %rdi
               	leaq	-0x1050(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x46, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0xfa, %esi
               	leaq	0x90(%rsp), %rcx
               	leaq	-0x1ae8(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	0x5c0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1080(%rbp), %rdi
               	movslq	%eax, %rdx
               	addq	%rdx, %rdi
               	leaq	(%rcx,%rdx), %r8
               	movzbq	(%r8), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x5c0(%rsp), %rdi
               	leaq	-0x1080(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x47, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0xfa, %ecx
               	leaq	0x90(%rsp), %rdx
               	leaq	-0x1af8(%rbp), %rax
               	movzbq	(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rdx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	0x5d0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10b0(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rdx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x5d0(%rsp), %rdi
               	leaq	-0x10b0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x61, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0xf, %edx
               	leaq	0x90(%rsp), %rcx
               	leaq	-0x1b08(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	andq	%rdx, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x5e0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10e0(%rbp), %rsi
               	movslq	%eax, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	andq	$0xf, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x5e0(%rsp), %rdi
               	leaq	-0x10e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x62, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	0x440(%rsp), %rcx
               	leaq	-0x1b18(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xf(%rax)
               	leaq	0x5f0(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1110(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	andq	$0xff, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x5f0(%rsp), %rdi
               	leaq	-0x1110(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x63, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x80, %esi
               	leaq	0x440(%rsp), %rcx
               	leaq	-0x1b28(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xf(%rax)
               	leaq	0x600(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1140(%rbp), %rdi
               	movslq	%eax, %rdx
               	addq	%rdx, %rdi
               	leaq	(%rcx,%rdx), %r8
               	movzbq	(%r8), %r8
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x600(%rsp), %rdi
               	leaq	-0x1140(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x64, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movabsq	$-0x7, %rdi
               	leaq	0x130(%rsp), %rsi
               	leaq	-0x1b38(%rbp), %rax
               	movslq	(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rsi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x610(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1170(%rbp), %r8
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x610(%rsp), %rdi
               	leaq	-0x1170(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x65, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movabsq	$-0x7, %rdx
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x1b48(%rbp), %rax
               	movslq	(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	movslq	0x4(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	movslq	0x8(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x8(%rax)
               	movslq	0xc(%rdi), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x620(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x11a0(%rbp), %r8
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x620(%rsp), %rdi
               	leaq	-0x11a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x66, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	movl	$0x3, %edx
               	leaq	-0x1b58(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xf(%rax)
               	leaq	0x630(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x11d0(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	$0x55555556, %rsi, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x630(%rsp), %rdi
               	leaq	-0x11d0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x48, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	movl	$0x7, %ecx
               	leaq	-0x1b68(%rbp), %rax
               	movslq	(%rsi), %rdx
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%rax)
               	movslq	0x4(%rsi), %rdx
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, 0x4(%rax)
               	movslq	0x8(%rsi), %rdx
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, 0x8(%rax)
               	movslq	0xc(%rsi), %rdx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	0x640(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	jmp	<addr>
               	leaq	-0x1200(%rbp), %r8
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x640(%rsp), %rdi
               	leaq	-0x1200(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x60, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x1b78(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	0x650(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	-0x1230(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rcx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	imulq	$-0x1, %rsi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x650(%rsp), %rdi
               	leaq	-0x1230(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x49, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xa0(%rsp), %rcx
               	leaq	-0x1b88(%rbp), %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rdx)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rdx)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rdx)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rdx)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rdx)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rdx)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rdx)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rdx)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rdx)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rdx)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rdx)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rdx)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rdx)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rdx)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rdx)
               	movsbq	0xf(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	0x660(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	-0x1260(%rbp), %rsi
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	$-0x1, %rsi, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x660(%rsp), %rdi
               	leaq	-0x1260(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4a, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rsi
               	leaq	-0x1b98(%rbp), %rcx
               	movslq	(%rsi), %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movslq	0x4(%rsi), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movslq	0x8(%rsi), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	0xc(%rsi), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	0x670(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x1290(%rbp), %rdi
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	imulq	$-0x1, %rcx, %rcx
               	movl	%ecx, (%rdi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x670(%rsp), %rdi
               	leaq	-0x1290(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4b, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x1ba8(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x680(%rsp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x12c0(%rbp), %rsi
               	movslq	%eax, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rdx), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$-0x1, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x680(%rsp), %rdi
               	leaq	-0x12c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4c, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rsi
               	leaq	-0x1bb8(%rbp), %rax
               	movq	(%rsi), %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	0x690(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x12f0(%rbp), %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x690(%rsp), %rdi
               	leaq	-0x12f0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4d, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1bc8(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movzbq	(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rax), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	0x6a0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x6b0(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1bd8(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rax), %r8
               	addq	%r8, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	addq	%rdx, %rax
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4e, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1be8(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movzbq	(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rax), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	0x6c0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x6d0(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1bf8(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rax), %r8
               	subq	%r8, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4f, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1c08(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movzbq	(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rax), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0xf(%rdx)
               	leaq	0x6e0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x6f0(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1c18(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rax), %r8
               	imulq	%r8, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	imulq	%rdx, %rax
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x50, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1c28(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movzbq	(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rdx)
               	leaq	0x700(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x710(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1c38(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rdx
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x51, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1c48(%rbp), %rdx
               	movzbq	(%rcx), %rdi
               	movzbq	(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rdx)
               	leaq	0x720(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x730(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1c58(%rbp), %rcx
               	movzbq	(%rdi), %rsi
               	movzbq	(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rsi
               	movzbq	0x1(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rsi
               	movzbq	0x2(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rsi
               	movzbq	0x3(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rsi
               	movzbq	0x4(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rsi
               	movzbq	0x5(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rsi
               	movzbq	0x6(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rsi
               	movzbq	0x7(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rsi
               	movzbq	0x8(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rsi
               	movzbq	0x9(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rsi
               	movzbq	0xa(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rsi
               	movzbq	0xb(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rsi
               	movzbq	0xc(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rsi
               	movzbq	0xd(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rsi
               	movzbq	0xe(%rax), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	leaq	0x720(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x52, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1c68(%rbp), %rdx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	movq	0x8(%rcx), %rsi
               	movq	0x8(%rax), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, 0x8(%rdx)
               	leaq	0x740(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x750(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1c78(%rbp), %rcx
               	movq	(%rdi), %rdx
               	movq	(%rax), %r8
               	andq	%r8, %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	andq	%rdx, %rax
               	movq	%rax, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x53, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1c88(%rbp), %rdx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	movq	0x8(%rcx), %rsi
               	movq	0x8(%rax), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, 0x8(%rdx)
               	leaq	0x760(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x770(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1c98(%rbp), %rcx
               	movq	(%rdi), %rdx
               	movq	(%rax), %r8
               	orq	%r8, %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	orq	%rdx, %rax
               	movq	%rax, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x54, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x90(%rsp), %rax
               	leaq	-0x1ca8(%rbp), %rdx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	movq	0x8(%rcx), %rsi
               	movq	0x8(%rax), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, 0x8(%rdx)
               	leaq	0x780(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x790(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1cb8(%rbp), %rcx
               	movq	(%rdi), %rdx
               	movq	(%rax), %r8
               	xorq	%r8, %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rax
               	movq	%rax, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x55, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x440(%rsp), %rax
               	leaq	-0x1cc8(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movzbq	(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xf(%rdx)
               	leaq	0x7a0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x7b0(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1cd8(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x56, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x440(%rsp), %rax
               	leaq	-0x1ce8(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movzbq	(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rdx)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rdx)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rdx)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rdx)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rdx)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rdx)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rdx)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rdx)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rdx)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rax), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xf(%rdx)
               	leaq	0x7c0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x7d0(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1cf8(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	movzbq	(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	movzbq	0x1(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	movzbq	0x2(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	movzbq	0x3(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	movzbq	0x4(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	movzbq	0x5(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	movzbq	0x6(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	movzbq	0x7(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	movzbq	0x8(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	movzbq	0x9(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	movzbq	0xa(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	movzbq	0xb(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	movzbq	0xc(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	movzbq	0xd(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	movzbq	0xe(%rax), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	movb	%al, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x57, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0xe0(%rsp), %rcx
               	leaq	0xf0(%rsp), %rax
               	leaq	-0x1d08(%rbp), %rdx
               	movswq	(%rcx), %rsi
               	movswq	(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rdx)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rdx)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rdx)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rdx)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rdx)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rdx)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rdx)
               	movswq	0xe(%rcx), %rsi
               	movswq	0xe(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xe(%rdx)
               	leaq	0x7e0(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x7f0(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1d18(%rbp), %rcx
               	movswq	(%rdi), %rdx
               	movswq	(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, (%rcx)
               	movswq	0x2(%rdi), %rdx
               	movswq	0x2(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x2(%rcx)
               	movswq	0x4(%rdi), %rdx
               	movswq	0x4(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x4(%rcx)
               	movswq	0x6(%rdi), %rdx
               	movswq	0x6(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x6(%rcx)
               	movswq	0x8(%rdi), %rdx
               	movswq	0x8(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0x8(%rcx)
               	movswq	0xa(%rdi), %rdx
               	movswq	0xa(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0xa(%rcx)
               	movswq	0xc(%rdi), %rdx
               	movswq	0xc(%rax), %r8
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, 0xc(%rcx)
               	movswq	0xe(%rdi), %rdx
               	movswq	0xe(%rax), %rax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%r10
               	popq	%rdx
               	movw	%ax, 0xe(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x58, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x160(%rsp), %rcx
               	leaq	0x170(%rsp), %rax
               	leaq	-0x1d28(%rbp), %rdx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	movq	0x8(%rcx), %rsi
               	movq	0x8(%rax), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, 0x8(%rdx)
               	leaq	0x800(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x810(%rsp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1d38(%rbp), %rcx
               	movq	(%rdi), %rdx
               	movq	(%rax), %r8
               	imulq	%r8, %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rax), %rax
               	imulq	%rdx, %rax
               	movq	%rax, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x59, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	0x820(%rsp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rcx
               	leaq	-0x1d48(%rbp), %rcx
               	movzbq	(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rdi), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x1d58(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rax
               	subq	$0x40, %rax
               	movb	%al, 0xf(%rcx)
               	leaq	0x830(%rsp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rax
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5a, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x840(%rsp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x1d68(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x1d78(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x1d88(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x8(%rcx)
               	movzbq	0x9(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0xf(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x80(%rsp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x14c0(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	subq	$0xc0, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x840(%rsp), %rdi
               	leaq	-0x14c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5b, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movzbq	(%rax), %rsi
               	movzbq	(%rcx), %rdi
               	addq	%rdi, %rsi
               	movzbq	0x1(%rax), %rdi
               	movzbq	0x1(%rcx), %r8
               	addq	%r8, %rdi
               	movzbq	0x2(%rax), %r8
               	movzbq	0x2(%rcx), %r9
               	addq	%r9, %r8
               	movzbq	0x3(%rax), %r9
               	movzbq	0x3(%rcx), %rbx
               	addq	%rbx, %r9
               	movzbq	0x4(%rax), %rbx
               	movzbq	0x4(%rcx), %r12
               	addq	%r12, %rbx
               	movzbq	0x5(%rax), %r12
               	movzbq	0x5(%rcx), %r13
               	addq	%r13, %r12
               	movzbq	0x6(%rax), %r13
               	movzbq	0x6(%rcx), %r14
               	addq	%r14, %r13
               	movzbq	0x7(%rax), %r14
               	movzbq	0x7(%rcx), %r15
               	addq	%r15, %r14
               	movzbq	0x8(%rax), %r15
               	movzbq	0x8(%rcx), %r10
               	movq	%r10, -0x1e68(%rbp)
               	addq	-0x1e68(%rbp), %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, -0x1e68(%rbp)
               	movzbq	0x9(%rcx), %r10
               	movq	%r10, -0x1e70(%rbp)
               	movq	-0x1e68(%rbp), %r10
               	addq	-0x1e70(%rbp), %r10
               	movq	%r10, -0x1e68(%rbp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, -0x1e70(%rbp)
               	movzbq	0xa(%rcx), %r10
               	movq	%r10, -0x1e78(%rbp)
               	movq	-0x1e70(%rbp), %r10
               	addq	-0x1e78(%rbp), %r10
               	movq	%r10, -0x1e70(%rbp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, -0x1e78(%rbp)
               	movzbq	0xb(%rcx), %r10
               	movq	%r10, -0x1e80(%rbp)
               	movq	-0x1e78(%rbp), %r10
               	addq	-0x1e80(%rbp), %r10
               	movq	%r10, -0x1e78(%rbp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, -0x1e80(%rbp)
               	movzbq	0xc(%rcx), %r10
               	movq	%r10, -0x1e88(%rbp)
               	movq	-0x1e80(%rbp), %r10
               	addq	-0x1e88(%rbp), %r10
               	movq	%r10, -0x1e80(%rbp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, -0x1e88(%rbp)
               	movzbq	0xd(%rcx), %r10
               	movq	%r10, -0x1e90(%rbp)
               	movq	-0x1e88(%rbp), %r10
               	addq	-0x1e90(%rbp), %r10
               	movq	%r10, -0x1e88(%rbp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, -0x1e90(%rbp)
               	movzbq	0xe(%rcx), %r10
               	movq	%r10, -0x1e98(%rbp)
               	movq	-0x1e90(%rbp), %r10
               	addq	-0x1e98(%rbp), %r10
               	movq	%r10, -0x1e90(%rbp)
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rcx), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, -0x1e98(%rbp)
               	movl	$0x3, %eax
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	imulq	%rax, %rdx
               	movq	%rdi, %rsi
               	andq	$0xff, %rsi
               	imulq	%rax, %rsi
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	imulq	%rax, %rdi
               	movq	%r9, %r8
               	andq	$0xff, %r8
               	imulq	%rax, %r8
               	movq	%rbx, %r9
               	andq	$0xff, %r9
               	imulq	%rax, %r9
               	movq	%r12, %rbx
               	andq	$0xff, %rbx
               	imulq	%rax, %rbx
               	movq	%r13, %r12
               	andq	$0xff, %r12
               	imulq	%rax, %r12
               	movq	%r14, %r13
               	andq	$0xff, %r13
               	imulq	%rax, %r13
               	movq	%r15, %r14
               	andq	$0xff, %r14
               	imulq	%rax, %r14
               	movq	-0x1e68(%rbp), %r15
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	movq	-0x1e70(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x1e68(%rbp)
               	movq	-0x1e68(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x1e68(%rbp)
               	movq	-0x1e78(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x1e70(%rbp)
               	movq	-0x1e70(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x1e70(%rbp)
               	movq	-0x1e80(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x1e78(%rbp)
               	movq	-0x1e78(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x1e78(%rbp)
               	movq	-0x1e88(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x1e80(%rbp)
               	movq	-0x1e80(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x1e80(%rbp)
               	movq	-0x1e90(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x1e88(%rbp)
               	movq	-0x1e88(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x1e88(%rbp)
               	movq	-0x1e98(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x1e90(%rbp)
               	movq	-0x1e90(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x1e90(%rbp)
               	leaq	0x80(%rsp), %rcx
               	leaq	-0x1db8(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rcx), %r10
               	movq	%r10, -0x1e98(%rbp)
               	subq	-0x1e98(%rbp), %rdx
               	movb	%dl, (%rax)
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x1(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x1(%rax)
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x2(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x2(%rax)
               	movq	%r8, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x3(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x3(%rax)
               	movq	%r9, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x4(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4(%rax)
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x5(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5(%rax)
               	movq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x6(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x6(%rax)
               	movq	%r13, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x7(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x7(%rax)
               	movq	%r14, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x8(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x8(%rax)
               	movq	%r15, %rdx
               	andq	$0xff, %rdx
               	movzbq	0x9(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x9(%rax)
               	movq	-0x1e68(%rbp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xa(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xa(%rax)
               	movq	-0x1e70(%rbp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xb(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xb(%rax)
               	movq	-0x1e78(%rbp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xc(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xc(%rax)
               	movq	-0x1e80(%rbp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xd(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xd(%rax)
               	movq	-0x1e88(%rbp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xe(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xe(%rax)
               	movq	-0x1e90(%rbp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	0x850(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x80(%rsp), %r8
               	leaq	0x90(%rsp), %r9
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x14f0(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rbx
               	leaq	(%r8,%rcx), %rsi
               	movzbq	(%rsi), %rdi
               	leaq	(%r9,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdi, %rdx
               	andq	$0xff, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	andq	$0xff, %rdx
               	subq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rbx)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x850(%rsp), %rdi
               	leaq	-0x14f0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5c, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x120(%rsp), %rax
               	movl	$0x3, %ecx
               	movslq	(%rax), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movslq	0x4(%rax), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movslq	0x8(%rax), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movslq	0xc(%rax), %rax
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movq	%r9, %r10
               	movq	%rax, %r9
               	subq	%r10, %r9
               	leaq	0x130(%rsp), %rdx
               	leaq	-0x1de8(%rbp), %rcx
               	movslq	(%rdx), %rbx
               	addq	%rbx, %rsi
               	movl	%esi, (%rcx)
               	movslq	0x4(%rdx), %rsi
               	addq	%rdi, %rsi
               	movl	%esi, 0x4(%rcx)
               	movslq	0x8(%rdx), %rsi
               	addq	%r8, %rsi
               	movl	%esi, 0x8(%rcx)
               	movslq	0xc(%rdx), %rdx
               	addq	%r9, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	0x860(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x120(%rsp), %rdi
               	leaq	0x130(%rsp), %r8
               	jmp	<addr>
               	leaq	-0x1528(%rbp), %rdx
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %r9
               	leaq	(%rdi,%rcx), %rdx
               	movslq	(%rdx), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rbx
               	shrq	$0x3f, %rbx
               	addq	%rbx, %rdx
               	imulq	$-0x1, %rdx, %rdx
               	addq	%r8, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, (%r9)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x860(%rsp), %rdi
               	leaq	-0x1528(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5d, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0x870(%rsp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x1df8(%rbp), %rcx
               	movzbq	(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x7(%rcx)
               	movzbq	0x8(%rax), %rdx
               	shlq	%rdx
               	leaq	0x8(%rcx), %rsi
               	movb	%dl, (%rsi)
               	movzbq	0x9(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0x9(%rcx)
               	movzbq	0xa(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xa(%rcx)
               	movzbq	0xb(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xb(%rcx)
               	movzbq	0xc(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xc(%rcx)
               	movzbq	0xd(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xd(%rcx)
               	movzbq	0xe(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xe(%rcx)
               	movzbq	0xf(%rax), %rdx
               	shlq	%rdx
               	movb	%dl, 0xf(%rcx)
               	movsbq	(%rax), %rdi
               	sarq	$0x7, %rdi
               	movsbq	0x1(%rax), %r8
               	sarq	$0x7, %r8
               	movsbq	0x2(%rax), %r9
               	sarq	$0x7, %r9
               	movsbq	0x3(%rax), %rbx
               	sarq	$0x7, %rbx
               	movsbq	0x4(%rax), %r12
               	sarq	$0x7, %r12
               	movsbq	0x5(%rax), %r13
               	sarq	$0x7, %r13
               	movsbq	0x6(%rax), %r14
               	sarq	$0x7, %r14
               	movsbq	0x7(%rax), %r15
               	sarq	$0x7, %r15
               	movsbq	0x8(%rax), %r10
               	movq	%r10, -0x1e68(%rbp)
               	movq	-0x1e68(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e68(%rbp)
               	movsbq	0x9(%rax), %r10
               	movq	%r10, -0x1e70(%rbp)
               	movq	-0x1e70(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e70(%rbp)
               	movsbq	0xa(%rax), %r10
               	movq	%r10, -0x1e78(%rbp)
               	movq	-0x1e78(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e78(%rbp)
               	movsbq	0xb(%rax), %r10
               	movq	%r10, -0x1e80(%rbp)
               	movq	-0x1e80(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e80(%rbp)
               	movsbq	0xc(%rax), %r10
               	movq	%r10, -0x1e88(%rbp)
               	movq	-0x1e88(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e88(%rbp)
               	movsbq	0xd(%rax), %r10
               	movq	%r10, -0x1e90(%rbp)
               	movq	-0x1e90(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e90(%rbp)
               	movsbq	0xe(%rax), %r10
               	movq	%r10, -0x1e98(%rbp)
               	movq	-0x1e98(%rbp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1e98(%rbp)
               	movsbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x1ea0(%rbp)
               	movl	$0x1b, %edx
               	leaq	-0x1e18(%rbp), %rax
               	movsbq	%dil, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, (%rax)
               	movsbq	%r8b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x1(%rax)
               	movsbq	%r9b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x2(%rax)
               	movsbq	%bl, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x3(%rax)
               	movsbq	%r12b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x4(%rax)
               	movsbq	%r13b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x5(%rax)
               	movsbq	%r14b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x6(%rax)
               	movsbq	%r15b, %rdi
               	andq	%rdx, %rdi
               	movb	%dil, 0x7(%rax)
               	movq	-0x1e68(%rbp), %rdi
               	movsbq	%dil, %rdi
               	movq	%rdi, %r8
               	andq	%rdx, %r8
               	leaq	0x8(%rax), %rdi
               	movb	%r8b, (%rdi)
               	movq	-0x1e70(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0x9(%rax)
               	movq	-0x1e78(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xa(%rax)
               	movq	-0x1e80(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xb(%rax)
               	movq	-0x1e88(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xc(%rax)
               	movq	-0x1e90(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xd(%rax)
               	movq	-0x1e98(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xe(%rax)
               	movq	-0x1ea0(%rbp), %r8
               	movsbq	%r8b, %r8
               	andq	%r8, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x1e28(%rbp), %rdx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdx)
               	leaq	0x880(%rsp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	0x80(%rsp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdx
               	movsbq	%dl, %r8
               	sarq	$0x7, %r8
               	andq	$0x1b, %r8
               	leaq	-0x1570(%rbp), %r9
               	addq	%rcx, %r9
               	shlq	%rdx
               	andq	$0xff, %rdx
               	movq	%r8, %rdi
               	andq	$0xff, %rdi
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r9)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x880(%rsp), %rdi
               	leaq	-0x1570(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5e, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x80(%rsp), %rcx
               	leaq	0xa0(%rsp), %rdx
               	leaq	-0x1e38(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rsi
               	movzbq	0xf(%rdx), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0xf(%rax)
               	leaq	0x890(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x15a8(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rcx,%rsi), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x890(%rsp), %rdi
               	leaq	-0x15a8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5f, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x8a0(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	0x8b0(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1e48(%rbp), %rax
               	movl	$0x42, %edi
               	movb	%dil, (%rax)
               	xorq	%rdi, %rdi
               	movb	%dil, 0x1(%rax)
               	movl	$0x28, %r8d
               	movb	%r8b, 0x2(%rax)
               	movb	%dil, 0x3(%rax)
               	movl	$0x1d, %r8d
               	movb	%r8b, 0x4(%rax)
               	movb	%dil, 0x5(%rax)
               	movl	$0x16, %r8d
               	movb	%r8b, 0x6(%rax)
               	movb	%dil, 0x7(%rax)
               	movl	$0x1, %edi
               	movb	%dil, 0x8(%rax)
               	movl	$0x2, %edi
               	movb	%dil, 0x9(%rax)
               	movl	$0x3, %edi
               	movb	%dil, 0xa(%rax)
               	movl	$0x4, %edi
               	movb	%dil, 0xb(%rax)
               	movl	$0x5, %edi
               	movb	%dil, 0xc(%rax)
               	movl	$0x6, %edi
               	movb	%dil, 0xd(%rax)
               	movl	$0x7, %edi
               	movb	%dil, 0xe(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	0x8c0(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x8b0(%rsp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1600(%rbp), %rdi
               	movslq	%eax, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x8c0(%rsp), %rdi
               	leaq	-0x1600(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x67, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	0x8a0(%rsp), %rcx
               	leaq	0x8b0(%rsp), %rdx
               	leaq	-0x1e58(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movsbq	0x1(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movsbq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movsbq	0x3(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movsbq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movsbq	0x5(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movsbq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movsbq	0x7(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movsbq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movsbq	0x9(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movsbq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movsbq	0xb(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movsbq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movsbq	0xd(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movsbq	0xe(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rsi
               	movsbq	0xf(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xf(%rax)
               	leaq	0x8d0(%rsp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1638(%rbp), %rdi
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%rcx,%rsi), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rsi), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%r8)
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x8d0(%rsp), %rdi
               	leaq	-0x1638(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x68, %eax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	-0x1ed0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
