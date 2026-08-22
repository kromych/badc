
alloca_alignment.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdi
               	subq	%r11, %rdi
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdi, %rsp
               	movl	$0x7, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movl	$0x21, %ecx
               	movq	%rcx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movl	$0x64, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	movq	%rdi, %rsi
               	andq	$0xf, %rsi
               	movq	%rax, %r8
               	andq	$0xf, %r8
               	orq	%r8, %rsi
               	movq	%rcx, %r8
               	andq	$0xf, %r8
               	orq	%r8, %rsi
               	movq	%rdx, %r8
               	andq	$0xf, %r8
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0xb, %r8d
               	movb	%r8b, (%rdi)
               	movl	$0x16, %r8d
               	movb	%r8b, 0x6(%rax)
               	movl	$0x21, %r8d
               	movb	%r8b, 0x20(%rcx)
               	movl	$0x2c, %r8d
               	movb	%r8b, 0x63(%rdx)
               	movsbq	(%rdi), %rdi
               	cmpq	$0xb, %rdi
               	jne	<addr>
               	movsbq	0x6(%rax), %rax
               	cmpq	$0x16, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x20(%rcx), %rax
               	cmpq	$0x21, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	0x63(%rdx), %rax
               	cmpq	$0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
