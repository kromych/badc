
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
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %r8 # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %rdi # <addr>
               	orq	%rcx, %rdi
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	movl	$0x1, %r15d
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movl	(%rax), %edx
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	subq	%rax, %rsi
               	shrq	$0x6, %r9
               	movq	%r9, %rbx
               	negq	%rbx
               	movq	%rbx, %r13
               	xorq	$-0x1, %r13
               	shlxq	%rax, %rdi, %r9
               	shrxq	%rsi, %rdi, %r14
               	shrq	%r14
               	shlxq	%rax, %r8, %rsi
               	orq	%r14, %rsi
               	movq	%r9, %r14
               	andq	%r13, %r14
               	andq	%r13, %rsi
               	andq	%rbx, %r9
               	orq	%r9, %rsi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r9
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rbx
               	leaq	0x14(%rcx), %rax
               	cmpq	%r9, %r14
               	jne	<addr>
               	cmpq	%rbx, %rsi
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	subq	%rax, %rsi
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %r13
               	xorq	$-0x1, %r13
               	shrxq	%rax, %r8, %rbx
               	shlxq	%rsi, %r8, %r14
               	shlq	%r14
               	shrxq	%rax, %rdi, %rsi
               	orq	%r14, %rsi
               	andq	%r13, %rsi
               	andq	%rbx, %r9
               	orq	%r9, %rsi
               	andq	%r13, %rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r9
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r13
               	leaq	0x1e(%rcx), %rax
               	nopw	(%rax,%rax)
               	cmpq	%r9, %rsi
               	jne	<addr>
               	cmpq	%r13, %rbx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %edx
               	subq	%rax, %rdx
               	shrq	$0x6, %rsi
               	movq	%rsi, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	sarxq	%rax, %r12, %rsi
               	shlxq	%rdx, %r12, %r13
               	shlq	%r13
               	shrxq	%rax, %r15, %rdx
               	orq	%r13, %rdx
               	andq	%rbx, %rdx
               	movq	%rsi, %rax
               	andq	%r9, %rax
               	orq	%rax, %rdx
               	andq	%rbx, %rsi
               	orq	%r9, %rsi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %r9
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rbx
               	leaq	0x28(%rcx), %rax
               	nop
               	cmpq	%r9, %rdx
               	jne	<addr>
               	cmpq	%rbx, %rsi
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
               	incq	%rcx
               	cmpl	$0x6, %ecx
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
               	popq	%r15
               	retq
               	movq	%rdi, %rdx
               	shlq	%rdx
               	movq	%r8, %rax
               	shlq	%rax
               	movq	%rdi, %rcx
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
               	popq	%r15
               	retq
               	movq	%rdi, %rsi
               	shlq	$0x3f, %rsi
               	movq	%r8, %rcx
               	shlq	$0x3f, %rcx
               	movq	%rdi, %rax
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
               	popq	%r15
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
               	popq	%r15
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
               	popq	%r15
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
               	popq	%r15
               	retq
               	movq	%r8, %rdx
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
               	popq	%r15
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
               	popq	%r15
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
               	popq	%r15
               	retq
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r8d
               	subq	%rcx, %r8
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	shrxq	%rcx, %rdi, %rsi
               	shlxq	%r8, %rdi, %rdi
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
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
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
               	popq	%r15
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	retq
