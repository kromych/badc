
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
               	movzwq	-0x8(%rbp), %rax
               	andq	$-0x2, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	%rcx
               	andq	$0x7, %rcx
               	orq	$0x5, %rcx
               	andq	$-0xf, %rax
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	andq	$-0xf, %rax
               	orq	$0xe, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	%rcx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	andq	$0x6, %rcx
               	andq	$-0xf, %rax
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	andq	$-0xf, %rax
               	orq	$0x2, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
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
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	%rcx
               	andq	$0x7, %rcx
               	xorq	$0x7, %rcx
               	andq	$-0xf, %rax
               	shlq	%rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	sarq	$0x8, %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	andq	$-0xf1, %rax
               	orq	$0xd0, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	andq	$-0xf1, %rax
               	orq	$0x90, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	sarq	$0x8, %rcx
               	shlq	%rcx
               	andq	$0xff, %rcx
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	$0x8, %rcx
               	xorq	$0x90, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	sarq	$0x2, %rcx
               	andq	$-0xf1, %rax
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
