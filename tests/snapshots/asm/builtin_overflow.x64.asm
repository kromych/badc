
builtin_overflow.x64:	file format elf64-x86-64

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
               	movl	$0x80000000, -0x10(%rbp) # imm = 0x80000000
               	movl	$0x7b, -0x10(%rbp)
               	movl	$0x7fffffff, -0x10(%rbp) # imm = 0x7FFFFFFF
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	movl	-0x8(%rbp), %ecx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x15, -0x10(%rbp)
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$0xe8d4a51000, %rdx     # imm = 0xE8D4A51000
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movabsq	$0xe8d4a51000, %r11     # imm = 0xE8D4A51000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	$-0xf, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$-0xf, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movq	$-0x2, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$0x1b13114fbff5385, %rcx # imm = 0x1B13114FBFF5385
               	movq	%rcx, -0x8(%rbp)
               	movl	$0x80000000, -0x8(%rbp) # imm = 0x80000000
               	movl	$0x7b, -0x8(%rbp)
               	movl	$0x7fffffff, -0x8(%rbp) # imm = 0x7FFFFFFF
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	movl	-0x8(%rbp), %ecx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	movq	$0x2, -0x8(%rbp)
               	movq	$0x2a, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movq	$0x3, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x10(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	$0x2, -0x10(%rbp)
               	xorl	%eax, %eax
               	leave
               	retq
