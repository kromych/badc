
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
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rdi # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %rsi # <addr>
               	orq	%rcx, %rsi
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x1, %r10d
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	movl	(%rax), %edx
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %ebx
               	movq	%rbx, %r10
               	subq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rax, %rsi, %r12
               	movq	0x10(%rsp), %r11
               	shrxq	%r11, %rsi, %r10
               	movq	%r10, 0x10(%rsp)
               	shrq	%r10
               	movq	%r10, 0x10(%rsp)
               	shlxq	%rax, %rdi, %rax
               	orq	0x10(%rsp), %rax
               	movq	%r12, %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x10(%rsp)
               	andq	%rbx, %rax
               	andq	%r12, %r9
               	orq	%rax, %r9
               	leaq	<rip>, %rbx # <addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %r12 # <addr>
               	addq	%r12, %rax
               	movq	(%rax), %r12
               	leaq	0x14(%rcx), %rax
               	movq	%rbx, %r10
               	movq	0x10(%rsp), %rbx
               	cmpq	%r10, %rbx
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
               	movq	%rbx, %r10
               	subq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rax, %rdi, %r12
               	movq	0x10(%rsp), %r11
               	shlxq	%r11, %rdi, %r10
               	movq	%r10, 0x10(%rsp)
               	shlq	%r10
               	movq	%r10, 0x10(%rsp)
               	shrxq	%rax, %rsi, %rax
               	orq	0x10(%rsp), %rax
               	andq	%rbx, %rax
               	andq	%r12, %r9
               	orq	%rax, %r9
               	andq	%r12, %rbx
               	leaq	<rip>, %r12 # <addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	movq	(%r12), %r12
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x10(%rsp)
               	movq	%rax, %r10
               	movq	0x10(%rsp), %rax
               	addq	%r10, %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	0x1e(%rcx), %rax
               	cmpq	%r12, %r9
               	jne	<addr>
               	cmpq	0x10(%rsp), %rbx
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
               	shrq	$0x6, %r9
               	movq	%r9, %rdx
               	negq	%rdx
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	sarxq	%rax, %r8, %rbx
               	shlxq	%r12, %r8, %r12
               	shlq	%r12
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	shrxq	%r10, %rax, %rax
               	orq	%r12, %rax
               	andq	%r9, %rax
               	movq	%rbx, %r12
               	andq	%rdx, %r12
               	orq	%rax, %r12
               	andq	%rbx, %r9
               	orq	%r9, %rdx
               	leaq	<rip>, %r9 # <addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r9
               	movq	(%r9), %r9
               	leaq	<rip>, %rbx # <addr>
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
               	leave
               	retq
               	movq	%rsi, %rdx
               	shlq	$0x3f, %rdx
               	movq	%rdi, %r8
               	shlq	$0x3f, %r8
               	movq	%rsi, %rax
               	shrq	%rax
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
               	leave
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
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
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
               	andq	%r8, %rdi
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
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
               	leave
               	retq
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
