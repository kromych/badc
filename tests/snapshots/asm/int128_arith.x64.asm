
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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	orq	%rax, %rcx
               	leaq	<rip>, %r8 # <addr>
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
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	leaq	(%rcx,%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rdx,%rdx), %rdi
               	addq	%rdi, %rsi
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi), %rax
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %r8
               	negq	%r8
               	subq	%rdx, %rax
               	subq	%rdi, %rax
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%r8, %r9
               	cmpq	%r11, %r8
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	(%rsi), %rax
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %r9
               	negq	%r9
               	negq	%rsi
               	movq	$-0x1, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	%rdx, %rax
               	negq	%rax
               	subq	%rdi, %rax
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%r8, %rsi
               	cmpq	%r11, %r8
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x7, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	%rcx, %rax
               	andq	$-0x10000, %rax         # imm = 0xFFFF0000
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi), %rax
               	shlq	$0x3f, %rax
               	orq	%rdx, %rax
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsi), %rdi
               	xorl	%eax, %eax
               	orq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	(%rsi), %rdi
               	addq	%rcx, %rdi
               	cmpq	%rcx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	addq	%rdx, %r8
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0xc, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi), %r8
               	movq	(%rsi), %rsi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %r8
               	jne	<addr>
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	orq	%rcx, %rdi
               	leaq	(%rcx,%rdx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdi, %rdx
               	addq	%rcx, %rdx
               	movabsq	$-0x77553310eeccaa8a, %rcx # imm = 0x88AACCEF11335576
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xe, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdi
               	cmpq	%rdi, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rdi, %rsi
               	subq	%r8, %rdx
               	andq	$-0x100, %rsi
               	orq	$0x5, %rsi
               	movq	(%rcx), %rcx
               	shlq	$0x3f, %rcx
               	xorq	%rdx, %rcx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xf, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xb, %eax
               	retq
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
               	movq	%rax, %rdi
               	jmp	<addr>
