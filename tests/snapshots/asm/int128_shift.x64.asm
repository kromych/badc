
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
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorl	%eax, %eax
               	leaq	<rip>, %r15
               	movq	(%r15), %rdx
               	movq	%rax, %rsi
               	orq	%rdx, %rsi
               	movq	%rcx, %rdi
               	orq	%rax, %rdi
               	movl	$0x1, %r13d
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	cmpl	$0x6, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rdx, %r14
               	shrq	$0x6, %r9
               	xorl	%ebx, %ebx
               	movq	%r9, %r10
               	movq	%rbx, %r9
               	subq	%r10, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rsi, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	movq	%r14, %r10
               	movq	%rsi, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%r14, %rdx
               	movq	%r12, %r14
               	andq	%rbx, %r14
               	orq	$0x0, %r14
               	andq	%rbx, %rdx
               	andq	%r12, %r9
               	orq	%rdx, %r9
               	leaq	<rip>, %rbx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12
               	addq	%r12, %rdx
               	movq	(%rdx), %r12
               	leaq	0x14(%rax), %rdx
               	cmpq	%rbx, %r14
               	jne	<addr>
               	cmpq	%r12, %r9
               	je	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rdx, %r14
               	shrq	$0x6, %r9
               	xorl	%ebx, %ebx
               	movq	%r9, %r10
               	movq	%rbx, %r9
               	subq	%r10, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rdi, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r12
               	popq	%rcx
               	movq	%r14, %r10
               	movq	%rdi, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	shlq	%r14
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%r14, %rdx
               	andq	%rbx, %rdx
               	andq	%r12, %r9
               	orq	%rdx, %r9
               	movq	%r12, %rdx
               	andq	%rbx, %rdx
               	movq	%rdx, %rbx
               	orq	$0x0, %rbx
               	leaq	<rip>, %r12
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r12
               	movq	(%r12), %r12
               	leaq	<rip>, %r14
               	addq	%r14, %rdx
               	movq	(%rdx), %r14
               	leaq	0x1e(%rax), %rdx
               	cmpq	%r12, %r9
               	jne	<addr>
               	cmpq	%r14, %rbx
               	je	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %rdx
               	xorl	%r9d, %r9d
               	movq	%rdx, %r10
               	movq	%r9, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	movq	%r8, %rbx
               	sarq	%cl, %rbx
               	movq	%r12, %r10
               	movq	%r8, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	movq	%rcx, %r10
               	movq	%r13, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r12, %rcx
               	andq	%r9, %rcx
               	movq	%rbx, %r12
               	andq	%rdx, %r12
               	orq	%rcx, %r12
               	movq	%rbx, %rcx
               	andq	%r9, %rcx
               	andq	$-0x1, %rdx
               	orq	%rcx, %rdx
               	leaq	<rip>, %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	movq	(%r9), %r9
               	leaq	<rip>, %rbx
               	addq	%rbx, %rcx
               	movq	(%rcx), %rbx
               	leaq	0x28(%rax), %rcx
               	cmpq	%r9, %r12
               	jne	<addr>
               	cmpq	%rbx, %rdx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rsi, %rcx
               	shlq	%rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	movq	%rsi, %rdx
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
               	popq	%r15
               	leave
               	retq
               	movq	%rsi, %rdx
               	shlq	$0x3f, %rdx
               	movq	%rdi, %r8
               	shlq	$0x3f, %r8
               	movq	%rsi, %r9
               	shrq	%r9
               	movq	%r8, %rax
               	orq	%r9, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdx, %rbx
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
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
               	popq	%r15
               	leave
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
               	popq	%r15
               	leave
               	retq
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%r9, %rcx
               	orq	%r8, %rcx
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	cmpq	%r11, %rcx
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
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rdi, %rax
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
               	popq	%r15
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rax
               	movl	$0x3f, %edi
               	movq	%rdi, %r9
               	subq	%rax, %r9
               	shrq	$0x6, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rsi, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	shlq	%rsi
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	orq	%rsi, %rax
               	andq	%rdi, %rax
               	movq	%r8, %rcx
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%r8, %rax
               	andq	%rdi, %rax
               	orq	$0x0, %rax
               	movq	(%r15), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
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
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
