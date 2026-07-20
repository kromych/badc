
builtin_overflow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0x8(%rbp), %rax
               	movabsq	$-0x80000000, %rcx      # imm = 0x80000000
               	movl	%ecx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7b, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x7b, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	movl	%ecx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	-0x10(%rbp), %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0xfffffffe, %ecx       # imm = 0xFFFFFFFE
               	movl	%ecx, (%rax)
               	movl	-0x10(%rbp), %eax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x15, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0xe8d4a51000, %rcx     # imm = 0xE8D4A51000
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	movabsq	$0xe8d4a51000, %r11     # imm = 0xE8D4A51000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0xf, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x18(%rbp), %rax
               	cmpq	$-0xf, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movabsq	$-0x2, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x20(%rbp), %rax
               	cmpq	$-0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movabsq	$0x1b13114fbff5385, %rcx # imm = 0x1B13114FBFF5385
               	movq	%rcx, (%rax)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x1b13114fbff5385, %r11 # imm = 0x1B13114FBFF5385
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
