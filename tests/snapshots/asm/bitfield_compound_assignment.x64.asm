
bitfield_compound_assignment.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movzwq	-0x8(%rbp), %rax
               	andq	$-0x2, %rax
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	orq	$0x5, %rsi
               	movq	%rdx, %rax
               	andq	$-0xf, %rax
               	movq	%rsi, %rdx
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$-0xf, %rax
               	orq	$0xe, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	movq	%rsi, %rdi
               	andq	$0x7, %rdi
               	cmpl	$0x7, %edi
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	andq	$0x6, %rsi
               	movq	%rdx, %rax
               	andq	$-0xf, %rax
               	movq	%rsi, %rdx
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x6, %esi
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$-0xf, %rax
               	orq	$0x2, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$-0x2, %rax
               	orq	$0x1, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	orq	$0xc0, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc800, %rax           # imm = 0xC800
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	xorq	$0x7, %rsi
               	movq	%rdx, %rax
               	andq	$-0xf, %rax
               	movq	%rsi, %rdx
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x6, %esi
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x4, %rsi
               	andq	$0xf, %rsi
               	cmpl	$0xc, %esi
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x8, %rsi
               	cmpl	$0xc8, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$-0xf1, %rax
               	orq	$0xd0, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	$0x4, %rsi
               	andq	$0xf, %rsi
               	cmpl	$0xd, %esi
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$-0xf1, %rax
               	orq	$0x90, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	$0x4, %rsi
               	andq	$0xf, %rsi
               	cmpl	$0x9, %esi
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x8, %rsi
               	shlq	%rsi
               	andq	$0xff, %rsi
               	movq	%rdx, %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	$0x8, %rsi
               	xorq	$0x90, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x4, %rsi
               	andq	$0xf, %rsi
               	sarq	$0x2, %rsi
               	movq	%rdx, %rax
               	andq	$-0xf1, %rax
               	movq	%rsi, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
