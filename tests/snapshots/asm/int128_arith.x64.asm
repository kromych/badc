
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
               	leaq	<rip>, %r8
               	movq	(%r8), %rax
               	orq	%rsi, %rax
               	orq	%rsi, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	decq	%rdi
               	cmpq	$-0x1, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	addq	$0x0, %r9
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rsi, %rdi
               	leaq	(%r9), %rsi
               	subq	%rbx, %rsi
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	(%rax,%rax), %rsi
               	cmpq	%rax, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rcx,%rcx), %r9
               	addq	%r9, %rdi
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
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %r9
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rsi, %rbx
               	subq	%rax, %rbx
               	subq	%rcx, %r9
               	subq	%rdi, %r9
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rbx
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x4, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	xorl	%r9d, %r9d
               	testq	%rsi, %rsi
               	seta	%bl
               	movzbq	%bl, %rbx
               	movq	%r9, %r12
               	subq	%rsi, %r12
               	subq	%rbx, %r9
               	movq	$-0x1, %rsi
               	cmpq	%rsi, %r12
               	jne	<addr>
               	cmpq	%rsi, %r9
               	je	<addr>
               	movl	$0x5, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	movq	%rsi, %rbx
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
               	movl	$0x6, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
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
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	andq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	movq	%rcx, %rdi
               	andq	$-0x1, %rdi
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	shlq	$0x3f, %rsi
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	orq	%rcx, %rsi
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
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
               	movl	$0xa, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movq	%rax, %rbx
               	xorq	%rsi, %rbx
               	xorq	%rcx, %rsi
               	orq	%rbx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rdx), %rsi
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%esi, %esi
               	xorq	%rsi, %rdi
               	xorq	%rsi, %r9
               	orq	%r9, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdi
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
               	movl	$0xc, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%r8), %rsi
               	movq	(%rdx), %r9
               	leaq	(%rsi), %rdi
               	cmpq	%rsi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	$0x0, %r9
               	addq	%r9, %rsi
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xd, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movq	%rcx, %rdi
               	orq	%rsi, %rdi
               	movq	%rsi, %r8
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
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rdx), %rax
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
               	orq	%rsi, %rcx
               	movq	(%rdx), %rdx
               	shlq	$0x3f, %rdx
               	xorq	%rsi, %rax
               	xorq	%rdx, %rcx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xf, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
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
