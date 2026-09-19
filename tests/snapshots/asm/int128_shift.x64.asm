
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
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	leaq	<rip>, %r15
               	movq	(%r15), %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x1, %r14d
               	cmpl	$0x6, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movslq	(%rcx), %rdx
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %r9
               	xorl	%ebx, %ebx
               	negq	%r9
               	addq	%rbx, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rsi, %r12
               	shlq	%cl, %r12
               	movq	%r13, %r10
               	movq	%rsi, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	shrq	%r13
               	movq	%rcx, %r10
               	movq	%rdi, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r13, %rcx
               	movq	%r12, %r13
               	andq	%rbx, %r13
               	andq	%rbx, %rcx
               	andq	%r12, %r9
               	orq	%rcx, %r9
               	leaq	<rip>, %rbx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12
               	addq	%r12, %rcx
               	movq	(%rcx), %r12
               	leaq	0x14(%rax), %rcx
               	cmpq	%rbx, %r13
               	jne	<addr>
               	cmpq	%r12, %r9
               	je	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %r9
               	xorl	%ebx, %ebx
               	negq	%r9
               	addq	%rbx, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rdi, %r12
               	shrq	%cl, %r12
               	movq	%r13, %r10
               	movq	%rdi, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	movq	%rcx, %r10
               	movq	%rsi, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r13, %rcx
               	andq	%rbx, %rcx
               	andq	%r12, %r9
               	movq	%rcx, %r13
               	orq	%r9, %r13
               	movq	%r12, %r9
               	andq	%rbx, %r9
               	leaq	<rip>, %rbx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12
               	addq	%r12, %rcx
               	movq	(%rcx), %r12
               	leaq	0x1e(%rax), %rcx
               	cmpq	%rbx, %r13
               	jne	<addr>
               	cmpq	%r12, %r9
               	je	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edx
               	movq	%rdx, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %r9
               	xorl	%edx, %edx
               	subq	%r9, %rdx
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
               	movq	%r14, %r11
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
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edi
               	movq	%rdi, %r9
               	subq	%rcx, %r9
               	movq	%rdx, %rdi
               	shrq	$0x6, %rdi
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rsi, %r8
               	shrq	%cl, %r8
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	shlq	%rsi
               	shrq	%cl, %rax
               	orq	%rsi, %rax
               	andq	%rdi, %rax
               	movq	%r8, %rcx
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%r8, %rax
               	andq	%rdi, %rax
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
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
