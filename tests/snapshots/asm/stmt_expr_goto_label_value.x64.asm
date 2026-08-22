
stmt_expr_goto_label_value.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0xa, %eax
               	movl	$0x3, %eax
               	movl	$0x6, %eax
               	movl	$0x74, %eax
               	movl	$0x5, %eax
               	movl	$0xf, %eax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rdi, %rdi
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x64, %esi
               	xorq	%rax, %rax
               	movabsq	$-0x7fffffffffffffef, %rcx # imm = 0x8000000000000011
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	shlq	$0x6, %rcx
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	incq	%rax
               	movq	(%rdx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rdx
               	shlq	$0x6, %rdx
               	leaq	-0x1(%rcx), %rax
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	%rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	movq	%rdi, %r8
               	movq	%rdi, %r9
               	cmpq	$0x64, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0xc8, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%r9
               	addq	%rsi, %r8
               	leaq	-0x10(%rbp), %rdx
               	leaq	0x1(%rsi), %rcx
               	movl	$0x64, %esi
               	cmpq	$0x64, %rcx
               	jb	<addr>
               	incq	%rdi
               	jmp	<addr>
               	movq	%rcx, %rax
               	shrq	$0x6, %rax
               	movq	(%rdx,%rax,8), %rbx
               	movabsq	$-0x1, %r12
               	andq	$0x3f, %rcx
               	movq	%rcx, %r10
               	movq	%r12, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	andq	%rbx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	shlq	$0x6, %rcx
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	incq	%rax
               	movq	(%rdx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rdx
               	shlq	$0x6, %rdx
               	leaq	-0x1(%rcx), %rax
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	%rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xcb, %r8
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movl	$0x64, %eax
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x64, %esi
               	movl	$0x1, %eax
               	movq	0x8(%rdx), %rcx
               	andq	$-0x200, %rcx           # imm = 0xFE00
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	shlq	$0x6, %rcx
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	incq	%rax
               	movq	(%rdx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rdx
               	shlq	$0x6, %rdx
               	leaq	-0x1(%rcx), %rax
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	%rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	cmpq	$0x64, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	jmp	<addr>
