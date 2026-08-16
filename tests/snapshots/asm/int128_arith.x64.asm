
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
               	movq	(%rax), %rdx
               	xorq	%rcx, %rcx
               	leaq	<rip>, %r8
               	movq	(%r8), %rax
               	orq	%rcx, %rax
               	orq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	decq	%rsi
               	cmpq	$-0x1, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	leaq	(%rdi), %r9
               	testq	%rsi, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0x1, %r9
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rdi, %rsi
               	leaq	(%r9), %rdi
               	subq	%rbx, %rdi
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
               	movq	(%rdx), %rdi
               	xorq	%r9, %r9
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	subq	%rax, %r9
               	subq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%r9, %rsi
               	cmpq	%r11, %r9
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$0x7766554433221101, %r11 # imm = 0x7766554433221101
               	movq	%rdi, %rsi
               	cmpq	%r11, %rdi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdi
               	xorq	%r9, %r9
               	testq	%rdi, %rdi
               	seta	%sil
               	movzbq	%sil, %rsi
               	subq	%rdi, %r9
               	xorq	%rdi, %rdi
               	movq	%rdi, %rbx
               	subq	%rsi, %rbx
               	movabsq	$-0x1, %rdi
               	cmpq	%rdi, %r9
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
               	xorq	%rdi, %rdi
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r9
               	subq	%rax, %r9
               	subq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movabsq	$-0x11223344556677, %r11 # imm = 0xFFEEDDCCBBAA9989
               	movq	%r9, %rsi
               	cmpq	%r11, %r9
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
               	movq	(%rdx), %rdi
               	shlq	$0x3f, %rdi
               	movq	%rax, %rsi
               	orq	$0x0, %rsi
               	orq	%rcx, %rdi
               	movabsq	$0x11223344556677, %r11 # imm = 0x11223344556677
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
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	xorq	%rax, %rsi
               	movq	%rcx, %rdi
               	xorq	%rcx, %rdi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdi, %rdi
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
               	movq	%rcx, %r9
               	xorq	%rcx, %r9
               	xorq	%rsi, %rsi
               	xorq	%rsi, %rdi
               	xorq	%r9, %rsi
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
               	movq	(%r8), %rdi
               	movq	(%rdx), %r9
               	leaq	(%rdi), %rsi
               	cmpq	%rdi, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	$0x0, %r9
               	addq	%r9, %rdi
               	movq	(%r8), %r8
               	cmpq	%r8, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0x1, %rdi
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
               	xorq	%rdi, %rdi
               	movq	%rcx, %r8
               	orq	%rdi, %r8
               	orq	%rax, %rdi
               	leaq	(%rax,%r8), %rsi
               	cmpq	%rax, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rdi, %rcx
               	addq	%rax, %rcx
               	movabsq	$-0x77553310eeccaa8a, %rdi # imm = 0x88AACCEF11335576
               	cmpq	%rdi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	%rdi, %rcx
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
               	xorq	%rdi, %rdi
               	cmpq	%rax, %rsi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rsi
               	leaq	(%rcx), %rax
               	movq	%rax, %rcx
               	subq	%r8, %rcx
               	andq	$-0x100, %rsi
               	andq	$-0x1, %rcx
               	orq	$0x5, %rsi
               	orq	%rdi, %rcx
               	movq	(%rdx), %rdx
               	shlq	$0x3f, %rdx
               	movq	%rsi, %rax
               	xorq	%rdi, %rax
               	xorq	%rdx, %rcx
               	movabsq	$-0x77553310eeccaafb, %r11 # imm = 0x88AACCEF11335505
               	cmpq	%r11, %rax
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
               	movl	$0xf, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
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
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
