
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
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0x2, %rdx
               	orq	%rcx, %rdx
               	movw	%dx, (%rax)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$-0xf, %rdx
               	orq	%rcx, %rdx
               	movw	%dx, (%rax)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$-0xf1, %rdx
               	orq	%rcx, %rdx
               	movw	%dx, (%rax)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	$-0xff01, %rdx          # imm = 0xFFFF00FF
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	orq	$0x5, %rsi
               	andq	$0x7, %rsi
               	movq	%rdx, %rcx
               	andq	$-0xf, %rcx
               	movq	%rsi, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rdx, %rcx
               	andq	$-0xf, %rcx
               	orq	$0xe, %rcx
               	movw	%cx, (%rax)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rsi
               	sarq	%rsi
               	movq	%rsi, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdx
               	andq	$0x6, %rsi
               	andq	$-0xf, %rax
               	movq	%rsi, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, (%rdx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x6, %esi
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$-0xf, %rax
               	orq	$0x2, %rax
               	movw	%ax, (%rdx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$-0x2, %rax
               	orq	$0x1, %rax
               	movw	%ax, (%rdx)
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	orq	$0xc0, %rax
               	movw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc800, %rax           # imm = 0xC800
               	movw	%ax, (%rcx)
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x7, %rsi
               	xorq	$0x7, %rsi
               	andq	$0x7, %rsi
               	movq	%rdx, %rax
               	andq	$-0xf, %rax
               	movq	%rsi, %rdx
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, (%rcx)
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
               	andq	$0xff, %rsi
               	cmpl	$0xc8, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	andq	$-0xf1, %rax
               	orq	$0xd0, %rax
               	movw	%ax, (%rcx)
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
               	movw	%ax, (%rcx)
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
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, %rsi
               	sarq	$0x8, %rsi
               	andq	$0xff, %rsi
               	shlq	%rsi
               	andq	$0xff, %rsi
               	movq	%rcx, %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movq	%rsi, %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movw	%ax, (%rdx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	sarq	$0x8, %rsi
               	andq	$0xff, %rsi
               	xorq	$0x90, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	%rcx, %rsi
               	sarq	$0x4, %rsi
               	andq	$0xf, %rsi
               	sarq	$0x2, %rsi
               	andq	$0xf, %rsi
               	movq	%rcx, %rax
               	andq	$-0xf1, %rax
               	movq	%rsi, %rcx
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	movw	%ax, (%rdx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
