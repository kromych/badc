
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorl	%edx, %edx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	orq	%rdx, %rax
               	leaq	<rip>, %r8
               	movq	(%r8), %rsi
               	decq	%rsi
               	cmpq	$-0x1, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpl	$0x1, %r9d
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	movq	(%r8), %rdi
               	cmpq	%rdi, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rdi, %rsi
               	movq	%r9, %rdi
               	subq	%r8, %rdi
               	cmpq	$-0x1, %rsi
               	jne	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x2, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	(%rax,%rax), %rdx
               	cmpq	%rax, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rcx,%rcx), %rdi
               	addq	%rdi, %rsi
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %r9
               	subq	%rax, %r9
               	subq	%rcx, %rsi
               	subq	%r8, %rsi
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x4, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	movq	(%rdi), %rsi
               	testq	%rsi, %rsi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %r9
               	subq	%rsi, %r9
               	xorl	%edx, %edx
               	negq	%rdi
               	addq	%rdx, %rdi
               	movq	$-0x1, %rsi
               	cmpq	%rsi, %r9
               	jne	<addr>
               	cmpl	%esi, %edi
               	je	<addr>
               	movl	$0x5, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	subq	%rcx, %rdx
               	subq	%r8, %rdx
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x6, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x7, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rax, %rdx
               	andq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdx
               	shlq	$0x3f, %rdx
               	orq	%rcx, %rdx
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x9, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rax, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r8
               	xorq	%rcx, %r8
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xa, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%rsi), %r9
               	xorl	%edx, %edx
               	orq	%rdx, %r9
               	testq	%r9, %r9
               	je	<addr>
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	(%rsi), %rsi
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
               	movl	$0xc, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xd, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %r8
               	orq	%rax, %r8
               	leaq	(%rax,%rcx), %rsi
               	cmpq	%rax, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%r8, %rcx
               	addq	%rax, %rcx
               	movabsq	$-0x77553310eeccaa8a, %rax # imm = 0x88AACCEF11335576
               	cmpq	%rax, %rsi
               	jne	<addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rax, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rsi
               	movq	%rcx, %rax
               	subq	%r8, %rax
               	movq	%rsi, %rcx
               	andq	$-0x100, %rcx
               	orq	$0x5, %rcx
               	movq	(%rdi), %rsi
               	shlq	$0x3f, %rsi
               	xorq	%rsi, %rax
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	%rdx, %rax
               	retq
               	movq	%rdx, %rax
               	jmp	<addr>
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
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdx, %rdi
               	jmp	<addr>
