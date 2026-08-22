
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
               	movl	%ecx, %ecx
               	andq	$-0x3, %rcx
               	orq	$0x0, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	andq	$-0x1d, %rcx
               	orq	$0x14, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	andq	$-0x3e1, %rcx           # imm = 0xFC1F
               	orq	$0x220, %rcx            # imm = 0x220
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %edx
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	andq	%r11, %rdx
               	movq	%rdx, %rsi
               	orq	$0x12345678, %rsi       # imm = 0x12345678
               	movl	%esi, 0x4(%rax)
               	movl	$0x3e7, %edx            # imm = 0x3E7
               	movl	%edx, 0x8(%rax)
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rdi
               	sarq	%rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rdi
               	sarq	$0x2, %rdi
               	andq	$0x7, %rdi
               	cmpq	$0x5, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rdi
               	sarq	$0x5, %rdi
               	andq	$0x1f, %rdi
               	cmpq	$0x11, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%esi, %esi
               	xorq	$0x12345678, %rsi       # imm = 0x12345678
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rcx
               	andq	$-0x2, %rcx
               	orq	$0x0, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, %eax
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	sarq	%rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	sarq	$0x5, %rdx
               	andq	$0x1f, %rdx
               	cmpq	$0x11, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	andq	$-0x1d, %rax
               	orq	$0x1c, %rax
               	movl	%eax, (%rdx)
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rdx
               	sarq	$0x5, %rdx
               	andq	$0x1f, %rdx
               	cmpq	$0x11, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %eax
               	andq	$-0x2, %rax
               	orq	$0x1, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %eax
               	andq	$-0x3, %rax
               	orq	$0x2, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %eax
               	andq	$-0x5, %rax
               	orq	$0x0, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %eax
               	andq	$-0x9, %rax
               	orq	$0x8, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %eax
               	andq	$-0xf1, %rax
               	orq	$0xb0, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %eax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc800, %rax           # imm = 0xC800
               	movl	%eax, (%rcx)
               	movl	%eax, %edx
               	movq	%rdx, %rsi
               	andq	$0x1, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	%rsi
               	andq	$0x1, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x2, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x3, %rsi
               	andq	$0x1, %rsi
               	cmpq	$0x1, %rsi
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x4, %rsi
               	andq	$0xf, %rsi
               	cmpq	$0xb, %rsi
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rsi
               	sarq	$0x8, %rsi
               	andq	$0xff, %rsi
               	cmpq	$0xc8, %rsi
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc900, %rax           # imm = 0xC900
               	movl	%eax, (%rcx)
               	movl	%eax, %eax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc9, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
