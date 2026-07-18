
has_builtin_clrsb.x64:	file format elf64-x86-64

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
               	movl	$0xff, %eax
               	movl	%eax, -0x8(%rbp)
               	movabsq	$-0x400, %rax           # imm = 0xFC00
               	movq	%rax, -0x10(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x1f, %rcx
               	xorq	%rcx, %rax
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
               	decq	%rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	orq	%rcx, %rax
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
               	movl	$0x40, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	cmpq	$0x35, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
