
unary_minus_unsigned_literal_wraps.x64:	file format elf64-x86-64

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
               	movl	$0x7, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	-0x18(%rbp), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %ecx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %ecx
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
