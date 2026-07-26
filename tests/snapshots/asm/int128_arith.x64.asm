
int128_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	andq	$-0x10, %rsp
               	subq	$0x60, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorq	%rcx, %rcx
               	leaq	<rip>, %r9
               	movq	(%r9), %rax
               	orq	%rcx, %rax
               	orq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	-0x1(%rsi), %rdi
               	cmpq	$-0x1, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rsi), %rbx
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	$0x1, %rbx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rsi, %rdi
               	leaq	(%rbx), %rsi
               	movq	%r8, %r10
               	movq	%rsi, %r8
               	subq	%r10, %r8
               	cmpq	$-0x1, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r8, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rax,%rax), %rdi
               	cmpq	%rax, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rcx,%rcx), %r8
               	addq	%rsi, %r8
               	movabsq	$0x22446688aaccee, %r11 # imm = 0x22446688AACCEE
               	cmpq	%r11, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x3, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdi
               	xorq	%r8, %r8
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	subq	%rax, %r8
               	subq	%rcx, %rdi
               	movq	%rdi, %rbx
               	subq	%rsi, %rbx
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x4, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdi
               	xorq	%r8, %r8
               	testq	%rdi, %rdi
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r10
               	movq	%r8, %rdi
               	subq	%r10, %rdi
               	xorq	%r8, %r8
               	movq	%r8, %rbx
               	subq	%rsi, %rbx
               	movabsq	$-0x1, %r8
               	cmpq	%r8, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	%r8, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x5, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	subq	%rcx, %rdi
               	movq	%rdi, %rbx
               	subq	%rsi, %rbx
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x6, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rcx, %r8
               	xorq	$-0x1, %r8
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	andq	$-0x10000, %rdi         # imm = 0xFFFF0000
               	movq	%rcx, %r8
               	andq	$-0x1, %r8
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x8, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdi
               	shlq	$0x3f, %rdi
               	movq	%rax, %r8
               	orq	$0x0, %r8
               	movq	%rcx, %rbx
               	orq	%rdi, %rbx
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rbx, %rdi
               	cmpq	%r11, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r8
               	xorq	%rcx, %r8
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r8, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xa, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rax, %rdi
               	xorq	%rsi, %rdi
               	xorq	%rcx, %rsi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movl	$0x1, %esi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	(%rdx), %rdi
               	movq	%rdi, %rsi
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rax, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r8
               	xorq	%rcx, %r8
               	xorq	%rsi, %rsi
               	xorq	%rsi, %rdi
               	xorq	%r8, %rsi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	leaq	(%rax,%rsi), %rdi
               	cmpq	%rax, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rcx), %r8
               	addq	%rsi, %r8
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%r9), %rdi
               	movq	(%rdx), %rbx
               	leaq	(%rdi), %r8
               	cmpq	%rdi, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	leaq	(%rbx), %rdi
               	leaq	(%rdi,%rsi), %rbx
               	movq	(%r9), %rdi
               	cmpq	%rdi, %r8
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0x1, %rbx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xd, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rcx, %r8
               	orq	%rdi, %r8
               	orq	%rax, %rdi
               	leaq	(%rax,%r8), %rsi
               	cmpq	%rax, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rdi, %rcx
               	leaq	(%rcx,%rax), %rdi
               	movabsq	$-0x77553310eeccaa8a, %r8 # imm = 0x88AACCEF11335576
               	cmpq	%r8, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	%r8, %rdi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rax
               	xorq	%rcx, %rcx
               	cmpq	%rax, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rsi
               	leaq	(%rdi), %rax
               	movq	%rax, %rdi
               	subq	%r8, %rdi
               	andq	$-0x100, %rsi
               	andq	$-0x1, %rdi
               	orq	$0x5, %rsi
               	orq	%rcx, %rdi
               	movq	(%rdx), %rdx
               	shlq	$0x3f, %rdx
               	xorq	%rsi, %rcx
               	xorq	%rdi, %rdx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	jmp	<addr>
