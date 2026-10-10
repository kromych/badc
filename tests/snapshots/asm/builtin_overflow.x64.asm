
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
               	movq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x7b, %eax
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	movl	-0x8(%rbp), %ecx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x15, %eax
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
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
               	movq	$-0x2, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$0x1b13114fbff5385, %rcx # imm = 0x1B13114FBFF5385
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0x1b13114fbff5385, %r11 # imm = 0x1B13114FBFF5385
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	$-0x80000000, %rcx      # imm = 0x80000000
               	movl	%ecx, -0x8(%rbp)
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x7b, %ecx
               	movl	%ecx, -0x8(%rbp)
               	cmpl	$0x7b, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movl	%ecx, -0x8(%rbp)
               	cmpl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	movl	-0x8(%rbp), %ecx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x3, %eax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	$0x2, %ecx
               	movq	%rcx, -0x8(%rbp)
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	$0x2a, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movq	$-0x1, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x10(%rbp)
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movl	$0x2, %eax
               	movq	%rax, -0x10(%rbp)
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
