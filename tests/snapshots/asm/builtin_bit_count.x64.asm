
builtin_bit_count.x64:	file format elf64-x86-64

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
               	movl	$0xff00ff, %ecx         # imm = 0xFF00FF
               	movl	%ecx, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rdx
               	shrq	%rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rdx
               	shrq	%rdx
               	orq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	orq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	orq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	orq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	orq	%rdx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	shrq	%rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %edx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	leaq	-0x1(%rax), %rdx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	shrq	%rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
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
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
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
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
