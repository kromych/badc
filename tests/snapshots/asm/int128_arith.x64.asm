
int128_arith.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	orq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	decq	%rdx
               	cmpq	$-0x1, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x1, %r8d
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rdi, %rdx
               	movq	%r8, %rdi
               	subq	%r9, %rdi
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x2, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	leaq	(%rcx,%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rsi,%rsi), %r8
               	addq	%r8, %rdi
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rcx, %rcx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rcx, %rdi
               	negq	%rdi
               	subq	%rsi, %rax
               	subq	%rdx, %rax
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %r9
               	negq	%r9
               	movq	%r8, %r10
               	negq	%r10
               	movq	$-0x1, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	cmpl	%eax, %r10d
               	je	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	%rsi, %rax
               	negq	%rax
               	subq	%rdx, %rax
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
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
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
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
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rax # <addr>
               	shlq	$0x3f, %rax
               	orq	%rsi, %rax
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rcx, %rdx
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
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	orq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rcx, %rdx
               	cmpq	%rcx, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	%rsi, %rdi
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0xc, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	cmpq	%r8, %rdx
               	jne	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0xd, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rax, %rdi
               	orq	%rcx, %rdi
               	leaq	(%rcx,%rsi), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
               	movabsq	$-0x77553310eeccaa8a, %rsi # imm = 0x88AACCEF11335576
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rax
               	subq	%rsi, %rax
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	andq	$-0x100, %rax
               	orq	$0x5, %rax
               	movq	<rip>, %rcx # <addr>
               	shlq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
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
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
