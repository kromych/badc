
int128_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %r9 # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %r8 # <addr>
               	orq	%rcx, %r8
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movl	$0x1, %r14d
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movl	(%rax), %esi
               	movq	%rsi, %r10
               	andq	$0x7f, %r10
               	movq	%rsi, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %edx
               	subq	%rax, %rdx
               	movq	%r10, %rdi
               	shrq	$0x6, %rdi
               	movq	%rdi, %rbx
               	negq	%rbx
               	movq	%rbx, %r12
               	xorq	$-0x1, %r12
               	shlxq	%rax, %r8, %rdi
               	shrxq	%rdx, %r8, %r13
               	shrq	%r13
               	shlxq	%rax, %r9, %rdx
               	orq	%r13, %rdx
               	movq	%rdi, %r13
               	andq	%r12, %r13
               	andq	%r12, %rdx
               	andq	%rbx, %rdi
               	orq	%rdi, %rdx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rbx
               	leaq	0x14(%rcx), %rax
               	cmpq	%rdi, %r13
               	jne	<addr>
               	cmpq	%rbx, %rdx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	subq	%rdx, %rdi
               	movq	%r10, %rax
               	shrq	$0x6, %rax
               	negq	%rax
               	movq	%rax, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rdx, %r9, %r10
               	shlxq	%rdi, %r9, %r12
               	shlq	%r12
               	shrxq	%rdx, %r8, %rdi
               	orq	%r12, %rdi
               	andq	%rbx, %rdi
               	andq	%r10, %rax
               	orq	%rax, %rdi
               	andq	%rbx, %r10
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r12
               	leaq	0x1e(%rcx), %rax
               	nopw	(%rax,%rax)
               	cmpq	%rbx, %rdi
               	jne	<addr>
               	cmpq	%r12, %r10
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0x7f, %rax
               	movl	$0x3f, %edi
               	subq	%rdx, %rdi
               	shrq	$0x6, %rax
               	negq	%rax
               	movq	%rax, %r10
               	xorq	$-0x1, %r10
               	sarxq	%rdx, %r11, %rsi
               	shlxq	%rdi, %r11, %rdi
               	shlq	%rdi
               	shrxq	%rdx, %r14, %rdx
               	orq	%rdi, %rdx
               	andq	%r10, %rdx
               	movq	%rsi, %rdi
               	andq	%rax, %rdi
               	orq	%rdi, %rdx
               	andq	%r10, %rsi
               	orq	%rax, %rsi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r10
               	leaq	0x28(%rcx), %rax
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	nopw	(%rax,%rax)
               	cmpq	%r10, %rsi
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	nopl	(%rax)
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x6, %ecx
               	jl	<addr>
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movq	%r8, %rdx
               	shlq	%rdx
               	movq	%r9, %rax
               	shlq	%rax
               	movq	%r8, %rcx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rax
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
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
               	retq
               	movq	%r8, %rsi
               	shlq	$0x3f, %rsi
               	movq	%r9, %rcx
               	shlq	$0x3f, %rcx
               	movq	%r8, %rax
               	shrq	%rax
               	orq	%rax, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movq	%r9, %rdx
               	shrq	%rdx
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0x444cd55de66ef77f, %r11 # imm = 0x444CD55DE66EF77F
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movq	%r9, %rax
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
               	retq
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edi
               	subq	%rcx, %rdi
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	shrxq	%rcx, %r8, %rsi
               	shlxq	%rdi, %r8, %rdi
               	shlq	%rdi
               	shrxq	%rcx, %rax, %rcx
               	orq	%rdi, %rcx
               	andq	%r9, %rcx
               	andq	%rsi, %rdx
               	orq	%rdx, %rcx
               	andq	%r9, %rsi
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xd, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	movq	%rax, %rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq
