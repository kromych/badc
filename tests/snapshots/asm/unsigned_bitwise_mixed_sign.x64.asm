
unsigned_bitwise_mixed_sign.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movb	$-0x56, -0x20(%rbp)
               	movw	$0xffaa, -0x18(%rbp)    # imm = 0xFFAA
               	movl	$0xffffffaa, -0x10(%rbp) # imm = 0xFFFFFFAA
               	movl	$0xffffffaa, -0x8(%rbp) # imm = 0xFFFFFFAA
               	movsbq	-0x20(%rbp), %rax
               	movswq	-0x18(%rbp), %rcx
               	movl	-0x10(%rbp), %edx
               	movl	-0x8(%rbp), %ecx
               	movq	%rcx, %rsi
               	xorq	%rax, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rcx, %rsi
               	orq	%rax, %rsi
               	movl	$0xffffffaa, %r11d      # imm = 0xFFFFFFAA
               	cmpl	%r11d, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, %rsi
               	andq	%rax, %rsi
               	movl	$0xffffffaa, %r11d      # imm = 0xFFFFFFAA
               	cmpl	%r11d, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xffffffaa, %r11d      # imm = 0xFFFFFFAA
               	movq	%rdx, %rsi
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	cmpl	$0x55, %esi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	orq	%rdx, %rcx
               	movl	$0xffffffaa, %r11d      # imm = 0xFFFFFFAA
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	xorq	$-0x56, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorq	$0xffaa, %rax           # imm = 0xFFAA
               	cmpq	$-0x10000, %rax         # imm = 0xFFFF0000
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
