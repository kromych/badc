
builtin_bit_count.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<eq>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movl	$0x1f, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	xorq	%rcx, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10000, %eax          # imm = 0x10000
               	movl	$0x8000, %ecx           # imm = 0x8000
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movl	$0xf, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	xorq	%rcx, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movabsq	$-0x2, %rcx
               	andq	%rax, %rcx
               	movl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrq	$0x1, %rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movabsq	$-0x80000001, %rcx      # imm = 0xFFFFFFFF7FFFFFFF
               	andq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x1f, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movabsq	$-0x10001, %rcx         # imm = 0xFFFEFFFF
               	andq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x10, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3fffffff, %eax       # imm = 0x3FFFFFFF
               	movabsq	$-0x40000001, %rcx      # imm = 0xBFFFFFFF
               	andq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x1e, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x55555555, %ecx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf0f0f0f, %eax        # imm = 0xF0F0F0F
               	movl	$0x5050505, %ecx        # imm = 0x5050505
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x10, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x3, %ecx
               	movl	$0x1, %edx
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x40, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movl	$0x3f, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x40, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	xorq	%rcx, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x40, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movl	$0x1f, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movabsq	$-0x2, %rcx
               	andq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1, %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rdx
               	subq	%rdx, %rcx
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rcx, %rdx
               	shrq	$0x2, %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x3f, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movabsq	$-0x100000001, %rcx     # imm = 0xFFFFFFFEFFFFFFFF
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x20, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movabsq	$0x5555555555555555, %rcx # imm = 0x5555555555555555
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x40, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0xdeadbeefcafe, %rax   # imm = 0xDEADBEEFCAFE
               	movabsq	$0x455455554555, %rcx   # imm = 0x455455554555
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x23, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff00ff, %eax         # imm = 0xFF00FF
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movl	$0x10, %edx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shrq	$0x1, %rdx
               	andq	$0x55555555, %rdx       # imm = 0x55555555
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	andq	$0x33333333, %rdx       # imm = 0x33333333
               	shrq	$0x2, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movl	$0x20, %edx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	$0x8, %edx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	decq	%rcx
               	xorq	$-0x1, %rax
               	andq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	andq	$0x55555555, %rcx       # imm = 0x55555555
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x33333333, %rcx       # imm = 0x33333333
               	shrq	$0x2, %rax
               	andq	$0x33333333, %rax       # imm = 0x33333333
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	xorq	%rcx, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movabsq	$-0x2, %rcx
               	andq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1, %rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rdx
               	subq	%rdx, %rcx
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rcx, %rdx
               	shrq	$0x2, %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movabsq	$-0x10001, %rcx         # imm = 0xFFFEFFFF
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x10, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x3, %ecx
               	movl	$0x1, %edx
               	subq	%rdx, %rax
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rax, %rdx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf0f0f0f, %eax        # imm = 0xF0F0F0F
               	movl	$0x5050505, %ecx        # imm = 0x5050505
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	movl	$0x10, %ecx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff00ff, %eax         # imm = 0xFF00FF
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	movabsq	$0x3333333333333333, %rdx # imm = 0x3333333333333333
               	andq	%rcx, %rdx
               	shrq	$0x2, %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	addq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movl	$0x10, %edx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	decq	%rcx
               	xorq	$-0x1, %rax
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	xorq	%rcx, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
