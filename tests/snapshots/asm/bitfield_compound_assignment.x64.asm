
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
               	movzwq	-0x8(%rbp), %rcx
               	andq	$-0x2, %rcx
               	movw	%cx, -0x8(%rbp)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xf, %rcx
               	movw	%cx, -0x8(%rbp)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xf1, %rcx
               	movw	%cx, -0x8(%rbp)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	movw	%cx, -0x8(%rbp)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	sarq	%rdx
               	andq	$0x7, %rdx
               	orq	$0x5, %rdx
               	andq	$-0xf, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	%rdx
               	andq	$0x7, %rdx
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$-0xf, %rax
               	orq	$0xe, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	%rdx
               	movq	%rdx, %rsi
               	andq	$0x7, %rsi
               	cmpl	$0x7, %esi
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	andq	$0x6, %rdx
               	movq	%rcx, %rax
               	andq	$-0xf, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	%rdx
               	andq	$0x7, %rdx
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$-0xf, %rax
               	orq	$0x2, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	%rdx
               	andq	$0x7, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rcx, %rax
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
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	%rdx
               	andq	$0x7, %rdx
               	xorq	$0x7, %rdx
               	movq	%rcx, %rax
               	andq	$-0xf, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	%rdx
               	andq	$0x7, %rdx
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	cmpl	$0xc, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x8, %rdx
               	cmpl	$0xc8, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$-0xf1, %rax
               	orq	$0xd0, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	cmpl	$0xd, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$-0xf1, %rax
               	orq	$0x90, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x8, %rdx
               	shlq	%rdx
               	andq	$0xff, %rdx
               	movq	%rcx, %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movq	%rdx, %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	sarq	$0x8, %rdx
               	xorq	$0x90, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	sarq	$0x2, %rdx
               	movq	%rcx, %rax
               	andq	$-0xf1, %rax
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
