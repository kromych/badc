
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
               	subq	$0x30, %rsp
               	andq	$-0x10, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	leaq	<rip>, %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x20(%rbp), %r10
               	movq	(%r10), %rax
               	movq	%rdx, %rdi
               	orq	%rax, %rdi
               	movq	%rcx, %r9
               	orq	%rdx, %r9
               	movl	$0x1, %r15d
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
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
               	movl	$0x3f, %ebx
               	movq	%rbx, %r10
               	subq	%rsi, %r10
               	movq	%r10, -0x8(%rbp)
               	shrq	$0x6, %r8
               	xorq	%rbx, %rbx
               	movq	%r8, %r10
               	movq	%rbx, %r8
               	subq	%r10, %r8
               	movq	%r8, %r13
               	xorq	$-0x1, %r13
               	movq	%rdi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	movq	-0x8(%rbp), %r11
               	movq	%rdi, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, -0x8(%rbp)
               	movq	-0x8(%rbp), %r10
               	shrq	%r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	orq	-0x8(%rbp), %rsi
               	movq	%r14, %r10
               	andq	%r13, %r10
               	movq	%r10, -0x8(%rbp)
               	andq	%r8, %rbx
               	movq	-0x8(%rbp), %r10
               	orq	%rbx, %r10
               	movq	%r10, -0x8(%rbp)
               	andq	%r13, %rsi
               	andq	%r14, %r8
               	movq	%rsi, %r13
               	orq	%r8, %r13
               	leaq	<rip>, %rbx
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rbx
               	movq	(%rbx), %r14
               	leaq	<rip>, %rbx
               	addq	%rbx, %r8
               	movq	(%r8), %r10
               	movq	%r10, -0x10(%rbp)
               	leaq	0x14(%rax), %rbx
               	movslq	%ebx, %r8
               	movslq	%r8d, %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x8(%rbp), %r8
               	cmpq	%r14, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	-0x10(%rbp), %r13
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	-0x18(%rbp), %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %ebx
               	movq	%rbx, %r10
               	subq	%rsi, %r10
               	movq	%r10, -0x8(%rbp)
               	shrq	$0x6, %r8
               	xorq	%rbx, %rbx
               	movq	%r8, %r10
               	movq	%rbx, %r8
               	subq	%r10, %r8
               	movq	%r8, %r13
               	xorq	$-0x1, %r13
               	movq	%r9, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	movq	-0x8(%rbp), %r11
               	movq	%r9, %r10
               	pushq	%rcx
               	movq	%r11, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, -0x8(%rbp)
               	movq	-0x8(%rbp), %r10
               	shlq	%r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	-0x8(%rbp), %rsi
               	andq	%r13, %rsi
               	movq	%r14, %r10
               	andq	%r8, %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rsi, %r10
               	orq	-0x8(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%r14, %rsi
               	andq	%r13, %rsi
               	andq	%rbx, %r8
               	movq	%rsi, %r13
               	orq	%r8, %r13
               	leaq	<rip>, %rbx
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rbx
               	movq	(%rbx), %r14
               	leaq	<rip>, %rbx
               	addq	%rbx, %r8
               	movq	(%r8), %r10
               	movq	%r10, -0x10(%rbp)
               	leaq	0x1e(%rax), %rbx
               	movslq	%ebx, %r8
               	movslq	%r8d, %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x8(%rbp), %r8
               	cmpq	%r14, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	-0x10(%rbp), %r13
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	-0x18(%rbp), %rsi
               	movslq	%esi, %rsi
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
               	movq	%r12, %rbx
               	sarq	%cl, %rbx
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
               	andq	%r8, %rcx
               	movq	%rbx, %r13
               	andq	%rsi, %r13
               	orq	%rcx, %r13
               	movq	%rbx, %rcx
               	andq	%r8, %rcx
               	andq	$-0x1, %rsi
               	movq	%rcx, %rbx
               	orq	%rsi, %rbx
               	leaq	<rip>, %r8
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r8
               	movq	(%r8), %r14
               	leaq	<rip>, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	0x28(%rax), %r8
               	movslq	%r8d, %rsi
               	movslq	%esi, %r10
               	movq	%r10, -0x10(%rbp)
               	cmpq	%r14, %r13
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	-0x8(%rbp), %rbx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	-0x10(%rbp), %rcx
               	movslq	%ecx, %rcx
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
               	movq	%rdi, %rcx
               	cmpq	%r11, %rdi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rcx
               	cmpq	%r11, %r9
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movq	%r9, %rax
               	shlq	%rax
               	movq	%rdi, %rdx
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rdx
               	shrq	%rdx
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%r9, %rcx
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rcx
               	cmpq	%r11, %r9
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rcx
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
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
               	movq	%rdi, %r8
               	shrq	%cl, %r8
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	shlq	%rdi
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%rdi, %rcx
               	andq	%rsi, %rcx
               	movq	%r8, %rdi
               	andq	%rdx, %rdi
               	orq	%rdi, %rcx
               	andq	%r8, %rsi
               	andq	%rdx, %rax
               	movq	%rsi, %rdx
               	orq	%rax, %rdx
               	movq	-0x20(%rbp), %r10
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x50(%rbp), %rsp
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
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
