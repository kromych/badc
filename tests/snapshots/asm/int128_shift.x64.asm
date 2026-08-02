
int128_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	movq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	leaq	<rip>, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	(%r10), %rax
               	movq	%rdx, %r8
               	orq	%rax, %r8
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movl	$0x1, %r15d
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x48(%rsp)
               	shrq	$0x6, %rdi
               	xorq	%r9, %r9
               	movq	%rdi, %r10
               	movq	%r9, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r13
               	xorq	$-0x1, %r13
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	movq	0x48(%rsp), %r11
               	movq	%r8, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r10
               	movq	%rbx, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	orq	0x48(%rsp), %rsi
               	movq	%r14, %r10
               	andq	%r13, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%rdi, %r9
               	movq	%r9, %r10
               	movq	0x48(%rsp), %r9
               	orq	%r10, %r9
               	andq	%r13, %rsi
               	andq	%r14, %rdi
               	movq	%rsi, %r13
               	orq	%rdi, %r13
               	leaq	<rip>, %r14
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r14
               	movq	(%r14), %r14
               	leaq	<rip>, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	addq	%r10, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x14(%rax), %rsi
               	movslq	%esi, %rsi
               	cmpq	%r14, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	cmpq	0x48(%rsp), %r13
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x48(%rsp)
               	shrq	$0x6, %rdi
               	xorq	%r9, %r9
               	movq	%rdi, %r10
               	movq	%r9, %rdi
               	subq	%r10, %rdi
               	movq	%rdi, %r13
               	xorq	$-0x1, %r13
               	movq	%rbx, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	movq	0x48(%rsp), %r11
               	movq	%rbx, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shlq	%r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	0x48(%rsp), %rsi
               	andq	%r13, %rsi
               	movq	%r14, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r10
               	orq	0x48(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r14, %rsi
               	andq	%r13, %rsi
               	andq	%r9, %rdi
               	movq	%rsi, %r13
               	orq	%rdi, %r13
               	leaq	<rip>, %r9
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r9
               	movq	(%r9), %r9
               	leaq	<rip>, %r14
               	addq	%r14, %rsi
               	movq	(%rsi), %r14
               	leaq	0x1e(%rax), %rsi
               	movslq	%esi, %rsi
               	movq	%r9, %r10
               	movq	0x48(%rsp), %r9
               	cmpq	%r10, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	cmpq	%r14, %r13
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edi
               	movq	%rdi, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r12, %r9
               	sarq	%cl, %r9
               	movq	%r13, %r10
               	movq	%r12, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	movq	%rcx, %r10
               	movq	%r15, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r13, %rcx
               	andq	%rdi, %rcx
               	movq	%r9, %r13
               	andq	%rsi, %r13
               	orq	%rcx, %r13
               	movq	%r9, %rcx
               	andq	%rdi, %rcx
               	andq	$-0x1, %rsi
               	movq	%rcx, %r9
               	orq	%rsi, %r9
               	leaq	<rip>, %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r14
               	addq	%r14, %rcx
               	movq	(%rcx), %r14
               	leaq	0x28(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rdi, %r13
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	%r14, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
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
               	movq	%r8, %rcx
               	cmpq	%r11, %r8
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rbx, %rcx
               	cmpq	%r11, %rbx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movq	%r8, %rcx
               	shlq	%rcx
               	movq	%rbx, %rax
               	shlq	%rax
               	movq	%r8, %rdx
               	shrq	$0x3f, %rdx
               	orq	%rax, %rdx
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movq	%r8, %rcx
               	shlq	$0x3f, %rcx
               	movq	%rbx, %rax
               	shlq	$0x3f, %rax
               	movq	%r8, %rdx
               	shrq	%rdx
               	orq	%rax, %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movq	%r8, %rax
               	cmpq	%r11, %r8
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
               	movq	%r8, %rcx
               	shlq	%rcx
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
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
               	movq	%r8, %rcx
               	shlq	$0x3f, %rcx
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
               	movq	%rbx, %rdx
               	shrq	%rdx
               	movq	%r8, %rax
               	shrq	%rax
               	movq	%rbx, %rcx
               	shlq	$0x3f, %rcx
               	orq	%rax, %rcx
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$0x444cd55de66ef77f, %r11 # imm = 0x444CD55DE66EF77F
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	movq	%rbx, %rcx
               	cmpq	%r11, %rbx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
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
               	movq	%rbx, %rcx
               	shrq	$0x3f, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
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
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rcx, %r9
               	shrq	$0x6, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	%r8, %rdi
               	shrq	%cl, %rdi
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	shlq	%r8
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r8, %rcx
               	andq	%rsi, %rcx
               	movq	%rdi, %r8
               	andq	%rdx, %r8
               	orq	%r8, %rcx
               	andq	%rdi, %rsi
               	andq	%rdx, %rax
               	movq	%rsi, %rdx
               	orq	%rax, %rdx
               	movq	0x38(%rsp), %r10
               	movq	(%r10), %rsi
               	cmpq	%rsi, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
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
               	jmp	<addr>
