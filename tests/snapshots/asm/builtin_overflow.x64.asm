
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
               	leaq	-0x10(%rbp), %rax
               	movl	$0x80000000, (%rax)     # imm = 0x80000000
               	movslq	-0x10(%rbp), %rcx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x7b, (%rax)
               	movslq	-0x10(%rbp), %rcx
               	cmpl	$0x7b, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7fffffff, (%rax)     # imm = 0x7FFFFFFF
               	movslq	-0x10(%rbp), %rcx
               	cmpl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x0, (%rcx)
               	movl	$0xfffffffe, (%rcx)     # imm = 0xFFFFFFFE
               	movl	-0x8(%rbp), %esi
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x15, (%rax)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rdx, (%rcx)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, (%rcx)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	movabsq	$0xe8d4a51000, %rsi     # imm = 0xE8D4A51000
               	movq	%rsi, (%rax)
               	movq	-0x8(%rbp), %rsi
               	movabsq	$0xe8d4a51000, %r11     # imm = 0xE8D4A51000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rdx, (%rax)
               	movq	-0x8(%rbp), %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	$-0xf, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	$-0xf, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	$-0x2, (%rax)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$-0x2, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$0x0, (%rax)
               	movabsq	$0x1b13114fbff5385, %rdx # imm = 0x1B13114FBFF5385
               	movq	%rdx, (%rax)
               	movq	-0x8(%rbp), %rdx
               	movabsq	$0x1b13114fbff5385, %r11 # imm = 0x1B13114FBFF5385
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x80000000, (%rax)     # imm = 0x80000000
               	movslq	-0x8(%rbp), %rdx
               	cmpl	$0x80000000, %edx       # imm = 0x80000000
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x7b, (%rax)
               	movslq	-0x8(%rbp), %rdx
               	cmpl	$0x7b, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x7fffffff, (%rax)     # imm = 0x7FFFFFFF
               	movslq	-0x8(%rbp), %rdx
               	cmpl	$0x7fffffff, %edx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movl	$0xfffffffe, (%rax)     # imm = 0xFFFFFFFE
               	movl	-0x8(%rbp), %edx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movq	$0x3, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0x3, %rdx
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	$0x2, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0x2, %rdx
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	$0x2a, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x3, (%rax)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movq	$-0x1, (%rax)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, (%rsi)
               	movq	-0x10(%rbp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movq	$0x0, (%rsi)
               	movq	$0x0, (%rax)
               	movq	$-0x1, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	movq	$0x0, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	$0x2, (%rax)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
