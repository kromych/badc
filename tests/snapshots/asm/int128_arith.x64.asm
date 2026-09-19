
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
               	xorl	%esi, %esi
               	leaq	<rip>, %r9
               	movq	(%r9), %rax
               	orq	%rsi, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	decq	%rdi
               	cmpq	$-0x1, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpl	$0x1, %r8d
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rsi, %rdi
               	movq	%r8, %rsi
               	subq	%rbx, %rsi
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x2, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	(%rax,%rax), %rsi
               	cmpq	%rax, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rcx,%rcx), %r8
               	addq	%r8, %rdi
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x3, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %r8
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rsi, %rbx
               	subq	%rax, %rbx
               	subq	%rcx, %r8
               	subq	%rdi, %r8
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rbx
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x4, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	xorl	%r8d, %r8d
               	testq	%rsi, %rsi
               	seta	%bl
               	movzbq	%bl, %rbx
               	movq	%r8, %r12
               	subq	%rsi, %r12
               	subq	%rbx, %r8
               	movq	$-0x1, %rsi
               	cmpq	%rsi, %r12
               	jne	<addr>
               	cmpl	%esi, %r8d
               	je	<addr>
               	movl	$0x5, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movq	%rsi, %rbx
               	subq	%rcx, %rbx
               	negq	%rdi
               	addq	%rbx, %rdi
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %r8
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x6, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x7, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	andq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	shlq	$0x3f, %rsi
               	orq	%rcx, %rsi
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r8
               	xorq	%rcx, %r8
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xa, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rdx), %rsi
               	xorl	%ebx, %ebx
               	orq	%rbx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdi, %rsi
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	addq	%rax, %rsi
               	cmpq	%rax, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	%rcx, %rdi
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0xc, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%r9), %rdi
               	movq	(%rdx), %rsi
               	movq	(%r9), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xd, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, %r8
               	orq	%rax, %r8
               	leaq	(%rax,%rcx), %rdi
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
               	movq	(%rdx), %rax
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rdi
               	movq	%rcx, %rax
               	subq	%r9, %rax
               	movq	%rdi, %rcx
               	andq	$-0x100, %rcx
               	orq	$0x5, %rcx
               	movq	(%rdx), %rdx
               	shlq	$0x3f, %rdx
               	xorq	%rdx, %rax
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rsi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
