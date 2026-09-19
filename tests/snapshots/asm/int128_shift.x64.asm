
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %r8
               	xorl	%edx, %edx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rdx, %rdi
               	orq	%rax, %rdi
               	movabsq	$-0x8000000000000000, %r9 # imm = 0x8000000000000000
               	movl	$0x1, %r13d
               	leaq	<rip>, %rax
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	(%rax), %rsi
               	movq	%rsi, %rax
               	andq	$0x7f, %rax
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rcx, %r14
               	shrq	$0x6, %rax
               	xorl	%ebx, %ebx
               	negq	%rax
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rdi, %r12
               	shlq	%cl, %r12
               	movq	%r14, %r10
               	movq	%rdi, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rcx, %r10
               	movq	%r8, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r14, %rcx
               	movq	%r12, %r14
               	andq	%rbx, %r14
               	andq	%rbx, %rcx
               	andq	%r12, %rax
               	orq	%rax, %rcx
               	leaq	<rip>, %rbx
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12
               	addq	%r12, %rax
               	movq	(%rax), %r12
               	leaq	0x14(%rdx), %rax
               	cmpq	%rbx, %r14
               	jne	<addr>
               	cmpq	%r12, %rcx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0x7f, %rax
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rcx, %r14
               	shrq	$0x6, %rax
               	xorl	%ebx, %ebx
               	negq	%rax
               	addq	%rbx, %rax
               	movq	%rax, %rbx
               	xorq	$-0x1, %rbx
               	movq	%r8, %r12
               	shrq	%cl, %r12
               	movq	%r14, %r10
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	shlq	%r14
               	movq	%rcx, %r10
               	movq	%rdi, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r14, %rcx
               	andq	%rbx, %rcx
               	andq	%r12, %rax
               	orq	%rax, %rcx
               	andq	%r12, %rbx
               	leaq	<rip>, %r12
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	movq	(%r12), %r12
               	leaq	<rip>, %r14
               	addq	%r14, %rax
               	movq	(%rax), %r14
               	leaq	0x1e(%rdx), %rax
               	cmpq	%r12, %rcx
               	jne	<addr>
               	cmpq	%r14, %rbx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0x7f, %rax
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %esi
               	movq	%rsi, %r12
               	subq	%rcx, %r12
               	movq	%rax, %rsi
               	shrq	$0x6, %rsi
               	xorl	%eax, %eax
               	subq	%rsi, %rax
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%r9, %rbx
               	sarq	%cl, %rbx
               	movq	%r12, %r10
               	movq	%r9, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	movq	%rcx, %r10
               	movq	%r13, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r12, %rcx
               	andq	%rsi, %rcx
               	movq	%rbx, %r12
               	andq	%rax, %r12
               	orq	%r12, %rcx
               	andq	%rbx, %rsi
               	orq	%rax, %rsi
               	leaq	<rip>, %rbx
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12
               	addq	%r12, %rax
               	movq	(%rax), %r12
               	leaq	0x28(%rdx), %rax
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	cmpq	%r12, %rsi
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x6, %edx
               	jl	<addr>
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movq	%r8, %rax
               	shlq	%rax
               	movq	%rdi, %rdx
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rax
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%rdi, %rdx
               	shlq	$0x3f, %rdx
               	movq	%r8, %rax
               	shlq	$0x3f, %rax
               	movq	%rdi, %rsi
               	shrq	%rsi
               	orq	%rax, %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%r8, %rax
               	shrq	%rax
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0x444cd55de66ef77f, %r11 # imm = 0x444CD55DE66EF77F
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%r8, %rax
               	shrq	$0x3f, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rcx, %r9
               	movq	%rdx, %rsi
               	shrq	$0x6, %rsi
               	movq	%rax, %rdx
               	subq	%rsi, %rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdi, %r8
               	shrq	%cl, %r8
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	shlq	%rdi
               	movq	%rax, %r9
               	shrq	%cl, %r9
               	movq	%r9, %rcx
               	orq	%rdi, %rcx
               	andq	%rsi, %rcx
               	andq	%r8, %rdx
               	orq	%rdx, %rcx
               	movq	%r8, %rdx
               	andq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
