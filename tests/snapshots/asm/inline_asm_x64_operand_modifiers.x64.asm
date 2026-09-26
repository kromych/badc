
inline_asm_x64_operand_modifiers.x64:	file format elf64-x86-64

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
               	movw	$0x8002, -0x8(%rbp)     # imm = 0x8002
               	movl	$0x81, %eax
               	shrb	%al
               	andq	$0xff, %rax
               	xorq	$0x40, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x8001, %eax           # imm = 0x8001
               	shrw	%ax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x4000, %rax           # imm = 0x4000
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	shrl	%eax
               	cmpl	$0x40000000, %eax       # imm = 0x40000000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	shrq	%rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	shrw	(%rax)
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x4001, %rax           # imm = 0x4001
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x12345678, %edx       # imm = 0x12345678
               	movb	%dh, %al
               	andq	$0xff, %rax
               	xorq	$0x56, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x80000040, %r8d       # imm = 0x80000040
               	movl	%r8d, %eax
               	movl	$0x80000040, %r11d      # imm = 0x80000040
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x1e, %eax
               	addq	$0xc, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x23, %eax
               	addq	$0x7, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x27, %eax
               	addq	$0x3, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	movl	$0x28, %r10d
               	addq	%r10, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	shlq	$0x3, %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	shlq	%rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
