
int128_arith.x64:	file format elf64-x86-64

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
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorl	%edx, %edx
               	leaq	<rip>, %r8
               	movq	(%r8), %rax
               	orq	%rdx, %rax
               	orq	%rdx, %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	decq	%rdi
               	cmpq	$-0x1, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	addq	$0x0, %r9
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpl	$0x1, %r9d
               	je	<addr>
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rsi), %rdx
               	cmpq	%rdx, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rdx, %rdi
               	leaq	(%r9), %rdx
               	subq	%rbx, %rdx
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	(%rax,%rax), %rdx
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rcx,%rcx), %r9
               	addq	%r9, %rdi
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x3, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rsi), %r9
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rbx
               	subq	%rax, %rbx
               	subq	%rcx, %r9
               	subq	%rdi, %r9
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rbx
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x4, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rsi), %rdx
               	xorl	%r9d, %r9d
               	testq	%rdx, %rdx
               	seta	%bl
               	movzbq	%bl, %rbx
               	movq	%r9, %r12
               	subq	%rdx, %r12
               	subq	%rbx, %r9
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %r12
               	jne	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x5, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %r9
               	subq	%rax, %r9
               	movq	%rdx, %rbx
               	subq	%rcx, %rbx
               	movq	%rdi, %r10
               	movq	%rbx, %rdi
               	subq	%r10, %rdi
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x6, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x7, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	andq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	movq	%rcx, %rdi
               	andq	$-0x1, %rdi
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rsi), %rdx
               	shlq	$0x3f, %rdx
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	orq	%rcx, %rdx
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x9, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r9
               	xorq	%rcx, %r9
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0xa, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%edx, %edx
               	movq	%rax, %rbx
               	xorq	%rdx, %rbx
               	xorq	%rcx, %rdx
               	orq	%rbx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%rsi), %rdx
               	xorq	$0x0, %rdx
               	orq	$0x0, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%edx, %edx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %r9
               	orq	%r9, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rsi), %rdi
               	addq	%rax, %rdi
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	leaq	(%rcx), %rbx
               	addq	%rbx, %r9
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0xc, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%r8), %rdx
               	movq	(%rsi), %r9
               	leaq	(%rdx), %rdi
               	cmpq	%rdx, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	$0x0, %r9
               	addq	%r9, %rdx
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xd, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%edx, %edx
               	movq	%rcx, %rdi
               	orq	%rdx, %rdi
               	movq	%rdx, %r8
               	orq	%rax, %r8
               	addq	%rax, %rdi
               	cmpq	%rax, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%r8, %rcx
               	addq	%rax, %rcx
               	movabsq	$-0x77553310eeccaa8a, %rax # imm = 0x88AACCEF11335576
               	cmpq	%rax, %rdi
               	jne	<addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rsi), %rax
               	cmpq	%rax, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	subq	$0x0, %rcx
               	subq	%r8, %rcx
               	andq	$-0x100, %rax
               	andq	$-0x1, %rcx
               	orq	$0x5, %rax
               	orq	%rdx, %rcx
               	movq	(%rsi), %rsi
               	shlq	$0x3f, %rsi
               	xorq	%rdx, %rax
               	xorq	%rsi, %rcx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xf, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
