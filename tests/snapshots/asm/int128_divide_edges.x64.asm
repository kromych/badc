
int128_divide_edges.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<udiv>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdx, %r8
               	movq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rcx, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	movq	%rax, %r9
               	xorq	$0x3f, %r9
               	shlxq	%rax, %rcx, %rax
               	movq	%r8, %rdx
               	shrq	%rdx
               	shrxq	%r9, %rdx, %rdx
               	orq	%rdx, %rax
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %rbx
               	movq	%rax, %r11
               	movq	%rbx, %rax
               	divq	%r11
               	shrxq	%r9, %rax, %r9
               	testq	%r9, %r9
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r9
               	movq	%r9, %rax
               	mulq	%r8
               	movq	%r9, %rbx
               	imulq	%rcx, %rbx
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	addq	%rbx, %rdx
               	cmpq	%rax, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rax, %rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	subq	%rbx, %rax
               	cmpq	%rcx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	addq	%r9, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	xorl	%ecx, %ecx
               	cmpq	%r8, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	imulq	%r8, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	divq	%r8
               	jmp	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	jmp	<addr>

<umod>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdx, %r8
               	movq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rcx, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	movq	%rax, %r9
               	xorq	$0x3f, %r9
               	shlxq	%rax, %rcx, %rax
               	movq	%r8, %rdx
               	shrq	%rdx
               	shrxq	%r9, %rdx, %rdx
               	orq	%rdx, %rax
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %rbx
               	movq	%rax, %r11
               	movq	%rbx, %rax
               	divq	%r11
               	shrxq	%r9, %rax, %r9
               	testq	%r9, %r9
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r9
               	movq	%r9, %rax
               	mulq	%r8
               	movq	%r9, %rax
               	imulq	%rcx, %rax
               	imulq	%r8, %r9
               	addq	%rdx, %rax
               	cmpq	%r9, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r9, %rdi
               	subq	%rax, %rsi
               	subq	%rdx, %rsi
               	cmpq	%rcx, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r8, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	negq	%rax
               	movq	%r8, %rdx
               	andq	%rax, %rdx
               	andq	%rax, %rcx
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	subq	%r8, %rdx
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	cmpq	%r8, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rsi
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	divq	%r8
               	movq	%rax, %r9
               	imulq	%r8, %r9
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	jmp	<addr>

<sdiv>:
               	subq	$0x20, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movq	%rdi, %rax
               	xorq	%r8, %rax
               	xorq	%r8, %rsi
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%r8, %rax
               	subq	%r8, %rsi
               	subq	%rdi, %rsi
               	xorq	%r9, %rdx
               	movq	%rcx, %rdi
               	xorq	%r9, %rdi
               	cmpq	%r9, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rcx
               	subq	%r9, %rcx
               	subq	%r9, %rdi
               	subq	%rbx, %rdi
               	movq	%rsi, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rdi, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	movq	%rdx, %rbx
               	xorq	$0x3f, %rbx
               	shlxq	%rdx, %rdi, %rdx
               	movq	%rcx, %r12
               	shrq	%r12
               	shrxq	%rbx, %r12, %r12
               	orq	%rdx, %r12
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rax, %r13
               	shrq	%r13
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %r13
               	movq	%rax, -0x18(%rsp)
               	movq	%r13, %rax
               	divq	%r12
               	movq	%rax, %rdx
               	movq	-0x18(%rsp), %rax
               	shrxq	%rbx, %rdx, %rdx
               	testq	%rdx, %rdx
               	setne	%bl
               	movzbq	%bl, %rbx
               	subq	%rbx, %rdx
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%rdx, %rax
               	mulq	%rcx
               	movq	%rdx, %r12
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	movq	%rdx, %r13
               	imulq	%rdi, %r13
               	movq	%rdx, %rbx
               	imulq	%rcx, %rbx
               	addq	%r13, %r12
               	cmpq	%rbx, %rax
               	setb	%r13b
               	movzbq	%r13b, %r13
               	negq	%rbx
               	addq	%rax, %rbx
               	movq	%rsi, %rax
               	subq	%r12, %rax
               	subq	%r13, %rax
               	cmpq	%rdi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rbx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	xorq	$0x1, %rax
               	addq	%rdx, %rax
               	xorl	%edi, %edi
               	movq	%r8, %rcx
               	xorq	%r9, %rcx
               	xorq	%rcx, %rax
               	xorq	%rcx, %rdi
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rcx, %rax
               	movq	%rdi, %rdx
               	subq	%rcx, %rdx
               	subq	%rsi, %rdx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	xorl	%edi, %edi
               	cmpq	%rcx, %rsi
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %rdi
               	movq	-0x18(%rsp), %rax
               	movq	%rdi, %rdx
               	imulq	%rcx, %rdx
               	subq	%rdx, %rsi
               	movq	%rsi, %rdx
               	divq	%rcx
               	jmp	<addr>
               	xorl	%edx, %edx
               	divq	%rcx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdi
               	jmp	<addr>

