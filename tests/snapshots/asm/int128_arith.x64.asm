
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorq	%rsi, %rsi
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
               	leaq	(%r9), %rbx
               	testq	%rdi, %rdi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0x1, %rbx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	leaq	(%rbx), %rdi
               	subq	%r9, %rdi
               	cmpq	$-0x1, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
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
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$0x1133557799bbddfe, %r11 # imm = 0x1133557799BBDDFE
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rbx
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	subq	%rcx, %rbx
               	subq	%r9, %rbx
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rdi
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
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	xorq	%rdi, %rdi
               	testq	%rsi, %rsi
               	seta	%bl
               	movzbq	%bl, %rbx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	subq	%r10, %rsi
               	movq	%rbx, %r10
               	movq	%rdi, %rbx
               	subq	%r10, %rbx
               	movabsq	$-0x1, %rdi
               	cmpq	%rdi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	%rdi, %rbx
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x5, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	%rsi, %rbx
               	subq	%rcx, %rbx
               	movq	%r9, %r10
               	movq	%rbx, %r9
               	subq	%r10, %r9
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	cmpq	%r11, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%r9, %rdi
               	cmpq	%r11, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x6, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$-0x11223344556678, %r11 # imm = 0xFFEEDDCCBBAA9988
               	cmpq	%r11, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$0x7766554433221100, %r11 # imm = 0x7766554433221100
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x7, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	andq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	movq	%rcx, %rdi
               	andq	$-0x1, %rdi
               	movabsq	$0x11223344550000, %r11 # imm = 0x11223344550000
               	cmpq	%r11, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x8, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	shlq	$0x3f, %rsi
               	movq	%rax, %rdi
               	orq	$0x0, %rdi
               	movq	%rcx, %r9
               	orq	%rsi, %r9
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%r9, %rsi
               	cmpq	%r11, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	xorq	%rax, %rdi
               	movq	%rcx, %r9
               	xorq	%rcx, %r9
               	testq	%rdi, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	jne	<addr>
               	testq	%r9, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xa, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rax, %rbx
               	xorq	%rsi, %rbx
               	xorq	%rcx, %rsi
               	orq	%rsi, %rbx
               	movl	$0x1, %esi
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	(%rdx), %rsi
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	xorq	%rsi, %rsi
               	xorq	%rsi, %rdi
               	xorq	%r9, %rsi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rsi
               	addq	%rax, %rsi
               	cmpq	%rax, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rcx), %r9
               	addq	%r9, %rdi
               	movabsq	$0x11223344556678, %r11 # imm = 0x11223344556678
               	cmpq	%r11, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$-0x7766554433221101, %r11 # imm = 0x8899AABBCCDDEEFF
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xc, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%r8), %rsi
               	movq	(%rdx), %r9
               	leaq	(%rsi), %rdi
               	cmpq	%rsi, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	$0x0, %r9
               	addq	%rsi, %r9
               	movq	(%r8), %rsi
               	cmpq	%rsi, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0x1, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xd, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
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
               	movabsq	$-0x77553310eeccaa8a, %r8 # imm = 0x88AACCEF11335576
               	cmpq	%r8, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	%r8, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rax
               	cmpq	%rax, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rdi
               	leaq	(%rcx), %rax
               	movq	%rax, %rcx
               	subq	%r8, %rcx
               	andq	$-0x100, %rdi
               	andq	$-0x1, %rcx
               	orq	$0x5, %rdi
               	orq	%rsi, %rcx
               	movq	(%rdx), %rax
               	shlq	$0x3f, %rax
               	movq	%rdi, %rdx
               	xorq	%rsi, %rdx
               	xorq	%rax, %rcx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x8aaccef11335576, %r11 # imm = 0x8AACCEF11335576
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rax
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
               	jmp	<addr>
               	jmp	<addr>
