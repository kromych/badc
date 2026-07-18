
builtin_bit_count.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0xff00ff, %eax         # imm = 0xFF00FF
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	%rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	%rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	%rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	leaq	-0x1(%rax), %rcx
               	xorq	$-0x1, %rax
               	andq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	%rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff00ff, %eax         # imm = 0xFF00FF
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
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
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	leaq	-0x1(%rax), %rcx
               	xorq	$-0x1, %rax
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
