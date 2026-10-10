
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rcx, %rsi
               	orq	%rax, %rsi
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x1, %r13d
               	leaq	<rip>, %rax      # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movl	(%rax), %edx
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rax, %r14
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rax, %rsi, %r12
               	shrxq	%r14, %rsi, %r14
               	shrq	%r14
               	shlxq	%rax, %rdi, %rax
               	orq	%r14, %rax
               	movq	%r12, %r14
               	andq	%rbx, %r14
               	andq	%rbx, %rax
               	andq	%r12, %r9
               	orq	%rax, %r9
               	leaq	<rip>, %rbx       # <addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12       # <addr>
               	addq	%r12, %rax
               	movq	(%rax), %r12
               	leaq	0x14(%rcx), %rax
               	cmpq	%rbx, %r14
               	jne	<addr>
               	cmpq	%r12, %r9
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rax, %r14
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rax, %rdi, %r12
               	shlxq	%r14, %rdi, %r14
               	shlq	%r14
               	shrxq	%rax, %rsi, %rax
               	orq	%r14, %rax
               	andq	%rbx, %rax
               	andq	%r12, %r9
               	orq	%rax, %r9
               	andq	%r12, %rbx
               	leaq	<rip>, %r12       # <addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	movq	(%r12), %r12
               	leaq	<rip>, %r14       # <addr>
               	addq	%r14, %rax
               	movq	(%rax), %r14
               	leaq	0x1e(%rcx), %rax
               	cmpq	%r12, %r9
               	jne	<addr>
               	cmpq	%r14, %rbx
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %edx
               	movq	%rdx, %r12
               	subq	%rax, %r12
               	movq	%r9, %rdx
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	sarxq	%rax, %r8, %rbx
               	shlxq	%r12, %r8, %r12
               	shlq	%r12
               	shrxq	%rax, %r13, %rax
               	orq	%r12, %rax
               	andq	%r9, %rax
               	movq	%rbx, %r12
               	andq	%rdx, %r12
               	orq	%rax, %r12
               	movq	%rbx, %rax
               	andq	%r9, %rax
               	orq	%rax, %rdx
               	leaq	<rip>, %r9        # <addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r9
               	movq	(%r9), %r9
               	leaq	<rip>, %rbx       # <addr>
               	addq	%rbx, %rax
               	movq	(%rax), %rbx
               	leaq	0x28(%rcx), %rax
               	cmpq	%r9, %r12
               	jne	<addr>
               	cmpq	%rbx, %rdx
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
               	popq	%rbp
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
               	popq	%rbp
               	retq
               	movq	%rsi, %rdx
               	shlq	$0x3f, %rdx
               	movq	%rdi, %rax
               	shlq	$0x3f, %rax
               	movq	%rsi, %r8
               	shrq	%r8
               	orq	%rax, %r8
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%r8, %rax
               	cmpq	%r11, %r8
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
               	movq	%rdi, %rax
               	shrq	%rax
               	movabsq	$-0x7ff76ee65dd54cc5, %r11 # imm = 0x80089119A22AB33B
               	movq	%r8, %rcx
               	cmpq	%r11, %r8
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
               	popq	%rbp
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
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx      # <addr>
               	movl	0xc(%rcx), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edi
               	movq	%rdi, %r9
               	subq	%rcx, %r9
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	shrxq	%rcx, %rsi, %r8
               	shlxq	%r9, %rsi, %rsi
               	shlq	%rsi
               	shrxq	%rcx, %rax, %rcx
               	orq	%rsi, %rcx
               	andq	%rdi, %rcx
               	andq	%r8, %rdx
               	orq	%rdx, %rcx
               	movq	%r8, %rdx
               	andq	%rdi, %rdx
               	leaq	<rip>, %rsi      # <addr>
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