<smod>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movq	%rdi, %rax
               	xorq	%r8, %rax
               	xorq	%r8, %rsi
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%r8, %rax
               	subq	%r8, %rsi
               	subq	%rdi, %rsi
               	xorq	%r9, %rdx
               	movq	%rcx, %rdi
               	xorq	%r9, %rdi
               	cmpq	%r9, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rcx
               	subq	%r9, %rcx
               	subq	%r9, %rdi
               	subq	%rbx, %rdi
               	movq	%rsi, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rdi, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	movq	%rdx, %r9
               	xorq	$0x3f, %r9
               	shlxq	%rdx, %rdi, %rdx
               	movq	%rcx, %rbx
               	shrq	%rbx
               	shrxq	%r9, %rbx, %rbx
               	orq	%rdx, %rbx
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rax, %r12
               	shrq	%r12
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %r12
               	movq	%rax, -0x18(%rsp)
               	movq	%r12, %rax
               	divq	%rbx
               	movq	%rax, %rdx
               	movq	-0x18(%rsp), %rax
               	shrxq	%r9, %rdx, %r9
               	testq	%r9, %r9
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %r9
               	movq	%rax, -0x18(%rsp)
               	movq	%r9, %rax
               	mulq	%rcx
               	movq	-0x18(%rsp), %rax
               	movq	%r9, %rbx
               	imulq	%rdi, %rbx
               	imulq	%rcx, %r9
               	addq	%rdx, %rbx
               	cmpq	%r9, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%rax, %rdx
               	subq	%r9, %rdx
               	subq	%rbx, %rsi
               	subq	%r12, %rsi
               	cmpq	%rdi, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rcx, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rax
               	xorq	$0x1, %rax
               	negq	%rax
               	andq	%rax, %rcx
               	andq	%rdi, %rax
               	cmpq	%rcx, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rcx, %rdx
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	subq	%rdi, %rcx
               	movq	%rdx, %rax
               	xorq	%r8, %rax
               	xorq	%r8, %rcx
               	cmpq	%r8, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%r8, %rax
               	subq	%r8, %rcx
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	cmpq	%rcx, %rsi
               	jb	<addr>
               	movq	%rax, -0x18(%rsp)
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rsi
               	movq	-0x18(%rsp), %rax
               	movq	%rax, -0x18(%rsp)
               	movq	%rsi, %rdx
               	divq	%rcx
               	movq	%rax, %r9
               	movq	-0x18(%rsp), %rax
               	imulq	%rcx, %r9
               	movq	%rax, %rdx
               	subq	%r9, %rdx
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%edx, %edx
               	divq	%rcx
               	xorl	%ecx, %ecx
               	jmp	<addr>

