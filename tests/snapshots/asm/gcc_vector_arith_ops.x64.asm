
gcc_vector_arith_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<same>:
               	movslq	%edx, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%rdx, %rcx
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
               	subq	$0x750, %rsp            # imm = 0x750
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-0x1550(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1560(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1570(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1580(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1590(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x15a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x15b0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x15c0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x15d0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x15e0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x15f0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1600(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1610(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1620(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1630(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1640(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1648(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x1650(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x1670(%rbp), %rax
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
               	leaq	-0x1690(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %esi
               	movb	%sil, (%rax)
               	movl	$0x3, %esi
               	movb	%sil, 0x1(%rax)
               	movl	$0x5, %esi
               	movb	%sil, 0x2(%rax)
               	movl	$0x7, %esi
               	movb	%sil, 0x3(%rax)
               	movl	$0x12c, %esi            # imm = 0x12C
               	movb	%sil, 0x4(%rax)
               	movl	$0x100, %esi            # imm = 0x100
               	movb	%sil, 0x5(%rax)
               	movl	$0x100, %esi            # imm = 0x100
               	movb	%sil, 0x6(%rax)
               	movl	$0x12c, %esi            # imm = 0x12C
               	movb	%sil, 0x7(%rax)
               	movl	$0x100, %esi            # imm = 0x100
               	movb	%sil, 0x8(%rax)
               	movl	$0x8, %esi
               	movb	%sil, 0x9(%rax)
               	movl	$0xd, %esi
               	movb	%sil, 0xa(%rax)
               	movl	$0x10, %esi
               	movb	%sil, 0xb(%rax)
               	movl	$0x13, %esi
               	movb	%sil, 0xc(%rax)
               	movl	$0x16, %esi
               	movb	%sil, 0xd(%rax)
               	movl	$0x1b, %esi
               	movb	%sil, 0xe(%rax)
               	movl	$0x1e, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x16a0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	leaq	-0x1560(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x16b0(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x16a0(%rbp), %rdi
               	leaq	-0x16b0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x1530(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	leaq	-0x1560(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1540(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	subq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1530(%rbp), %rdi
               	leaq	-0x1540(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x38(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x1510(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	leaq	-0x1560(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1520(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	imulq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1510(%rbp), %rdi
               	leaq	-0x1520(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x48(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x14f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0x1560(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1500(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
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
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x14f0(%rbp), %rdi
               	leaq	-0x1500(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x58(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x14d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0x1560(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x14e0(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x14d0(%rbp), %rdi
               	leaq	-0x14e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x68(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x14b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0x1560(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x14c0(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	andq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x14b0(%rbp), %rdi
               	leaq	-0x14c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x78(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1490(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0x1560(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x14a0(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1490(%rbp), %rdi
               	leaq	-0x14a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x88(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1470(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0x1560(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1480(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	xorq	%r9, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1470(%rbp), %rdi
               	leaq	-0x1480(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x1580(%rbp), %rdx
               	leaq	-0x98(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movsbq	0xf(%rdx), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x1450(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rdi
               	leaq	-0x1580(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1460(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r9
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1450(%rbp), %rdi
               	leaq	-0x1460(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x1580(%rbp), %rdx
               	leaq	-0xa8(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movsbq	0xf(%rdx), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x1430(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rdi
               	leaq	-0x1580(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1440(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r9
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	subq	%rsi, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1430(%rbp), %rdi
               	leaq	-0x1440(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x1580(%rbp), %rdx
               	leaq	-0xb8(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movsbq	0xf(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x1410(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rdi
               	leaq	-0x1580(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1420(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r9
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	imulq	%rsi, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x1410(%rbp), %rdi
               	leaq	-0x1420(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x1580(%rbp), %rdx
               	leaq	-0xc8(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movsbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x13f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rsi
               	leaq	-0x1580(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1400(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x13f0(%rbp), %rdi
               	leaq	-0x1400(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x1580(%rbp), %rdx
               	leaq	-0xd8(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rcx
               	movsbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x13d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rsi
               	leaq	-0x1580(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x13e0(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r9
               	popq	%rax
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x13d0(%rbp), %rdi
               	leaq	-0x13e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x1580(%rbp), %rdx
               	leaq	-0xe8(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x13b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rsi
               	leaq	-0x1580(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x13c0(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movsbq	(%r9), %r9
               	andq	%r9, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x13b0(%rbp), %rdi
               	leaq	-0x13c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1590(%rbp), %rcx
               	leaq	-0x15a0(%rbp), %rdx
               	leaq	-0xf8(%rbp), %rax
               	movzwq	(%rcx), %rsi
               	movzwq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, (%rax)
               	movzwq	0x2(%rcx), %rsi
               	movzwq	0x2(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rcx), %rsi
               	movzwq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rcx), %rsi
               	movzwq	0x6(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rcx), %rsi
               	movzwq	0x8(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rcx), %rsi
               	movzwq	0xa(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rcx), %rsi
               	movzwq	0xc(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rcx), %rcx
               	movzwq	0xe(%rdx), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1390(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1590(%rbp), %rsi
               	leaq	-0x15a0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x13a0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	addq	%r9, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1390(%rbp), %rdi
               	leaq	-0x13a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1590(%rbp), %rcx
               	leaq	-0x15a0(%rbp), %rdx
               	leaq	-0x108(%rbp), %rax
               	movzwq	(%rcx), %rsi
               	movzwq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, (%rax)
               	movzwq	0x2(%rcx), %rsi
               	movzwq	0x2(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rcx), %rsi
               	movzwq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rcx), %rsi
               	movzwq	0x6(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rcx), %rsi
               	movzwq	0x8(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rcx), %rsi
               	movzwq	0xa(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rcx), %rsi
               	movzwq	0xc(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rcx), %rcx
               	movzwq	0xe(%rdx), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1370(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1590(%rbp), %rsi
               	leaq	-0x15a0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1380(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1370(%rbp), %rdi
               	leaq	-0x1380(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1590(%rbp), %rcx
               	leaq	-0x15a0(%rbp), %rdx
               	leaq	-0x118(%rbp), %rax
               	movzwq	(%rcx), %rsi
               	movzwq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, (%rax)
               	movzwq	0x2(%rcx), %rsi
               	movzwq	0x2(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rcx), %rsi
               	movzwq	0x4(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rcx), %rsi
               	movzwq	0x6(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rcx), %rsi
               	movzwq	0x8(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rcx), %rsi
               	movzwq	0xa(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rcx), %rsi
               	movzwq	0xc(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rcx), %rcx
               	movzwq	0xe(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1350(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1590(%rbp), %rsi
               	leaq	-0x15a0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1360(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1350(%rbp), %rdi
               	leaq	-0x1360(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1590(%rbp), %rcx
               	leaq	-0x15a0(%rbp), %rdx
               	leaq	-0x128(%rbp), %rax
               	movzwq	(%rcx), %rsi
               	movzwq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rax)
               	movzwq	0x2(%rcx), %rsi
               	movzwq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rcx), %rsi
               	movzwq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rcx), %rsi
               	movzwq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rcx), %rsi
               	movzwq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rcx), %rsi
               	movzwq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rcx), %rsi
               	movzwq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rcx), %rcx
               	movzwq	0xe(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1330(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1590(%rbp), %rsi
               	leaq	-0x15a0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1340(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1330(%rbp), %rdi
               	leaq	-0x1340(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1590(%rbp), %rcx
               	leaq	-0x15a0(%rbp), %rdx
               	leaq	-0x138(%rbp), %rax
               	movzwq	(%rcx), %rsi
               	movzwq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rax)
               	movzwq	0x2(%rcx), %rsi
               	movzwq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rcx), %rsi
               	movzwq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rcx), %rsi
               	movzwq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rcx), %rsi
               	movzwq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rcx), %rsi
               	movzwq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rcx), %rsi
               	movzwq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rcx), %rcx
               	movzwq	0xe(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1310(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1590(%rbp), %rsi
               	leaq	-0x15a0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1320(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movzwq	(%r9), %r9
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1310(%rbp), %rdi
               	leaq	-0x1320(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x148(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	addq	%rdi, %rsi
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x12f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rdi
               	leaq	-0x15c0(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1300(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movswq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x12f0(%rbp), %rdi
               	leaq	-0x1300(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x158(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	subq	%rdi, %rsi
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	subq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x12d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rdi
               	leaq	-0x15c0(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x12e0(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x12d0(%rbp), %rdi
               	leaq	-0x12e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x168(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0x12b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rdi
               	leaq	-0x15c0(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x12c0(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movswq	(%rdx), %rdx
               	imulq	%rsi, %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x12b0(%rbp), %rdi
               	leaq	-0x12c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x178(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1290(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rsi
               	leaq	-0x15c0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x12a0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movswq	(%r9), %r9
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1290(%rbp), %rdi
               	leaq	-0x12a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x188(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0x1270(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rsi
               	leaq	-0x15c0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1280(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movswq	(%r9), %r9
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x1270(%rbp), %rdi
               	leaq	-0x1280(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15d0(%rbp), %rcx
               	leaq	-0x15e0(%rbp), %rdx
               	leaq	-0x198(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %ecx
               	movl	0xc(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1250(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15d0(%rbp), %rsi
               	leaq	-0x15e0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1260(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	addq	%r9, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1250(%rbp), %rdi
               	leaq	-0x1260(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15d0(%rbp), %rcx
               	leaq	-0x15e0(%rbp), %rdx
               	leaq	-0x1a8(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %ecx
               	movl	0xc(%rdx), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1230(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15d0(%rbp), %rsi
               	leaq	-0x15e0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1240(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1230(%rbp), %rdi
               	leaq	-0x1240(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15d0(%rbp), %rcx
               	leaq	-0x15e0(%rbp), %rdx
               	leaq	-0x1b8(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	imulq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	imulq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	imulq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %ecx
               	movl	0xc(%rdx), %edx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1210(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15d0(%rbp), %rsi
               	leaq	-0x15e0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1220(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	imulq	%r9, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1210(%rbp), %rdi
               	leaq	-0x1220(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15d0(%rbp), %rcx
               	leaq	-0x15e0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %ecx
               	movl	0xc(%rdx), %edx
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
               	leaq	-0x11f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15d0(%rbp), %rsi
               	leaq	-0x15e0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1200(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x11f0(%rbp), %rdi
               	leaq	-0x1200(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15d0(%rbp), %rcx
               	leaq	-0x15e0(%rbp), %rdx
               	leaq	-0x1d8(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %ecx
               	movl	0xc(%rdx), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x11d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15d0(%rbp), %rsi
               	leaq	-0x15e0(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x11e0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x11d0(%rbp), %rdi
               	leaq	-0x11e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	leaq	-0x1600(%rbp), %rdx
               	leaq	-0x1e8(%rbp), %rax
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	addq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	movslq	0xc(%rdx), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x11b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	leaq	-0x1600(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x11c0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	addq	%r9, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x11b0(%rbp), %rdi
               	leaq	-0x11c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	leaq	-0x1600(%rbp), %rdx
               	leaq	-0x1f8(%rbp), %rax
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	subq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	subq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	movslq	0xc(%rdx), %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1190(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	leaq	-0x1600(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x11a0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1190(%rbp), %rdi
               	leaq	-0x11a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	leaq	-0x1600(%rbp), %rdx
               	leaq	-0x208(%rbp), %rax
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	movslq	0xc(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1170(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	leaq	-0x1600(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1180(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1170(%rbp), %rdi
               	leaq	-0x1180(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x20, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	leaq	-0x1600(%rbp), %rdx
               	leaq	-0x218(%rbp), %rax
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	movslq	0xc(%rdx), %rdx
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
               	leaq	-0x1150(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	leaq	-0x1600(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1160(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1150(%rbp), %rdi
               	leaq	-0x1160(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	leaq	-0x1600(%rbp), %rdx
               	leaq	-0x228(%rbp), %rax
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	movslq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	movslq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	movslq	0xc(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x1130(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	leaq	-0x1600(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1140(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x1130(%rbp), %rdi
               	leaq	-0x1140(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1610(%rbp), %rcx
               	leaq	-0x1620(%rbp), %rdx
               	leaq	-0x238(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1110(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1610(%rbp), %rsi
               	leaq	-0x1620(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1120(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	addq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x1110(%rbp), %rdi
               	leaq	-0x1120(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1610(%rbp), %rcx
               	leaq	-0x1620(%rbp), %rdx
               	leaq	-0x248(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1610(%rbp), %rsi
               	leaq	-0x1620(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1100(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x10f0(%rbp), %rdi
               	leaq	-0x1100(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1610(%rbp), %rcx
               	leaq	-0x1620(%rbp), %rdx
               	leaq	-0x258(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1610(%rbp), %rsi
               	leaq	-0x1620(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10e0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x10d0(%rbp), %rdi
               	leaq	-0x10e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x25, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1610(%rbp), %rcx
               	leaq	-0x1620(%rbp), %rdx
               	leaq	-0x268(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
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
               	leaq	-0x10b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1610(%rbp), %rsi
               	leaq	-0x1620(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10c0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x10b0(%rbp), %rdi
               	leaq	-0x10c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x26, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1610(%rbp), %rcx
               	leaq	-0x1620(%rbp), %rdx
               	leaq	-0x278(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1090(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1610(%rbp), %rsi
               	leaq	-0x1620(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10a0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rax
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x1090(%rbp), %rdi
               	leaq	-0x10a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x27, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x288(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1070(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	leaq	-0x1640(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1080(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	addq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x1070(%rbp), %rdi
               	leaq	-0x1080(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x28, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x298(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	subq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1050(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	leaq	-0x1640(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1060(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x1050(%rbp), %rdi
               	leaq	-0x1060(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x2a8(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x1030(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	leaq	-0x1640(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1040(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x1030(%rbp), %rdi
               	leaq	-0x1040(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x2b8(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
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
               	leaq	-0x1010(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	leaq	-0x1640(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1020(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x1010(%rbp), %rdi
               	leaq	-0x1020(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x2c8(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xff0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	leaq	-0x1640(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1000(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movq	%rdx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0xff0(%rbp), %rdi
               	leaq	-0x1000(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1648(%rbp), %rcx
               	leaq	-0x1650(%rbp), %rdx
               	leaq	-0x2d0(%rbp), %rax
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
               	movzbq	0x7(%rcx), %rcx
               	movzbq	0x7(%rdx), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x16d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1648(%rbp), %rsi
               	leaq	-0x1650(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x16c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x16d0(%rbp), %rdi
               	leaq	-0x16c8(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1648(%rbp), %rcx
               	leaq	-0x1650(%rbp), %rdx
               	leaq	-0x2d8(%rbp), %rax
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
               	movzbq	0x7(%rcx), %rcx
               	movzbq	0x7(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x16c0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1648(%rbp), %rsi
               	leaq	-0x1650(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x16b8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	imulq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x16c0(%rbp), %rdi
               	leaq	-0x16b8(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1670(%rbp), %rcx
               	leaq	-0x1690(%rbp), %rdx
               	leaq	-0x2f8(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %esi
               	movl	0xc(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0xc(%rax)
               	movl	0x10(%rcx), %esi
               	movl	0x10(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x10(%rax)
               	movl	0x14(%rcx), %esi
               	movl	0x14(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x14(%rax)
               	movl	0x18(%rcx), %esi
               	movl	0x18(%rdx), %edi
               	addq	%rdi, %rsi
               	movl	%esi, 0x18(%rax)
               	movl	0x1c(%rcx), %ecx
               	movl	0x1c(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0xfc0(%rbp), %rcx
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
               	leaq	-0x1670(%rbp), %rsi
               	leaq	-0x1690(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xfe0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	addq	%r9, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xfc0(%rbp), %rdi
               	leaq	-0xfe0(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1670(%rbp), %rcx
               	leaq	-0x1690(%rbp), %rdx
               	leaq	-0x318(%rbp), %rax
               	movl	(%rcx), %esi
               	movl	(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rcx), %esi
               	movl	0x4(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	movl	0x8(%rcx), %esi
               	movl	0x8(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x8(%rax)
               	movl	0xc(%rcx), %esi
               	movl	0xc(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0xc(%rax)
               	movl	0x10(%rcx), %esi
               	movl	0x10(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x10(%rax)
               	movl	0x14(%rcx), %esi
               	movl	0x14(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x14(%rax)
               	movl	0x18(%rcx), %esi
               	movl	0x18(%rdx), %edi
               	subq	%rdi, %rsi
               	movl	%esi, 0x18(%rax)
               	movl	0x1c(%rcx), %ecx
               	movl	0x1c(%rdx), %edx
               	subq	%rdx, %rcx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0xf80(%rbp), %rcx
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
               	leaq	-0x1670(%rbp), %rsi
               	leaq	-0x1690(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xfa0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xf80(%rbp), %rdi
               	leaq	-0xfa0(%rbp), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x30, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0xf30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xf40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x328(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	shlq	$0x7, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xf50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	leaq	-0xf30(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xf60(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xf50(%rbp), %rdi
               	leaq	-0xf60(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x31, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0xf30(%rbp), %rdx
               	leaq	-0x338(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xf08(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0xf30(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xf18(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	pushq	%rcx
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xf08(%rbp), %rdi
               	leaq	-0xf18(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x32, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0xf40(%rbp), %rdx
               	leaq	-0x348(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	sarq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	sarq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xee8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rsi
               	leaq	-0xf40(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xef8(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	leaq	(%rsi,%rdx), %r9
               	movswq	(%r9), %r9
               	addq	%rdi, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	sarq	%cl, %rdx
               	popq	%rcx
               	movw	%dx, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xee8(%rbp), %rdi
               	leaq	-0xef8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x33, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0xf40(%rbp), %rdx
               	leaq	-0x358(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xec8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rdi
               	leaq	-0xf40(%rbp), %r8
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xed8(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rdx
               	movswq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movslq	%edx, %rsi
               	movw	%si, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xec8(%rbp), %rdi
               	leaq	-0xed8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x34, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	leaq	-0x368(%rbp), %rax
               	movslq	(%rcx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, (%rax)
               	movslq	0x4(%rcx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, 0x4(%rax)
               	movslq	0x8(%rcx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	sarq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xea8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xeb8(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xea8(%rbp), %rdi
               	leaq	-0xeb8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x35, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15d0(%rbp), %rcx
               	leaq	-0x378(%rbp), %rax
               	movl	(%rcx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rcx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, 0x4(%rax)
               	movl	0x8(%rcx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, 0x8(%rax)
               	movl	0xc(%rcx), %ecx
               	shrq	$0x3, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xe88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15d0(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xe98(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, %edx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xe88(%rbp), %rdi
               	leaq	-0xe98(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x388(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	shlq	$0x2, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xe68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xe78(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	shlq	$0x2, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xe68(%rbp), %rdi
               	leaq	-0xe78(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x37, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x398(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xe48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xe58(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	subq	$0x40, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xe48(%rbp), %rdi
               	leaq	-0xe58(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x3a8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	addq	$0x64, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xe28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xe38(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	addq	$0x64, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xe28(%rbp), %rdi
               	leaq	-0xe38(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x39, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x3b8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	imulq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xe08(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xe18(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xe08(%rbp), %rdi
               	leaq	-0xe18(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x3c8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xde8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xdf8(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	movl	$0x7, %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xde8(%rbp), %rdi
               	leaq	-0xdf8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x3d8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xdc8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xdd8(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	movl	$0x7, %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xdc8(%rbp), %rdi
               	leaq	-0xdd8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0xf, %edx
               	leaq	-0x3e8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	andq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xda8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xdb8(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	andq	$0xf, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xda8(%rbp), %rdi
               	leaq	-0xdb8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0xf0, %edx
               	leaq	-0x3f8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	orq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd98(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	orq	$0xf0, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd88(%rbp), %rdi
               	leaq	-0xd98(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0x55, %edx
               	leaq	-0x408(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	xorq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd78(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x55, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd68(%rbp), %rdi
               	leaq	-0xd78(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x418(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	subq	$0x64, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd58(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	subq	$0x64, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd48(%rbp), %rdi
               	leaq	-0xd58(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x40, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	movl	$0x3, %edx
               	leaq	-0x428(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd38(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	movl	$0x3, %r8d
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd28(%rbp), %rdi
               	leaq	-0xd38(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x41, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rcx
               	movl	$0x3, %edx
               	leaq	-0x438(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xd08(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd18(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	movl	$0x3, %r8d
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	popq	%rax
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xd08(%rbp), %rdi
               	leaq	-0xd18(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x42, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1590(%rbp), %rcx
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	leaq	-0x448(%rbp), %rax
               	movzwq	(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, (%rax)
               	movzwq	0x2(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, 0x2(%rax)
               	movzwq	0x4(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, 0x4(%rax)
               	movzwq	0x6(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, 0x6(%rax)
               	movzwq	0x8(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, 0x8(%rax)
               	movzwq	0xa(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, 0xa(%rax)
               	movzwq	0xc(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movw	%si, 0xc(%rax)
               	movzwq	0xe(%rcx), %rcx
               	imulq	%rdx, %rcx
               	movw	%cx, 0xe(%rax)
               	leaq	-0xce8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1590(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xcf8(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movzwq	(%rdx), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0xce8(%rbp), %rdi
               	leaq	-0xcf8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x43, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x458(%rbp), %rax
               	movq	(%rcx), %rsi
               	imulq	%rdx, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xcc8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xcd8(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rdx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0xcc8(%rbp), %rdi
               	leaq	-0xcd8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x44, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0x40, %edx
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x468(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xca8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xcb8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	movl	$0x40, %edx
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	subq	%r8, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xca8(%rbp), %rdi
               	leaq	-0xcb8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x45, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0x64, %edx
               	leaq	-0x1570(%rbp), %rcx
               	leaq	-0x478(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rax)
               	movsbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1570(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc98(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	movl	$0x64, %edx
               	leaq	(%rdi,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	subq	%rsi, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc88(%rbp), %rdi
               	leaq	-0xc98(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x46, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0xfa, %edx
               	leaq	-0x1560(%rbp), %rcx
               	leaq	-0x488(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1560(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc78(%rbp), %rsi
               	addq	%rcx, %rsi
               	movl	$0xfa, %edi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc68(%rbp), %rdi
               	leaq	-0xc78(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x47, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0xfa, %edx
               	leaq	-0x1560(%rbp), %rcx
               	leaq	-0x498(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1560(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc58(%rbp), %rsi
               	addq	%rcx, %rsi
               	movl	$0xfa, %edi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc48(%rbp), %rdi
               	leaq	-0xc58(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x61, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0xf, %edx
               	leaq	-0x1560(%rbp), %rcx
               	leaq	-0x4a8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	andq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1560(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc38(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	andq	$0xf, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc28(%rbp), %rdi
               	leaq	-0xc38(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x62, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0x3, %edx
               	leaq	-0xf30(%rbp), %rcx
               	leaq	-0x4b8(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xc08(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xf30(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xc18(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	movl	$0x3, %edx
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xc08(%rbp), %rdi
               	leaq	-0xc18(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x63, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movl	$0x80, %edx
               	leaq	-0xf30(%rbp), %rcx
               	leaq	-0x4c8(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xbe8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xf30(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xbf8(%rbp), %rsi
               	addq	%rcx, %rsi
               	movl	$0x80, %edi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xbe8(%rbp), %rdi
               	leaq	-0xbf8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x64, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rdx
               	leaq	-0x1600(%rbp), %rcx
               	leaq	-0x4d8(%rbp), %rax
               	movslq	(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xbc8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1600(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xbd8(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	movabsq	$-0x7, %r8
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xbc8(%rbp), %rdi
               	leaq	-0xbd8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x65, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rdx
               	leaq	-0x1600(%rbp), %rcx
               	leaq	-0x4e8(%rbp), %rax
               	movslq	(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0xc(%rax)
               	leaq	-0xba8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1600(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xbb8(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	movabsq	$-0x7, %r8
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	popq	%rax
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xba8(%rbp), %rdi
               	leaq	-0xbb8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x66, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	movl	$0x3, %edx
               	leaq	-0x4f8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0xb88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb98(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	movl	$0x3, %r8d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xb88(%rbp), %rdi
               	leaq	-0xb98(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x48, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rcx
               	movl	$0x7, %edx
               	leaq	-0x508(%rbp), %rax
               	movslq	(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, (%rax)
               	movslq	0x4(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x4(%rax)
               	movslq	0x8(%rcx), %rsi
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x8(%rax)
               	movslq	0xc(%rcx), %rcx
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
               	leaq	-0xb68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15f0(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xb78(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	movl	$0x7, %r8d
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xb68(%rbp), %rdi
               	leaq	-0xb78(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x60, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rdx
               	leaq	-0x518(%rbp), %rcx
               	movzbq	(%rdx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rcx)
               	movzbq	0x1(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rcx)
               	leaq	-0xb48(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x1550(%rbp), %rsi
               	jmp	<addr>
               	leaq	-0xb58(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	imulq	$-0x1, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xb48(%rbp), %rdi
               	leaq	-0xb58(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x49, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1570(%rbp), %rdx
               	leaq	-0x528(%rbp), %rcx
               	movsbq	(%rdx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, (%rcx)
               	movsbq	0x1(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movb	%sil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rcx)
               	leaq	-0xb28(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x1570(%rbp), %rdi
               	jmp	<addr>
               	leaq	-0xb38(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	imulq	$-0x1, %rdx, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xb28(%rbp), %rdi
               	leaq	-0xb38(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rdx
               	leaq	-0x538(%rbp), %rcx
               	movslq	(%rdx), %rsi
               	xorq	%rax, %rax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movl	%esi, (%rcx)
               	movslq	0x4(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movl	%esi, 0x4(%rcx)
               	movslq	0x8(%rdx), %rsi
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movl	%esi, 0x8(%rcx)
               	movslq	0xc(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xb08(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x15f0(%rbp), %rsi
               	jmp	<addr>
               	leaq	-0xb18(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	$-0x1, %rdx, %rdx
               	movl	%edx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0xb08(%rbp), %rdi
               	leaq	-0xb18(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x548(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	xorq	$-0x1, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xae8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xaf8(%rbp), %rsi
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$-0x1, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xae8(%rbp), %rdi
               	leaq	-0xaf8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x558(%rbp), %rax
               	movq	(%rcx), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rcx
               	xorq	$-0x1, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xac8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xad8(%rbp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0xac8(%rbp), %rdi
               	leaq	-0xad8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x568(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x908(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x918(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x918(%rbp), %rsi
               	leaq	-0x918(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x578(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	addq	%r8, %rdi
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x918(%rbp), %rdi
               	leaq	-0x908(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x588(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x928(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x938(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x938(%rbp), %rsi
               	leaq	-0x938(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x598(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	subq	%r8, %rdi
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x938(%rbp), %rdi
               	leaq	-0x928(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x5a8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x948(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x958(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x958(%rbp), %rsi
               	leaq	-0x958(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x5b8(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	imulq	%r8, %rdi
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x958(%rbp), %rdi
               	leaq	-0x948(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x50, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x5c8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x968(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x978(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x978(%rbp), %rsi
               	leaq	-0x978(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x5d8(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x978(%rbp), %rdi
               	leaq	-0x968(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x51, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x5e8(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
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
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x988(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x998(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x998(%rbp), %rsi
               	leaq	-0x998(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x5f8(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x998(%rbp), %rdi
               	leaq	-0x988(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x52, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x608(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9a8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x9b8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x9b8(%rbp), %rsi
               	leaq	-0x9b8(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x618(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	andq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x9b8(%rbp), %rdi
               	leaq	-0x9a8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x53, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x628(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9c8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x9d8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x9d8(%rbp), %rsi
               	leaq	-0x9d8(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x638(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	orq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x9d8(%rbp), %rdi
               	leaq	-0x9c8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x54, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x648(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9e8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x9f8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x9f8(%rbp), %rsi
               	leaq	-0x9f8(%rbp), %rcx
               	leaq	-0x1560(%rbp), %rdx
               	leaq	-0x658(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	xorq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x9f8(%rbp), %rdi
               	leaq	-0x9e8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x55, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0xf30(%rbp), %rdx
               	leaq	-0x668(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	movzbq	(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	movzbq	0x1(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	movzbq	0x2(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	movzbq	0x3(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	movzbq	0x4(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	movzbq	0x5(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	movzbq	0x6(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	movzbq	0x7(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	movzbq	0x8(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	movzbq	0x9(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	movzbq	0xa(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	movzbq	0xb(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	movzbq	0xc(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	movzbq	0xd(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	movzbq	0xe(%rdx), %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xa08(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0xa18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa18(%rbp), %rsi
               	leaq	-0xa18(%rbp), %rcx
               	leaq	-0xf30(%rbp), %rdx
               	leaq	-0x678(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xa18(%rbp), %rdi
               	leaq	-0xa08(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x56, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0xf30(%rbp), %rdx
               	leaq	-0x688(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xa28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0xa38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa38(%rbp), %rsi
               	leaq	-0xa38(%rbp), %rcx
               	leaq	-0xf30(%rbp), %rdx
               	leaq	-0x698(%rbp), %rax
               	movzbq	(%rcx), %rdi
               	movzbq	(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, (%rax)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movb	%dil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xa38(%rbp), %rdi
               	leaq	-0xa28(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x57, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15b0(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x6a8(%rbp), %rax
               	movswq	(%rcx), %rsi
               	movswq	(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, (%rax)
               	movswq	0x2(%rcx), %rsi
               	movswq	0x2(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x2(%rax)
               	movswq	0x4(%rcx), %rsi
               	movswq	0x4(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x4(%rax)
               	movswq	0x6(%rcx), %rsi
               	movswq	0x6(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x6(%rax)
               	movswq	0x8(%rcx), %rsi
               	movswq	0x8(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0x8(%rax)
               	movswq	0xa(%rcx), %rsi
               	movswq	0xa(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xa(%rax)
               	movswq	0xc(%rcx), %rsi
               	movswq	0xc(%rdx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movw	%si, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	leaq	-0xa48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x15b0(%rbp), %rax
               	leaq	-0xa58(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa58(%rbp), %rsi
               	leaq	-0xa58(%rbp), %rcx
               	leaq	-0x15c0(%rbp), %rdx
               	leaq	-0x6b8(%rbp), %rax
               	movswq	(%rcx), %rdi
               	movswq	(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, (%rax)
               	movswq	0x2(%rcx), %rdi
               	movswq	0x2(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, 0x2(%rax)
               	movswq	0x4(%rcx), %rdi
               	movswq	0x4(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, 0x4(%rax)
               	movswq	0x6(%rcx), %rdi
               	movswq	0x6(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, 0x6(%rax)
               	movswq	0x8(%rcx), %rdi
               	movswq	0x8(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, 0x8(%rax)
               	movswq	0xa(%rcx), %rdi
               	movswq	0xa(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, 0xa(%rax)
               	movswq	0xc(%rcx), %rdi
               	movswq	0xc(%rdx), %r8
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movw	%di, 0xc(%rax)
               	movswq	0xe(%rcx), %rcx
               	movswq	0xe(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movw	%cx, 0xe(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xa58(%rbp), %rdi
               	leaq	-0xa48(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x58, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1630(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x6c8(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1630(%rbp), %rax
               	leaq	-0xa78(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa78(%rbp), %rsi
               	leaq	-0xa78(%rbp), %rcx
               	leaq	-0x1640(%rbp), %rdx
               	leaq	-0x6d8(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	imulq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xa78(%rbp), %rdi
               	leaq	-0xa68(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x59, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0xa88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa88(%rbp), %rdx
               	leaq	-0xa88(%rbp), %rcx
               	leaq	-0x6e8(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x6f8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0xa98(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xa88(%rbp), %rdi
               	leaq	-0xa98(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0xaa8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xaa8(%rbp), %rdx
               	leaq	-0xaa8(%rbp), %rcx
               	leaq	-0x708(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0xaa8(%rbp), %rdx
               	leaq	-0xaa8(%rbp), %rcx
               	leaq	-0x718(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0xaa8(%rbp), %rdx
               	leaq	-0xaa8(%rbp), %rcx
               	leaq	-0x728(%rbp), %rax
               	movzbq	(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, (%rax)
               	movzbq	0x1(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x1(%rax)
               	movzbq	0x2(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x2(%rax)
               	movzbq	0x3(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x3(%rax)
               	movzbq	0x4(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4(%rax)
               	movzbq	0x5(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x5(%rax)
               	movzbq	0x6(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x6(%rax)
               	movzbq	0x7(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x7(%rax)
               	movzbq	0x8(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x8(%rax)
               	movzbq	0x9(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x9(%rax)
               	movzbq	0xa(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xa(%rax)
               	movzbq	0xb(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xb(%rax)
               	movzbq	0xc(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xc(%rax)
               	movzbq	0xd(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xd(%rax)
               	movzbq	0xe(%rcx), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xf(%rcx), %rcx
               	subq	$0x40, %rcx
               	movb	%cl, 0xf(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xab8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	subq	$0xc0, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0xaa8(%rbp), %rdi
               	leaq	-0xab8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x1560(%rbp), %rcx
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
               	movq	%r10, 0x68(%rsp)
               	addq	0x68(%rsp), %r15
               	movzbq	0x9(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0x9(%rcx), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %r10
               	addq	0x60(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0xa(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xa(%rcx), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x60(%rsp), %r10
               	addq	0x58(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xb(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xb(%rcx), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	0x50(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xc(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xc(%rcx), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	addq	0x48(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xd(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xd(%rcx), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x40(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xe(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0xe(%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rcx), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x38(%rsp)
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
               	movq	0x68(%rsp), %r15
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	movq	0x60(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x50(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x38(%rsp), %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x758(%rbp), %rax
               	andq	$0xff, %rdx
               	movzbq	(%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	subq	0x38(%rsp), %rdx
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
               	movq	0x68(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xa(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xa(%rax)
               	movq	0x60(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xb(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xb(%rax)
               	movq	0x58(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xc(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xc(%rax)
               	movq	0x50(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xd(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xd(%rax)
               	movq	0x48(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xe(%rcx), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0xe(%rax)
               	movq	0x40(%rsp), %rdx
               	andq	$0xff, %rdx
               	movzbq	0xf(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x8e8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %r8
               	leaq	-0x1560(%rbp), %r9
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8f8(%rbp), %rdx
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
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x8e8(%rbp), %rdi
               	leaq	-0x8f8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x15f0(%rbp), %rax
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
               	leaq	-0x1600(%rbp), %rdx
               	leaq	-0x788(%rbp), %rcx
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
               	leaq	-0x8c8(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x15f0(%rbp), %rdi
               	leaq	-0x1600(%rbp), %r8
               	jmp	<addr>
               	leaq	-0x8d8(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	leaq	(%rdi,%rdx), %rsi
               	movslq	(%rsi), %rsi
               	movl	$0x3, %ebx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rbx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	imulq	$-0x1, %rsi, %rsi
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movl	%edx, (%r9)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x8c8(%rbp), %rdi
               	leaq	-0x8d8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rax
               	leaq	-0x898(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x898(%rbp), %rax
               	leaq	-0x798(%rbp), %rcx
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
               	movzbq	0xf(%rax), %rax
               	shlq	%rax
               	movb	%al, 0xf(%rcx)
               	leaq	-0x898(%rbp), %rax
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
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x68(%rsp)
               	movsbq	0x9(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x60(%rsp)
               	movsbq	0xa(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	movsbq	0xb(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	movsbq	0xc(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x48(%rsp)
               	movsbq	0xd(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x40(%rsp)
               	movsbq	0xe(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x38(%rsp)
               	movsbq	0xf(%rax), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1b, %edx
               	leaq	-0x7b8(%rbp), %rax
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
               	movq	0x68(%rsp), %rdi
               	movsbq	%dil, %rdi
               	movq	%rdi, %r8
               	andq	%rdx, %r8
               	leaq	0x8(%rax), %rdi
               	movb	%r8b, (%rdi)
               	movq	0x60(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0x9(%rax)
               	movq	0x58(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xa(%rax)
               	movq	0x50(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xb(%rax)
               	movq	0x48(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xc(%rax)
               	movq	0x40(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xd(%rax)
               	movq	0x38(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%rdx, %r8
               	movb	%r8b, 0xe(%rax)
               	movq	0x30(%rsp), %r8
               	movsbq	%r8b, %r8
               	andq	%r8, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x7c8(%rbp), %rdx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x8a8(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x1550(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	movsbq	%dl, %rdx
               	sarq	$0x7, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1b, %rdi
               	leaq	-0x8b8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	shlq	%rdx
               	andq	$0xff, %rdx
               	andq	$0xff, %rdi
               	xorq	%rdi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x8a8(%rbp), %rdi
               	leaq	-0x8b8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x1550(%rbp), %rcx
               	leaq	-0x1570(%rbp), %rdx
               	leaq	-0x7d8(%rbp), %rax
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
               	movzbq	0xf(%rcx), %rcx
               	movzbq	0xf(%rdx), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x870(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x1550(%rbp), %rsi
               	leaq	-0x1570(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x880(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x870(%rbp), %rdi
               	leaq	-0x880(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x830(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x840(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x7e8(%rbp), %rax
               	movl	$0x42, %esi
               	movb	%sil, (%rax)
               	xorq	%rsi, %rsi
               	movb	%sil, 0x1(%rax)
               	movl	$0x28, %esi
               	movb	%sil, 0x2(%rax)
               	xorq	%rsi, %rsi
               	movb	%sil, 0x3(%rax)
               	movl	$0x1d, %esi
               	movb	%sil, 0x4(%rax)
               	xorq	%rsi, %rsi
               	movb	%sil, 0x5(%rax)
               	movl	$0x16, %esi
               	movb	%sil, 0x6(%rax)
               	xorq	%rsi, %rsi
               	movb	%sil, 0x7(%rax)
               	movl	$0x1, %esi
               	movb	%sil, 0x8(%rax)
               	movl	$0x2, %esi
               	movb	%sil, 0x9(%rax)
               	movl	$0x3, %esi
               	movb	%sil, 0xa(%rax)
               	movl	$0x4, %esi
               	movb	%sil, 0xb(%rax)
               	movl	$0x5, %esi
               	movb	%sil, 0xc(%rax)
               	movl	$0x6, %esi
               	movb	%sil, 0xd(%rax)
               	movl	$0x7, %esi
               	movb	%sil, 0xe(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0xf(%rax)
               	leaq	-0x850(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x830(%rbp), %rdx
               	leaq	-0x840(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x860(%rbp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
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
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x850(%rbp), %rdi
               	leaq	-0x860(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x67, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	leaq	-0x830(%rbp), %rcx
               	leaq	-0x840(%rbp), %rdx
               	leaq	-0x7f8(%rbp), %rax
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
               	movsbq	0xf(%rcx), %rcx
               	movsbq	0xf(%rdx), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movb	%cl, 0xf(%rax)
               	leaq	-0x808(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x830(%rbp), %rsi
               	leaq	-0x840(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x818(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	leaq	(%rdi,%rcx), %r9
               	movsbq	(%r9), %r9
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rdx
               	popq	%rax
               	movb	%dl, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x808(%rbp), %rdi
               	leaq	-0x818(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x68, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1750, %rsp           # imm = 0x1750
               	popq	%rbp
               	retq
