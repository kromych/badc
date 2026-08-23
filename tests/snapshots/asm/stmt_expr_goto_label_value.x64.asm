
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
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movl	$0x64, %edi
               	movabsq	$-0x7fffffffffffffef, %rax # imm = 0x8000000000000011
               	movq	%r8, %rsi
               	jmp	<addr>
               	leaq	0x1(%rsi), %rcx
               	movq	%rcx, %rax
               	shlq	$0x6, %rax
               	cmpq	$0x64, %rax
               	jae	<addr>
               	movq	(%rdx,%rcx,8), %rax
               	movq	%rcx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rsi, %rcx
               	shlq	$0x6, %rcx
               	leaq	-0x1(%rax), %rdx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rdx
               	subq	%rdx, %rax
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rax, %rdx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	addq	%rcx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	movq	%r8, %r9
               	movq	%r8, %rbx
               	cmpq	$0x64, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0xc8, %r8
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rbx
               	addq	%rdi, %r9
               	leaq	-0x10(%rbp), %rsi
               	leaq	0x1(%rdi), %rax
               	movl	$0x64, %edi
               	cmpq	$0x64, %rax
               	jb	<addr>
               	incq	%r8
               	jmp	<addr>
               	movq	%rax, %rdx
               	shrq	$0x6, %rdx
               	movq	(%rsi,%rdx,8), %rcx
               	movabsq	$-0x1, %r12
               	andq	$0x3f, %rax
               	movq	%rax, %r10
               	movq	%r12, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	andq	%rcx, %rax
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movq	%rcx, %rax
               	shlq	$0x6, %rax
               	cmpq	$0x64, %rax
               	jae	<addr>
               	movq	(%rsi,%rcx,8), %rax
               	movq	%rcx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x6, %rcx
               	leaq	-0x1(%rax), %rdx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rdx
               	subq	%rdx, %rax
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rax, %rdx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	addq	%rcx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %rbx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xcb, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	movq	%rdi, %rax
               	movq	%rdi, %rax
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	0x8(%rsi), %rax
               	andq	$-0x200, %rax           # imm = 0xFE00
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	movq	%rcx, %rax
               	shlq	$0x6, %rax
               	cmpq	$0x64, %rax
               	jae	<addr>
               	movq	(%rsi,%rcx,8), %rax
               	movq	%rcx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x6, %rcx
               	leaq	-0x1(%rax), %rdx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rdx
               	subq	%rdx, %rax
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rax, %rdx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	addq	%rcx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	cmpq	$0x64, %rdi
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
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
