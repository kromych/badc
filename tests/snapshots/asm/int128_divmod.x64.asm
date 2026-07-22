
int128_divmod.x64:	file format elf64-x86-64

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
               	subq	$0x640, %rsp            # imm = 0x640
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, 0x8(%rax)
               	leaq	-0xa8(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	movq	%r12, %rdx
               	orq	%rax, %rdx
               	orq	%r12, %rcx
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
               	movl	$0x1, %ecx
               	leaq	-0xc8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r12, 0x8(%rax)
               	shlq	$0x3f, %rcx
               	leaq	-0xd8(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	cmpq	$0x1, %r12
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%r12), %rdx
               	subq	$0x0, %rcx
               	subq	%rax, %rcx
               	leaq	-0xe8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rcx
               	leaq	<rip>, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r8
               	movq	%rcx, %rax
               	orq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	movq	%rbx, %rdi
               	orq	%r9, %rdi
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	testq	%rax, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rsi
               	xorq	$0x1, %rsi
               	xorq	%r9, %r9
               	subq	%rsi, %r9
               	movq	%r8, %rbx
               	andq	%r9, %rbx
               	andq	%r12, %r9
               	cmpq	%rbx, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%rbx, %rdi
               	subq	%r9, %rax
               	subq	%r14, %rax
               	orq	%r13, %rsi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	-0x120(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x3333333333333334, %rsi # imm = 0xCCCCCCCCCCCCCCCC
               	movabsq	$0xccccccccccccccc, %rdx # imm = 0xCCCCCCCCCCCCCCC
               	movl	$0x1, %ecx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rcx
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r8
               	xorq	%r12, %r12
               	movq	%rcx, %rax
               	orq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%rbx, %rsi
               	orq	%r9, %rsi
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r9, %r9
               	subq	%rdi, %r9
               	movq	%r8, %rbx
               	andq	%r9, %rbx
               	andq	%r12, %r9
               	cmpq	%rbx, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%rbx, %rsi
               	subq	%r9, %rax
               	subq	%r14, %rax
               	orq	%r13, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x158(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x7, %esi
               	xorq	%rdx, %rdx
               	movl	$0x2, %ecx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x168(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x178(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	0x3(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	leaq	(%rdx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x188(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rcx
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rdi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	movq	%r12, %rdi
               	orq	%rbx, %rdi
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	cmpq	%r8, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rsi
               	xorq	$0x1, %rsi
               	xorq	%rbx, %rbx
               	subq	%rsi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rdi
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	orq	%r13, %rsi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	-0x1c0(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x7766554433221103, %rsi # imm = 0x8899AABBCCDDEEFD
               	xorq	%rdx, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rcx
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	orq	%r13, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x1f8(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0x664421ffddbb9980, %rsi # imm = 0x664421FFDDBB9980
               	xorq	%rdx, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	movq	(%r15), %rdi
               	leaq	-0x208(%rbp), %rax
               	movq	%rdi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rdi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	movq	%r12, %rdi
               	orq	%rbx, %rdi
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	cmpq	%r8, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rsi
               	xorq	$0x1, %rsi
               	xorq	%rbx, %rbx
               	subq	%rsi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rdi
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	orq	%r13, %rsi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	-0x240(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	xorq	%rsi, %rsi
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	movq	(%r15), %rsi
               	leaq	-0x250(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	orq	%r13, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x288(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	(%r15), %rsi
               	xorq	%rdx, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	movl	$0x3, %ecx
               	leaq	-0x298(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%r10, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r11
               	movq	%r11, 0x8(%rax)
               	movq	%rcx, %rdx
               	shlq	$0x24, %rdx
               	leaq	-0x2a8(%rbp), %rax
               	movq	0x58(%rsp), %r11
               	movq	%r11, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	0x58(%rsp), %rcx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	cmpq	0x58(%rsp), %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	$0x0, %rdx
               	addq	%rax, %rdx
               	leaq	-0x2b8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	testq	%rcx, %rcx
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rcx, %r10
               	movq	0x58(%rsp), %rcx
               	subq	%r10, %rcx
               	movq	%rdx, %r10
               	movq	0x58(%rsp), %rdx
               	subq	%r10, %rdx
               	subq	%rax, %rdx
               	leaq	-0x2c8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %r12
               	sarq	$0x3f, %r12
               	xorq	%r12, %rcx
               	xorq	%r12, %rax
               	cmpq	%r12, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rcx, %rsi
               	subq	%r12, %rsi
               	subq	%r12, %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movl	$0x7, %ebx
               	xorq	%r13, %r13
               	movq	%rcx, %rax
               	orq	%r13, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r8
               	shrq	$0x3f, %r8
               	movq	%rsi, %r9
               	shlq	%r9
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r9, %rsi
               	orq	%r8, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x7, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r8, %r8
               	subq	%rdi, %r8
               	movq	%rbx, %r9
               	andq	%r8, %r9
               	andq	%r13, %r8
               	cmpq	%r9, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r9, %rsi
               	subq	%r8, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%r12, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rcx
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %r9
               	subq	%rdx, %r9
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	subq	%r8, %rdx
               	leaq	-0x300(%rbp), %rdi
               	movq	%r9, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movabsq	$-0x6db6db6db6db749a, %rsi # imm = 0x9249249249248B66
               	movabsq	$-0x6db6db6dc, %rdx     # imm = 0xFFFFFFF924924924
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %r12
               	sarq	$0x3f, %r12
               	xorq	%r12, %rcx
               	xorq	%r12, %rax
               	cmpq	%r12, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rcx, %rsi
               	subq	%r12, %rsi
               	subq	%r12, %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movl	$0x7, %ebx
               	xorq	%r13, %r13
               	movq	%rcx, %rax
               	orq	%r13, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r8
               	shrq	$0x3f, %r8
               	movq	%rsi, %r9
               	shlq	%r9
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r9, %rsi
               	orq	%r8, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x7, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r8, %r8
               	subq	%rdi, %r8
               	movq	%rbx, %r9
               	andq	%r8, %r9
               	andq	%r13, %r8
               	cmpq	%r9, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r9, %rsi
               	subq	%r8, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	%r12, %rcx
               	xorq	%r12, %rax
               	cmpq	%r12, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r12, %rcx
               	subq	%r12, %rax
               	subq	%rdx, %rax
               	leaq	-0x338(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x3, %rsi
               	movabsq	$-0x1, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x348(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	shlq	$0x6, %rdx
               	leaq	-0x358(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	testq	%rax, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rsi
               	subq	%rax, %rsi
               	subq	%rdx, %rax
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	leaq	-0x368(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x58(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	sarq	$0x3f, %r13
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%r13, %rdx
               	xorq	%r13, %rcx
               	cmpq	%r13, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rsi
               	subq	%r13, %rsi
               	subq	%r13, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x58(%rsp), %rax
               	cmpq	0x58(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	0x58(%rsp), %r9
               	subq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%r13, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rcx
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %r9
               	subq	%rdx, %r9
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	subq	%r8, %rdx
               	leaq	-0x3a0(%rbp), %rdi
               	movq	%r9, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movl	$0xc0000000, %esi       # imm = 0xC0000000
               	xorq	%rdx, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	sarq	$0x3f, %r13
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%r13, %rdx
               	xorq	%r13, %rcx
               	cmpq	%r13, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rsi
               	subq	%r13, %rsi
               	subq	%r13, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x58(%rsp), %rax
               	cmpq	0x58(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	0x58(%rsp), %r9
               	subq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	%r13, %rcx
               	xorq	%r13, %rax
               	cmpq	%r13, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r13, %rcx
               	subq	%r13, %rax
               	subq	%rdx, %rax
               	leaq	-0x3d8(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x3039, %rsi          # imm = 0xCFC7
               	movabsq	$-0x1, %rdx
               	movl	$0xa, %ecx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	subq	%rsi, %rax
               	movq	%rax, %rcx
               	subq	%rdi, %rcx
               	leaq	-0x3e8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	sarq	$0x3f, %r13
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%r13, %rdx
               	xorq	%r13, %rcx
               	cmpq	%r13, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rsi
               	subq	%r13, %rsi
               	subq	%r13, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x58(%rsp), %rax
               	cmpq	0x58(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	0x58(%rsp), %r9
               	subq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%r13, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rcx
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %r9
               	subq	%rdx, %r9
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	subq	%r8, %rdx
               	leaq	-0x420(%rbp), %rdi
               	movq	%r9, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movabsq	$-0xc0000000, %rsi      # imm = 0xFFFFFFFF40000000
               	movabsq	$-0x1, %rdx
               	movl	$0xb, %ecx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	subq	%rsi, %rax
               	movq	%rax, %rcx
               	subq	%rdi, %rcx
               	leaq	-0x430(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	sarq	$0x3f, %r13
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%r13, %rdx
               	xorq	%r13, %rcx
               	cmpq	%r13, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rsi
               	subq	%r13, %rsi
               	subq	%r13, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x58(%rsp), %rax
               	cmpq	0x58(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	0x58(%rsp), %r9
               	subq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	%r13, %rcx
               	xorq	%r13, %rax
               	cmpq	%r13, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r13, %rcx
               	subq	%r13, %rax
               	subq	%rdx, %rax
               	leaq	-0x468(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x3039, %esi           # imm = 0x3039
               	xorq	%rdx, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x8(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rcx
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r8
               	xorq	%r12, %r12
               	movq	%rcx, %rax
               	orq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	movq	%rbx, %rdi
               	orq	%r9, %rdi
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	testq	%rax, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rsi
               	xorq	$0x1, %rsi
               	xorq	%r9, %r9
               	subq	%rsi, %r9
               	movq	%r8, %rbx
               	andq	%r9, %rbx
               	andq	%r12, %r9
               	cmpq	%rbx, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%rbx, %rdi
               	subq	%r9, %rax
               	subq	%r14, %rax
               	orq	%r13, %rsi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	-0x4a0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %rcx
               	xorq	%r12, %r12
               	movq	%rsi, %r15
               	imulq	%rcx, %r15
               	movl	%esi, %edx
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movl	%ecx, %r8d
               	movq	%rcx, %r9
               	shrq	$0x20, %r9
               	movq	%rdx, %rbx
               	imulq	%r8, %rbx
               	shrq	$0x20, %rbx
               	imulq	%rdi, %r8
               	addq	%rbx, %r8
               	movl	%r8d, %ebx
               	shrq	$0x20, %r8
               	imulq	%r9, %rdx
               	addq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r9, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rdx
               	imulq	%r12, %rsi
               	imulq	%rcx, %rax
               	leaq	(%rdx,%rsi), %rcx
               	leaq	(%rcx,%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	-0x4b0(%rbp), %rax
               	movq	%r15, (%rax)
               	movq	0x58(%rsp), %r11
               	movq	%r11, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rcx
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r8
               	movq	%rcx, %rax
               	orq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%rbx, %rsi
               	orq	%r9, %rsi
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r9, %r9
               	subq	%rdi, %r9
               	movq	%r8, %rbx
               	andq	%r9, %rbx
               	andq	%r12, %r9
               	cmpq	%rbx, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%rbx, %rsi
               	subq	%r9, %rax
               	subq	%r14, %rax
               	orq	%r13, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x4e8(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	(%r15,%rsi), %rcx
               	cmpq	%r15, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r10
               	movq	0x58(%rsp), %rax
               	addq	%r10, %rax
               	addq	%rax, %rdx
               	leaq	-0x4f8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	0x48(%rsp), %rax
               	xorq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x8(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	sarq	$0x3f, %r13
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%r13, %rdx
               	xorq	%r13, %rcx
               	cmpq	%r13, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rsi
               	subq	%r13, %rsi
               	subq	%r13, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x58(%rsp), %rax
               	cmpq	0x58(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	0x58(%rsp), %r9
               	subq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%r13, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	%rdx, %rdi
               	movq	%rcx, %r8
               	xorq	%rdx, %r8
               	cmpq	%rdx, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdi, %rcx
               	subq	%rdx, %rcx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %rdi
               	subq	%r9, %rdi
               	leaq	-0x530(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x58(%rbp), %rdx
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rbx
               	movq	%rcx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	%ecx, %edx
               	movq	%rcx, %rsi
               	shrq	$0x20, %rsi
               	movl	%eax, %r8d
               	movq	%rax, %r9
               	shrq	$0x20, %r9
               	movq	%rdx, %r12
               	imulq	%r8, %r12
               	shrq	$0x20, %r12
               	imulq	%rsi, %r8
               	addq	%r12, %r8
               	movl	%r8d, %r12d
               	shrq	$0x20, %r8
               	imulq	%r9, %rdx
               	addq	%r12, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r9, %rsi
               	addq	%r8, %rsi
               	addq	%rsi, %rdx
               	imulq	%rbx, %rcx
               	imulq	%rdi, %rax
               	addq	%rdx, %rcx
               	leaq	(%rcx,%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	-0x540(%rbp), %rax
               	movq	0x48(%rsp), %r11
               	movq	%r11, (%rax)
               	movq	0x40(%rsp), %r11
               	movq	%r11, 0x8(%rax)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	movq	%rcx, %r13
               	sarq	$0x3f, %r13
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x58(%rsp)
               	xorq	%r13, %rdx
               	xorq	%r13, %rcx
               	cmpq	%r13, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rsi
               	subq	%r13, %rsi
               	subq	%r13, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	0x58(%rsp), %rdx
               	xorq	0x58(%rsp), %rax
               	cmpq	0x58(%rsp), %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	0x58(%rsp), %r9
               	subq	0x58(%rsp), %rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	%r13, %rcx
               	xorq	%r13, %rax
               	cmpq	%r13, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r13, %rcx
               	subq	%r13, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	leaq	-0x578(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %r10
               	movq	0x48(%rsp), %rcx
               	addq	%r10, %rcx
               	cmpq	0x48(%rsp), %rcx
               	setb	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r10
               	movq	0x40(%rsp), %rdx
               	addq	%r10, %rdx
               	addq	%rax, %rdx
               	leaq	-0x588(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	0x38(%rsp), %rax
               	xorq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %r15
               	movq	(%r15), %rdi
               	movq	0x8(%r15), %rcx
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r8
               	xorq	%r12, %r12
               	movq	%rcx, %rax
               	orq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	movq	%rbx, %rdi
               	orq	%r9, %rdi
               	movq	%rsi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	testq	%rax, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rsi
               	xorq	$0x1, %rsi
               	xorq	%r9, %r9
               	subq	%rsi, %r9
               	movq	%r8, %rbx
               	andq	%r9, %rbx
               	andq	%r12, %r9
               	cmpq	%rbx, %rdi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%rbx, %rdi
               	subq	%r9, %rax
               	subq	%r14, %rax
               	orq	%r13, %rsi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	movq	%rsi, (%r15)
               	movq	%rax, 0x8(%r15)
               	leaq	-0x68(%rbp), %r15
               	movq	(%r15), %rsi
               	movq	0x8(%r15), %rcx
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r9
               	movq	0x8(%rax), %r8
               	movq	%rcx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdi, %r13
               	shlq	%r13
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdi
               	xorq	$0x1, %rdi
               	xorq	%rbx, %rbx
               	subq	%rdi, %rbx
               	movq	%r9, %r12
               	andq	%rbx, %r12
               	andq	%r8, %rbx
               	cmpq	%r12, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	subq	%r12, %rsi
               	subq	%rbx, %rax
               	subq	%r14, %rax
               	orq	%r13, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, (%r15)
               	movq	%rax, 0x8(%r15)
               	leaq	-0x68(%rbp), %rdi
               	movabsq	$-0x4292c96669d3a3d8, %rsi # imm = 0xBD6D3699962C5C28
               	xorq	%rdx, %rdx
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
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x640, %rsp            # imm = 0x640
               	popq	%rbp
               	retq
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	jmp	<addr>
