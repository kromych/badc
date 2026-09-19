
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
               	leaq	<rip>, %r9
               	movq	(%r9), %rsi
               	decq	%rsi
               	cmpq	$-0x1, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpl	$0x1, %r8d
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	movq	(%r9), %rdi
               	cmpq	%rdi, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	negq	%rdi
               	addq	%rsi, %rdi
               	movq	%r8, %rsi
               	subq	%r9, %rsi
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	testl	%esi, %esi
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
               	movq	(%rdi), %rdx
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	subq	%rcx, %rdx
               	subq	%r8, %rdx
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %r9
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	(%rdi), %rdx
               	testq	%rdx, %rdx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rsi, %r9
               	subq	%rdx, %r9
               	xorl	%esi, %esi
               	negq	%rdi
               	addq	%rsi, %rdi
               	movq	$-0x1, %rdx
               	cmpq	%rdx, %r9
               	jne	<addr>
               	cmpl	%edx, %edi
               	je	<addr>
               	movl	$0x5, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	subq	%rcx, %rsi
               	subq	%r8, %rsi
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
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
               	leaq	<rip>, %r8
               	movq	(%r8), %rdx
               	shlq	$0x3f, %rdx
               	orq	%rcx, %rdx
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rax, %rsi
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
               	movq	%rax, %rsi
               	xorq	%rax, %rsi
               	movq	%rcx, %rdi
               	xorq	%rcx, %rdi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdi, %rdi
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
               	movq	(%r8), %rdx
               	xorl	%r9d, %r9d
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rsi, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	(%r8), %rdx
               	addq	%rax, %rdx
               	cmpq	%rax, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%rcx, %rsi
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0xc, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r8
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdx
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %r8
               	jne	<addr>
               	cmpq	$0x1, %rdx
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
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rsi
               	movq	%rcx, %rax
               	subq	%r9, %rax
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
               	movl	$0xf, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	xorl	%eax, %eax
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
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdx, %rdi
               	jmp	<addr>