<reference>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%rcx, %r12
               	movq	%rdx, %rbx
               	movq	%rsi, %rdi
               	xorl	%eax, %eax
               	movl	$0x7f, %r9d
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	decq	%r9
               	nopw	(%rax,%rax)
               	testl	%r9d, %r9d
               	jl	<addr>
               	movq	%rcx, %r13
               	shrq	$0x3f, %r13
               	movq	%rax, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rax
               	orq	%rax, %rcx
               	movq	%r9, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %r8d
               	movq	%r8, %r15
               	subq	%rax, %r15
               	movq	%r9, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %rbp
               	xorq	$-0x1, %rbp
               	shrxq	%rax, %rdi, %r10
               	movq	%r10, 0x40(%rsp)
               	shlxq	%r15, %rdi, %r15
               	shlq	%r15
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	shrxq	%r10, %rax, %rax
               	orq	%r15, %rax
               	andq	%rbp, %rax
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	andq	%r10, %r8
               	orq	%r8, %rax
               	andq	$0x1, %rax
               	orq	%r14, %rax
               	nop
               	testq	%r13, %r13
               	jne	<addr>
               	cmpq	%r12, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%r12, %rcx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	%rbx, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r8, %r13
               	xorq	$0x1, %r13
               	testq	%r13, %r13
               	je	<addr>
               	cmpq	%rbx, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rbx, %rax
               	subq	%r12, %rcx
               	subq	%r8, %rcx
               	movl	$0x1, %r13d
               	xorl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movq	%r9, %r8
               	andq	$0x3f, %r8
               	movl	$0x3f, %r14d
               	movq	%r14, %r10
               	subq	%r8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r9, %r14
               	shrq	$0x6, %r14
               	negq	%r14
               	movq	%r14, %r15
               	xorq	$-0x1, %r15
               	shlxq	%r8, %r13, %rbp
               	movq	0x38(%rsp), %r10
               	shrxq	%r10, %r13, %r13
               	shrq	%r13
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	shlxq	%r10, %r8, %r8
               	orq	%r8, %r13
               	movq	%rbp, %r8
               	andq	%r15, %r8
               	andq	%r15, %r13
               	andq	%rbp, %r14
               	orq	%r14, %r13
               	orq	%r8, %rdx
               	orq	%r13, %rsi
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movq	0x30(%rsp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movq	%rdx, %rax
               	movq	%rsi, %rdx
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x28, %rsp
               	retq

<signed_ok>:
               	subq	$0x78, %rsp
               	movq	%rdi, (%rsp)
               	leaq	(%rsp), %rdi
               	movq	%rsi, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	(%rsp), %rax
               	testq	%rsi, %rsi
               	jge	<addr>
               	testq	%rax, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	negq	%rax
               	movq	%rsi, %rdx
               	negq	%rdx
               	subq	%rcx, %rdx
               	leaq	0x40(%rsp), %rdi
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	testq	%rcx, %rcx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rcx
               	negq	%rax
               	subq	%rdx, %rax
               	leaq	0x20(%rsp), %r8
               	movq	(%rdi), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	%rdx, %rdi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	movq	%rdx, 0x38(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	xorq	%r11, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x78, %rsp
               	retq
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	0x18(%rsp), %rsi
               	testq	%rsi, %rsi
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpl	%esi, %ecx
               	je	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %r8
               	negq	%r8
               	movq	%rsi, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	leaq	0x50(%rsp), %rcx
               	movq	%r8, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rsi, %rax
               	xorq	%rdx, %rcx
               	orq	%rax, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rsi
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %r8
               	negq	%r8
               	movq	%rsi, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	leaq	0x60(%rsp), %rcx
               	movq	%r8, 0x60(%rsp)
               	movq	%rsi, 0x68(%rsp)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rsi, %rax
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	addq	$0x78, %rsp
               	retq
               	leaq	0x20(%rsp), %rcx
               	jmp	<addr>
               	leaq	0x30(%rsp), %rcx
               	jmp	<addr>

<main>:
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rax
               	movl	$0xa, %edx
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movabsq	$-0x6666666666666667, %r11 # imm = 0x9999999999999999
               	xorq	%r11, %rax
               	movabsq	$0x1999999999999999, %rcx # imm = 0x1999999999999999
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rax
               	movl	$0xa, %edx
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	xorq	$0x5, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movq	$-0x2, %rcx
               	xorl	%edx, %edx
               	movq	$-0x1, %rax
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rdx, %rcx
               	movq	%rax, %rdx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x2, %rcx
               	xorl	%edx, %edx
               	movq	$-0x1, %rax
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rdx, %rcx
               	movq	%rax, %rdx
               	callq	<addr>
               	xorq	$-0x2, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x5, %eax
               	xorl	%ecx, %ecx
               	movl	$0x7, %edx
               	movl	$0x1, %esi
               	movq	%rdx, %rdi
               	movq	%rcx, %rdx
               	movq	%rsi, %rcx
               	movq	%rax, %rsi
               	callq	<addr>
               	xorq	$0x5, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	xorl	%ecx, %ecx
               	movl	$0x7, %edx
               	movl	$0x1, %esi
               	movq	%rdx, %rdi
               	movq	%rcx, %rdx
               	movq	%rsi, %rcx
               	movq	%rax, %rsi
               	callq	<addr>
               	xorq	$0x7, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movq	$-0x1, %rax
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x2, %rcx
               	movq	$-0x1, %rax
               	movq	%rcx, %rdi
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x123, %eax            # imm = 0x123
               	xorl	%ecx, %ecx
               	movl	$0x456, %edx            # imm = 0x456
               	movl	$0x1, %esi
               	movq	%rdx, %rdi
               	movq	%rsi, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	xorq	$0x456, %rax            # imm = 0x456
               	xorq	$0x123, %rdx            # imm = 0x123
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x123, %eax            # imm = 0x123
               	xorl	%ecx, %ecx
               	movl	$0x456, %edx            # imm = 0x456
               	movl	$0x1, %esi
               	movq	%rdx, %rdi
               	movq	%rsi, %rdx
               	movq	%rax, %rsi
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	xorl	%r15d, %r15d
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%r15,8), %rbx
               	leaq	-0x1(%rbx), %r12
               	xorl	%r13d, %r13d
               	movq	$-0x1, %r14
               	leaq	0x30(%rsp), %r8
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x1(%rbx), %r13
               	xorl	%r12d, %r12d
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rdx, %rbp
               	movq	%r12, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	xorq	%r14, %rax
               	xorq	%rbp, %rdx
               	orq	%rdx, %rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %r12
               	shrq	%r12
               	xorl	%r13d, %r13d
               	movl	$0x3039, %r14d          # imm = 0x3039
               	leaq	0x30(%rsp), %r8
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%r12d, %r12d
               	movl	$0x1, %r13d
               	leaq	0x30(%rsp), %r8
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rdx, %rbp
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	xorq	%r14, %rax
               	xorq	%rbp, %rdx
               	orq	%rdx, %rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rdx, %rbp
               	movq	%r12, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%r14, %rax
               	xorq	%rbp, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3039, %r13d          # imm = 0x3039
               	xorl	%r12d, %r12d
               	leaq	0x30(%rsp), %r8
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rdx, %rbp
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%r14, %rax
               	xorq	%rbp, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	cmpl	$0x13, %r15d
               	jl	<addr>
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	leaq	0x40(%r15), %rcx
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	movq	%rdi, %r12
               	subq	%rsi, %r12
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	shlxq	%rsi, %rax, %rbx
               	shrxq	%r12, %rax, %r12
               	shrq	%r12
               	shlxq	%rsi, %rdx, %rsi
               	orq	%r12, %rsi
               	movq	%rbx, %r13
               	andq	%r9, %r13
               	andq	%r9, %rsi
               	andq	%rbx, %r8
               	movq	%rsi, %r12
               	orq	%r8, %r12
               	movabsq	$-0x6543210fedcba988, %rbx # imm = 0x9ABCDEF012345678
               	orq	%r13, %rbx
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	%rdi, %r13
               	subq	%rsi, %r13
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %r8
               	xorq	$-0x1, %r8
               	shlxq	%rsi, %rax, %r9
               	shrxq	%r13, %rax, %r13
               	shrq	%r13
               	shlxq	%rsi, %rdx, %rsi
               	orq	%r13, %rsi
               	movq	%r9, %r13
               	andq	%r8, %r13
               	andq	%r8, %rsi
               	andq	%r9, %rcx
               	movq	%rsi, %r14
               	orq	%rcx, %r14
               	leaq	0x40(%r15), %rsi
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	%rdi, %r9
               	subq	%rcx, %r9
               	shrq	$0x6, %rsi
               	negq	%rsi
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	shlxq	%rcx, %rax, %r8
               	shrxq	%r9, %rax, %rax
               	shrq	%rax
               	shlxq	%rcx, %rdx, %rcx
               	orq	%rax, %rcx
               	movq	%r8, %rax
               	andq	%rdi, %rax
               	andq	%rdi, %rcx
               	andq	%r8, %rsi
               	orq	%rsi, %rcx
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	decq	%rax
               	subq	%rdx, %rcx
               	orq	%rax, %r13
               	orq	%rcx, %r14
               	cmpq	$0x1, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%rbx), %rcx
               	movq	%r12, %rsi
               	subq	%rax, %rsi
               	leaq	0x30(%rsp), %r8
               	movq	%rcx, 0x58(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rcx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rcx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x30(%rsp), %r8
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rcx
               	leaq	0x30(%rsp), %r8
               	movq	%rcx, 0x58(%rsp)
               	movq	%rcx, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	%rcx, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rbx
               	leaq	0x30(%rsp), %r8
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rdx, %rbp
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	xorq	%r12, %rax
               	xorq	%rbp, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	cmpq	%r13, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rbx
               	subq	%r13, %rbx
               	subq	%r14, %rax
               	movq	%rax, %r12
               	subq	%rcx, %r12
               	leaq	0x30(%rsp), %r8
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x1(%r13), %rbx
               	cmpq	%r13, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	(%r14,%rax), %r12
               	leaq	0x30(%rsp), %r8
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rbp
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rbp, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	nop
               	cmpl	$0x40, %r15d
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rax
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	leaq	0x30(%rsp), %r8
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	xchgq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	$-0x1, %rcx
               	xorl	%esi, %esi
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	movq	%rsi, %rdx
               	movq	%rcx, %rsi
               	xchgq	%rcx, %rdi
               	callq	<addr>
               	xorq	%rbx, %rax
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	xorl	%ecx, %ecx
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	xchgq	%rdx, %rcx
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x1, %edx
               	leaq	0x30(%rsp), %r8
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	$-0x1, %rcx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movl	$0x1, %edi
               	movq	%rdi, %rdx
               	movq	%rcx, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	xorq	%rbx, %rax
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x1, %edx
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rax, %rdi
               	movq	%rax, %rdx
               	movq	%rcx, %rsi
               	callq	<addr>
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x2, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rax, %rcx
               	callq	<addr>
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xchgq	%rdx, %rcx
               	xchgq	%rsi, %rdx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xchgq	%rdx, %rcx
               	xchgq	%rsi, %rdx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rdx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rdx, %rdi
               	movq	%rax, %rdx
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rdx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rdx, %rdi
               	movq	%rax, %rdx
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movq	$-0x7, %rax
               	movq	$-0x1, %rcx
               	movl	$0x2, %edx
               	xorl	%esi, %esi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	xorq	$-0x3, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x7, %rax
               	movq	$-0x1, %rcx
               	movl	$0x2, %edx
               	xorl	%esi, %esi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	xorq	$-0x3, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x3, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rax, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	$-0x3, %rdx
               	movq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %ecx
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	$-0x1, %rax
               	movq	%rcx, %rdi
               	movq	%rax, %rcx
               	movq	%rdx, %rsi
               	movq	%rax, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movabsq	$0x1000000000, %rdx     # imm = 0x1000000000
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rdx, %rcx
               	movq	%rax, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	$-0x1, %rdx
               	movq	$-0x2, %rsi
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	xorl	%r14d, %r14d
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, %rbx
               	shrq	$0x1d, %rbx
               	xorq	%rax, %rbx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r12 # imm = 0x14057B7EF767814F
               	addq	%rax, %r12
               	movq	%r12, <rip> # <addr>
               	movq	%r12, %rax
               	shrq	$0x1d, %rax
               	xorq	%rax, %r12
               	movl	$0xa, %ecx
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%r13d, %r13d
               	cmpq	$0xa, %rbx
               	jb	<addr>
               	movq	%rbx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	mulq	%rsi
               	movq	%rdx, %r13
               	shrq	%r13
               	imulq	$0xa, %r13, %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%r12, %rax
               	divq	%rcx
               	movq	%rax, %r15
               	xorl	%eax, %eax
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	xorq	%r15, %rax
               	xorq	%r13, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %ecx
               	nopl	(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	$0xa, %rbx
               	jb	<addr>
               	movq	%rbx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	mulq	%rsi
               	movq	%rdx, %rsi
               	shrq	%rsi
               	imulq	$0xa, %rsi, %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%r12, %rax
               	divq	%rcx
               	imulq	%rcx, %rax
               	movq	%r12, %rcx
               	subq	%rax, %rcx
               	movq	0x30(%rsp), %rax
               	movq	0x38(%rsp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	nopl	(%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%r13d, %r13d
               	nopw	(%rax,%rax)
               	cmpq	%rcx, %rbx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	movq	%rbx, %rax
               	mulq	%rsi
               	movq	%rdx, %r13
               	shrq	$0x1d, %r13
               	imulq	$0x3b9aca07, %r13, %rax # imm = 0x3B9ACA07
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%r12, %rax
               	divq	%rcx
               	movq	%rax, %r15
               	xorl	%eax, %eax
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	xorq	%r15, %rax
               	xorq	%r13, %rdx
               	orq	%rdx, %rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	testq	%rbx, %rbx
               	je	<addr>
               	nopw	(%rax,%rax)
               	cmpq	%rcx, %rbx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	movq	%rbx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	shrq	$0x1d, %rsi
               	imulq	$0x3b9aca07, %rsi, %rax # imm = 0x3B9ACA07
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%r12, %rax
               	divq	%rcx
               	imulq	%rcx, %rax
               	movq	%r12, %rcx
               	subq	%rax, %rcx
               	movq	0x30(%rsp), %rax
               	movq	0x38(%rsp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %esi
               	movl	$0x5, %edi
               	movq	%rbx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %rcx # imm = 0xC000000000000001
               	movq	%rbx, %rdx
               	shrq	%rdx
               	movq	%r12, %rax
               	shrq	%rax
               	movq	%rbx, %r8
               	shlq	$0x3f, %r8
               	orq	%r8, %rax
               	divq	%rcx
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rax
               	mulq	%rdi
               	imulq	%rcx, %rsi
               	imulq	%rcx, %rdi
               	leaq	(%rdx,%rsi), %rax
               	cmpq	%rdi, %r12
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%r12, %rsi
               	subq	%rdi, %rsi
               	movq	%rbx, %rdi
               	subq	%rax, %rdi
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	cmpq	$0x3, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x5, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	leaq	(%rcx,%rax), %r13
               	movl	$0x3, %eax
               	movl	$0x5, %ecx
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	xorq	%r13, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %esi
               	movl	$0x5, %ecx
               	movq	%rbx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %rdi # imm = 0xC000000000000001
               	movq	%rbx, %rdx
               	shrq	%rdx
               	movq	%r12, %rax
               	shrq	%rax
               	movq	%rbx, %r8
               	shlq	$0x3f, %r8
               	orq	%r8, %rax
               	divq	%rdi
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	imulq	%rcx, %rdi
               	addq	%rax, %rdx
               	cmpq	%rdi, %r12
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%r12, %rax
               	subq	%rdi, %rax
               	movq	%rbx, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %rdx
               	subq	%r8, %rdx
               	cmpq	$0x3, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x3, %rdx
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x5, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	orq	%r8, %rdi
               	movq	%rdi, %r8
               	xorq	$0x1, %r8
               	movq	%r8, %rdi
               	negq	%rdi
               	movq	%rcx, %r8
               	andq	%rdi, %r8
               	andq	%rdi, %rsi
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rcx
               	subq	%r8, %rcx
               	movq	%rdx, %rax
               	subq	%rsi, %rax
               	subq	%rdi, %rax
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	xorq	%rdx, %rcx
               	xorq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rcx
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%esi, %esi
               	cmpq	$-0x1, %rbx
               	setae	%r15b
               	movzbq	%r15b, %r15
               	leaq	(%rbx,%r15), %rdx
               	cmpq	%rcx, %rbx
               	cmovbq	%rbx, %rdx
               	cmovbq	%rsi, %r15
               	movq	%r12, %rax
               	divq	%rcx
               	movq	%rax, %r13
               	xorl	%eax, %eax
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	callq	<addr>
               	xorq	%r13, %rax
               	xorq	%r15, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rcx
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	$-0x1, %rbx
               	setae	%al
               	movzbq	%al, %rax
               	leaq	(%rbx,%rax), %rdx
               	cmpq	%rcx, %rbx
               	cmovbq	%rbx, %rdx
               	movq	%r12, %rax
               	divq	%rcx
               	leaq	(%r12,%rax), %rcx
               	movq	0x30(%rsp), %rax
               	movq	0x38(%rsp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %r12
               	setae	%al
               	movzbq	%al, %rax
               	leaq	(%r12,%rax), %rcx
               	jmp	<addr>
               	cmpq	$-0x1, %r12
               	setae	%r13b
               	movzbq	%r13b, %r13
               	xorl	%eax, %eax
               	movq	%rax, %r15
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rsi # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%r12, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	shrq	$0x2, %rdi
               	movq	%rdi, %rax
               	imulq	%rcx, %rax
               	movq	%r12, %rcx
               	subq	%rax, %rcx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rcx # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%r12, %rax
               	mulq	%rcx
               	movq	%rdx, %r13
               	shrq	$0x2, %r13
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%r12, %rax
               	mulq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x1d, %rax
               	imulq	$0x3b9aca07, %rax, %rax # imm = 0x3B9ACA07
               	movq	%r12, %rcx
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rsi # imm = 0x89705F3112A28FE5
               	movq	%r12, %rax
               	mulq	%rsi
               	movq	%rdx, %r15
               	shrq	$0x1d, %r15
               	xorl	%eax, %eax
               	movq	%rax, %r13
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movq	%r12, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %rax
               	shrq	%rax
               	imulq	$0xa, %rax, %rax
               	movq	%r12, %rcx
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rbx, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%r12, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	mulq	%rsi
               	movq	%rdx, %r15
               	shrq	%r15
               	xorl	%eax, %eax
               	movq	%rax, %r13
               	jmp	<addr>
               	incq	%r14
               	cmpl	$0xc8, %r14d
               	jl	<addr>
               	xorl	%ebp, %ebp
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, %r13
               	shrq	$0x1d, %r13
               	xorq	%rax, %r13
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, %r14
               	shrq	$0x1d, %r14
               	xorq	%rax, %r14
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x1d, %rcx
               	xorq	%rax, %rcx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, %rdx
               	shrq	$0x1d, %rdx
               	movq	%rax, %r8
               	xorq	%rdx, %r8
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shrq	$0x1d, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	shrxq	%rax, %rcx, %rdi
               	shlxq	%r9, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rax, %r8, %rax
               	orq	%rcx, %rax
               	andq	%rsi, %rax
               	andq	%rdi, %rdx
               	movq	%rax, %rbx
               	orq	%rdx, %rbx
               	andq	%rdi, %rsi
               	movq	%rbx, %rax
               	orq	%rsi, %rax
               	movl	$0x1, %ecx
               	xorl	%r12d, %r12d
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	cmovneq	%rsi, %r12
               	leaq	0x30(%rsp), %r8
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%rdx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	xorq	%r15, %rax
               	xorq	0x68(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1d, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rax
               	movl	$0x3f, %edx
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	shrxq	%rax, %r13, %rsi
               	shlxq	%rdi, %r13, %rdi
               	shlq	%rdi
               	shrxq	%rax, %r14, %rax
               	orq	%rdi, %rax
               	andq	%rdx, %rax
               	andq	%rsi, %rcx
               	movq	%rax, %r15
               	orq	%rcx, %r15
               	movq	%rsi, %rcx
               	andq	%rdx, %rcx
               	leaq	0x30(%rsp), %r8
               	movq	%rcx, 0x58(%rsp)
               	movq	%r15, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	movq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	%r15, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r15, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x1(%rbx), %r15
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	shrq	$0x1d, %rax
               	xorq	%rax, %rcx
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	orq	$0x1, %rdi
               	leaq	0x30(%rsp), %r8
               	movq	%rcx, 0x58(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x48(%rsp)
               	movq	%rdi, %rdx
               	movq	%rcx, %rdi
               	movq	%rsi, %rcx
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x48(%rsp), %rdi
               	movq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x48(%rsp)
               	movq	%rdi, %rdx
               	movq	%rcx, %rdi
               	movq	%rsi, %rcx
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	0x58(%rsp), %rcx
               	movq	0x50(%rsp), %rsi
               	movq	0x48(%rsp), %rdi
               	xorq	0x68(%rsp), %rax
               	xorq	0x60(%rsp), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdi, %rdx
               	movq	%rcx, %rdi
               	movq	%rsi, %rcx
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	%r13, %rcx
               	shrq	%rcx
               	movq	%r14, %rax
               	shrq	%rax
               	movq	%r13, %rdx
               	shlq	$0x3f, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rax
               	negq	%rcx
               	subq	%rdx, %rcx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	%r13, %rcx
               	shrq	%rcx
               	movq	%r14, %rdx
               	shrq	%rdx
               	movq	%r13, %rax
               	shlq	$0x3f, %rax
               	orq	%rax, %rdx
               	movq	%r12, %rsi
               	shrq	%rsi
               	movq	%rbx, %rax
               	shrq	%rax
               	movq	%r12, %rdi
               	shlq	$0x3f, %rdi
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %r8
               	negq	%r8
               	negq	%rsi
               	subq	%rdi, %rsi
               	cmpq	$0x1, %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorq	$-0x1, %rax
               	subq	%rdi, %rsi
               	movq	%rdx, %rdi
               	movq	%rax, %rdx
               	xchgq	%rsi, %rcx
               	callq	<addr>
               	nop
               	testl	%eax, %eax
               	je	<addr>
               	incq	%rbp
               	cmpl	$0x3e8, %ebp            # imm = 0x3E8
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x48, %rsp
               	retq
