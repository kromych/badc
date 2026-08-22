
int128_shift.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	xorq	%rdx, %rdx
               	leaq	<rip>, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	(%r10), %rcx
               	movq	%rdx, %rdi
               	orq	%rcx, %rdi
               	movq	%rax, %r9
               	orq	%rdx, %r9
               	movl	$0x1, %r14d
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r12d
               	movq	%r12, %r15
               	subq	%rsi, %r15
               	shrq	$0x6, %r8
               	xorq	%r12, %r12
               	movq	%r8, %r10
               	movq	%r12, %r8
               	subq	%r10, %r8
               	movq	%r8, %r12
               	xorq	$-0x1, %r12
               	movq	%rdi, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%r15, %r10
               	movq	%rdi, %r15
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	orq	%r15, %rsi
               	movq	%r13, %r15
               	andq	%r12, %r15
               	orq	$0x0, %r15
               	andq	%r12, %rsi
               	andq	%r13, %r8
               	movq	%rsi, %r12
               	orq	%r8, %r12
               	leaq	<rip>, %r8
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r8
               	movq	(%r8), %r8
               	leaq	<rip>, %r13
               	addq	%r13, %rsi
               	movq	(%rsi), %r13
               	leaq	0x14(%rax), %rsi
               	movslq	%esi, %rsi
               	cmpq	%r8, %r15
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	%r13, %r12
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r12d
               	movq	%r12, %r15
               	subq	%rsi, %r15
               	shrq	$0x6, %r8
               	xorq	%r12, %r12
               	movq	%r8, %r10
               	movq	%r12, %r8
               	subq	%r10, %r8
               	movq	%r8, %r12
               	xorq	$-0x1, %r12
               	movq	%r9, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r15, %r10
               	movq	%r9, %r15
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	shlq	%r15
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r15, %rsi
               	andq	%r12, %rsi
               	andq	%r13, %r8
               	orq	%rsi, %r8
               	movq	%r13, %rsi
               	andq	%r12, %rsi
               	movq	%rsi, %r12
               	orq	$0x0, %r12
               	leaq	<rip>, %r13
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r13
               	movq	(%r13), %r13
               	leaq	<rip>, %r15
               	addq	%r15, %rsi
               	movq	(%rsi), %r15
               	leaq	0x1e(%rax), %rsi
               	movslq	%esi, %rsi
               	cmpq	%r13, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	%r15, %r12
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r8d
               	movq	%r8, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %rsi
               	xorq	%r8, %r8
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	movq	%rbx, %r12
               	sarq	%cl, %r12
               	movq	%r13, %r10
               	movq	%rbx, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	movq	%rcx, %r10
               	movq	%r14, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r13, %rcx
               	andq	%r8, %rcx
               	movq	%r12, %r13
               	andq	%rsi, %r13
               	orq	%rcx, %r13
               	movq	%r12, %rcx
               	andq	%r8, %rcx
               	andq	$-0x1, %rsi
               	movq	%rcx, %r8
               	orq	%rsi, %r8
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %r12
               	addq	%r12, %rcx
               	movq	(%rcx), %r12
               	leaq	0x28(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rsi, %r13
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	%r12, %r8
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	jl	<addr>
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	shlq	%rax
               	movq	%r9, %rcx
               	shlq	%rcx
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rcx
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
               	shlq	$0x3f, %rcx
               	movq	%r9, %rax
               	shlq	$0x3f, %rax
               	movq	%rdi, %rdx
               	shrq	%rdx
               	orq	%rax, %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	shlq	%rax
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rcx
               	shrq	%rcx
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%r9, %rdx
               	shlq	$0x3f, %rdx
               	orq	%rdx, %rax
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x444cd55de66ef77f, %r11 # imm = 0x444CD55DE66EF77F
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	shrq	$0x3f, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	shrq	$0x6, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdi, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	shlq	%rdi
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	orq	%rdi, %rax
               	andq	%rsi, %rax
               	movq	%r8, %rcx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%r8, %rcx
               	andq	%rsi, %rcx
               	orq	$0x0, %rcx
               	movq	0x40(%rsp), %r10
               	movq	(%r10), %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
