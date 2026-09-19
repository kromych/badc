
bitfields.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	andq	$-0x3, %rcx
               	movl	%ecx, (%rax)
               	andq	$-0x1d, %rcx
               	orq	$0x14, %rcx
               	movl	%ecx, (%rax)
               	andq	$-0x3e1, %rcx           # imm = 0xFC1F
               	orq	$0x220, %rcx            # imm = 0x220
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %edx
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	andq	%r11, %rdx
               	orq	$0x12345678, %rdx       # imm = 0x12345678
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	%ecx, %esi
               	movq	%rsi, %rdi
               	sarq	%rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rsi, %rdi
               	sarq	$0x2, %rdi
               	andq	$0x7, %rdi
               	cmpl	$0x5, %edi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	sarq	$0x5, %rsi
               	andq	$0x1f, %rsi
               	cmpl	$0x11, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	$0x12345678, %rdx       # imm = 0x12345678
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	andq	$-0x2, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x2, %rsi
               	andq	$0x7, %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	sarq	$0x5, %rdx
               	andq	$0x1f, %rdx
               	cmpl	$0x11, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	andq	$-0x1d, %rcx
               	orq	$0x1c, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %eax
               	movq	%rax, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	andq	$-0x2, %rax
               	orq	$0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0x3, %rax
               	orq	$0x2, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0x5, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0x9, %rax
               	orq	$0x8, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0xf1, %rax
               	orq	$0xb0, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc800, %rax           # imm = 0xC800
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	sarq	%rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x3, %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc900, %rax           # imm = 0xC900
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %eax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpl	$0xc9, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
