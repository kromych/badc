
int128_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<chk>:
               	popq	%r10
               	subq	$0x40, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movq	%rcx, %rdi
               	movq	%r8, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	xorq	%rsi, %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	cmpq	%rdi, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x310, %rsp            # imm = 0x310
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0xa8(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	movq	%rsi, %rdx
               	orq	%rax, %rdx
               	orq	%rsi, %rcx
               	leaq	-0xb8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movabsq	$-0x1, %rcx
               	leaq	-0xc8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	leaq	(%rcx,%rax), %rdx
               	cmpq	%rcx, %rdx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	(%rsi), %rcx
               	addq	%rax, %rcx
               	leaq	-0xd8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movq	%rdx, %r8
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	(%rbx), %rax
               	xorq	%rsi, %rsi
               	cmpq	%rax, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rcx
               	leaq	(%rdx), %rax
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
               	leaq	-0xe8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rdi
               	movabsq	$-0x1, %rax
               	movl	$0x2, %ecx
               	movq	%rax, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	(%rcx,%rsi), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	leaq	-0xf8(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x22446688aaccee, %rsi # imm = 0x22446688AACCEE
               	movabsq	$0x1133557799bbddfe, %rdx # imm = 0x1133557799BBDDFE
               	movl	$0x3, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	movq	(%rbx), %rdx
               	leaq	-0x108(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x118(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rsi, %rcx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	subq	%rdi, %rax
               	leaq	-0x128(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x11223344556677, %rsi # imm = 0xFFEEDDCCBBAA9989
               	movabsq	$0x7766554433221101, %rdx # imm = 0x7766554433221101
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	movq	(%rbx), %rdx
               	leaq	-0x138(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	testq	%rdx, %rdx
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	subq	%rax, %rcx
               	leaq	-0x148(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rdi
               	movabsq	$-0x1, %rsi
               	movl	$0x5, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x158(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	subq	%rcx, %rax
               	subq	%rsi, %rax
               	leaq	-0x168(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x11223344556677, %rsi # imm = 0xFFEEDDCCBBAA9989
               	movabsq	$0x7766554433221100, %rdx # imm = 0x7766554433221100
               	movl	$0x6, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rax
               	leaq	-0x178(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x11223344556678, %rsi # imm = 0xFFEEDDCCBBAA9988
               	movabsq	$0x7766554433221100, %rdx # imm = 0x7766554433221100
               	movl	$0x7, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	leaq	-0x188(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	leaq	-0x198(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, %rax
               	andq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	%rdx, %rcx
               	leaq	-0x1a8(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x11223344550000, %rsi # imm = 0x11223344550000
               	movabsq	$-0x7766554433221101, %rdx # imm = 0x8899AABBCCDDEEFF
               	movl	$0x8, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movq	(%rbx), %rdx
               	leaq	-0x1b8(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	shlq	$0x3f, %rdx
               	leaq	-0x1c8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, %rax
               	orq	%rcx, %rax
               	movq	%rdi, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x1d8(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x11223344556677, %rsi # imm = 0x11223344556677
               	movabsq	$-0x7766554433221101, %rdx # imm = 0x8899AABBCCDDEEFF
               	movl	$0x9, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	leaq	-0x1e8(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	xorq	%rsi, %rsi
               	movl	$0xa, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rbx), %rdx
               	leaq	-0x208(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x218(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rax
               	xorq	%rcx, %rax
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rax, %rdx
               	leaq	-0x228(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	(%rbx), %rax
               	addq	%rcx, %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdx
               	addq	%rdx, %rcx
               	leaq	-0x238(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x11223344556678, %rsi # imm = 0x11223344556678
               	movabsq	$-0x7766554433221101, %rdx # imm = 0x8899AABBCCDDEEFF
               	movl	$0xc, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	movq	(%r12), %rsi
               	xorq	%rcx, %rcx
               	movq	(%rbx), %rdx
               	leaq	-0x248(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x258(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rsi, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdx
               	addq	%rdx, %rcx
               	leaq	-0x268(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movq	(%r12), %rsi
               	movl	$0x1, %edx
               	movl	$0xd, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x58(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %r9
               	leaq	-0x58(%rbp), %rcx
               	movq	0x8(%rcx), %rdi
               	xorq	%rdx, %rdx
               	leaq	-0x278(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %r8
               	leaq	-0x288(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	orq	%rdx, %rdi
               	orq	%r8, %rdx
               	leaq	-0x298(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	(%rsi,%rdi), %rcx
               	cmpq	%rsi, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%r9, %rdx
               	addq	%rsi, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x58(%rbp), %rdi
               	movabsq	$-0x77553310eeccaa8a, %rsi # imm = 0x88AACCEF11335576
               	movl	$0xe, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rdi
               	movq	(%rbx), %rsi
               	xorq	%rax, %rax
               	cmpq	%rsi, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rsi, %rdx
               	leaq	(%rdi), %rsi
               	subq	%r8, %rsi
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %r9
               	movl	$0xff, %esi
               	leaq	-0x2a8(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	xorq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	leaq	-0x2b8(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	%rdi, 0x8(%rdx)
               	movq	%r8, %rdx
               	andq	%rsi, %rdx
               	movq	%r9, %rsi
               	andq	%rdi, %rsi
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	orq	$0x5, %rdx
               	orq	%rax, %rsi
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdi
               	movq	0x8(%rcx), %r8
               	movq	(%rbx), %rsi
               	leaq	-0x2c8(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	shlq	$0x3f, %rsi
               	leaq	-0x2d8(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	xorq	%rdi, %rax
               	movq	%r8, %rdx
               	xorq	%rsi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rdi
               	movabsq	$-0x77553310eeccaafb, %rsi # imm = 0x88AACCEF11335505
               	movabsq	$0x8aaccef11335576, %rdx # imm = 0x8AACCEF11335576
               	movl	$0xf, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rcx
               	leaq	-0x2e8(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdi
               	movl	$0x1, %r8d
               	leaq	0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdi
               	addq	%rdi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rdi
               	movl	$0x10, %ecx
               	movq	%rsi, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	-0x2f8(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movabsq	$-0x1, %rdi
               	leaq	-0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	decq	%rsi
               	addq	%rsi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	$0x11, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rdi, %rdx
               	movq	%rax, %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x310, %rsp            # imm = 0x310
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
