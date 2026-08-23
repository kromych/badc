
divq_udiv_qrnnd.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movl	$0x64, %eax
               	movl	$0x7, %esi
               	leaq	-0x8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rdx, %r11
               	movq	%r11, %rdx
               	divq	%r10
               	popq	%r11
               	movq	%rdx, (%r11)
               	popq	%r11
               	movq	%rax, (%r11)
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf4240, %eax          # imm = 0xF4240
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	leaq	-0x8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rdx, %r11
               	movq	%r11, %rdx
               	divq	%r10
               	popq	%r11
               	movq	%rdx, (%r11)
               	popq	%r11
               	movq	%rax, (%r11)
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	xorq	%rdx, %rdx
               	movl	$0x2, %eax
               	leaq	-0x8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rax, %r10
               	movq	%rsi, %r11
               	movq	%rdx, %rax
               	movq	%r11, %rdx
               	divq	%r10
               	popq	%r11
               	movq	%rdx, (%r11)
               	popq	%r11
               	movq	%rax, (%r11)
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	leaq	-0x8(%rbp), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	movq	%rsi, %r11
               	movq	%rdx, %rax
               	movq	%r11, %rdx
               	divq	%r10
               	popq	%r11
               	movq	%rdx, (%r11)
               	popq	%r11
               	movq	%rax, (%r11)
               	popq	%rdx
               	popq	%rax
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
