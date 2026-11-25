
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
               	shlxq	%rax, %rcx, %r10
               	movq	%r8, %rax
               	shrq	%rax
               	shrxq	%r9, %rax, %rax
               	orq	%rax, %r10
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%rsi, %r11
               	shlq	$0x3f, %r11
               	orq	%r11, %rax
               	divq	%r10
               	shrxq	%r9, %rax, %r9
               	testq	%r9, %r9
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r9
               	movq	%r9, %rax
               	mulq	%r8
               	movq	%r9, %r10
               	imulq	%rcx, %r10
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	addq	%r10, %rdx
               	cmpq	%rax, %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	subq	%rax, %rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	subq	%r10, %rax
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
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	leaq	(%r9,%rdx), %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
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
               	shlxq	%rax, %rcx, %r10
               	movq	%r8, %rax
               	shrq	%rax
               	shrxq	%r9, %rax, %rax
               	orq	%rax, %r10
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%rsi, %r11
               	shlq	$0x3f, %r11
               	orq	%r11, %rax
               	divq	%r10
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
               	leaq	(%rdx,%rax), %r10
               	cmpq	%r9, %rdi
               	setb	%r11b
               	movzbq	%r11b, %r11
               	movq	%rdi, %rax
               	subq	%r9, %rax
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	subq	%r11, %rdx
               	cmpq	%rcx, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %rdx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r8, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdi
               	orq	%rdi, %rsi
               	xorq	$0x1, %rsi
               	negq	%rsi
               	movq	%r8, %rdi
               	andq	%rsi, %rdi
               	andq	%rsi, %rcx
               	cmpq	%rdi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rdi, %rax
               	subq	%rcx, %rdx
               	subq	%rsi, %rdx
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
               	subq	$0x30, %rsp
               	pushq	%rbx
               	movq	%rdx, %r8
               	movq	%rsi, %r9
               	sarq	$0x3f, %r9
               	movq	%rcx, %r10
               	sarq	$0x3f, %r10
               	xorq	%r9, %rdi
               	xorq	%r9, %rsi
               	cmpq	%r9, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	subq	%r9, %rdi
               	subq	%r9, %rsi
               	subq	%rax, %rsi
               	xorq	%r10, %r8
               	xorq	%r10, %rcx
               	cmpq	%r10, %r8
               	setb	%al
               	movzbq	%al, %rax
               	subq	%r10, %r8
               	subq	%r10, %rcx
               	subq	%rax, %rcx
               	movq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%r10, 0x18(%rsp)
               	movl	$0x7f, %r10d
               	bsrq	%rcx, %rax
               	cmovel	%r10d, %eax
               	xorl	$0x3f, %eax
               	movq	0x18(%rsp), %r10
               	movq	%rax, %r11
               	xorq	$0x3f, %r11
               	shlxq	%rax, %rcx, %rax
               	movq	%r8, %rdx
               	shrq	%rdx
               	shrxq	%r11, %rdx, %rdx
               	orq	%rdx, %rax
               	movq	%rsi, %rbx
               	shrq	%rbx
               	movq	%rdi, %rdx
               	shrq	%rdx
               	movq	%r10, 0x20(%rsp)
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %rdx
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r11
               	movq	%rdx, %rax
               	movq	%rbx, %rdx
               	divq	%r11
               	movq	0x18(%rsp), %r11
               	shrxq	%r11, %rax, %r11
               	testq	%r11, %r11
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r11
               	movq	%r11, %rax
               	mulq	%r8
               	movq	%r11, %rbx
               	imulq	%rcx, %rbx
               	movq	%r11, %rax
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
               	movq	0x20(%rsp), %r10
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	leaq	(%r11,%rdx), %rax
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	xorq	%r10, %rdx
               	xorq	%rdx, %rax
               	xorq	%rdx, %rcx
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rdx, %rax
               	subq	%rdx, %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %rdx
               	popq	%rbx
               	addq	$0x30, %rsp
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

<smod>:
               	subq	$0x28, %rsp
               	movq	%rdx, %r9
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%r8, %rdi
               	xorq	%r8, %rsi
               	cmpq	%r8, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r8, %rdi
               	subq	%r8, %rsi
               	subq	%rdx, %rsi
               	xorq	%rax, %r9
               	xorq	%rax, %rcx
               	cmpq	%rax, %r9
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%rax, %r9
               	subq	%rax, %rcx
               	subq	%rdx, %rcx
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
               	movq	%rax, %r10
               	xorq	$0x3f, %r10
               	shlxq	%rax, %rcx, %r11
               	movq	%r9, %rax
               	shrq	%rax
               	shrxq	%r10, %rax, %rax
               	orq	%rax, %r11
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rax
               	shrq	%rax
               	movq	%r10, 0x10(%rsp)
               	movq	%rsi, %r10
               	shlq	$0x3f, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %rax
               	divq	%r11
               	movq	0x10(%rsp), %r10
               	shrxq	%r10, %rax, %r10
               	testq	%r10, %r10
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r10
               	movq	%r10, %rax
               	mulq	%r9
               	movq	%r10, %rax
               	imulq	%rcx, %rax
               	imulq	%r9, %r10
               	addq	%rdx, %rax
               	cmpq	%r10, %rdi
               	setb	%r11b
               	movzbq	%r11b, %r11
               	subq	%r10, %rdi
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	subq	%r11, %rdx
               	cmpq	%rcx, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r9, %rdi
               	setb	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	orq	%rax, %rsi
               	xorq	$0x1, %rsi
               	movq	%rsi, %rax
               	negq	%rax
               	movq	%r9, %rsi
               	andq	%rax, %rsi
               	andq	%rax, %rcx
               	cmpq	%rsi, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	subq	%rsi, %rdi
               	subq	%rcx, %rdx
               	subq	%rax, %rdx
               	xorq	%r8, %rdi
               	xorq	%r8, %rdx
               	cmpq	%r8, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	subq	%r8, %rdi
               	subq	%r8, %rdx
               	subq	%rax, %rdx
               	movq	%rdi, %rax
               	addq	$0x28, %rsp
               	retq
               	cmpq	%r9, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rdx, %rsi
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	divq	%r9
               	imulq	%r9, %rax
               	subq	%rax, %rdi
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rdx, %rdi
               	xorl	%edx, %edx
               	jmp	<addr>

<reference>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbp
               	movq	%r8, 0x38(%rsp)
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %rdi
               	xorl	%eax, %eax
               	movl	$0x7f, %ecx
               	movq	%rax, %r9
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	decq	%rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	movq	%r9, %r15
               	shrq	$0x3f, %r15
               	movq	%rax, %r10
               	shlq	%r10
               	movq	%r10, 0x48(%rsp)
               	shlq	%r9
               	shrq	$0x3f, %rax
               	orq	%rax, %r9
               	movq	%rcx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %r8d
               	subq	%rax, %r8
               	movq	%rcx, %r10
               	shrq	$0x6, %r10
               	movq	%r10, %rbx
               	negq	%rbx
               	movq	%rbx, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x40(%rsp)
               	shrxq	%rax, %rdi, %r12
               	shlxq	%r8, %rdi, %r11
               	shlq	%r11
               	shrxq	%rax, %rbp, %r10
               	orq	%r11, %r10
               	andq	0x40(%rsp), %r10
               	andq	%rbx, %r12
               	orq	%r12, %r10
               	andq	$0x1, %r10
               	movq	0x48(%rsp), %rax
               	orq	%r10, %rax
               	testq	%r15, %r15
               	jne	<addr>
               	cmpq	%r14, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	cmpq	%r14, %r9
               	sete	%r11b
               	movzbq	%r11b, %r11
               	cmpq	%r13, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %r11
               	orq	%r11, %r10
               	xorq	$0x1, %r10
               	nopl	(%rax)
               	testq	%r10, %r10
               	je	<addr>
               	cmpq	%r13, %rax
               	setb	%r10b
               	movzbq	%r10b, %r10
               	subq	%r13, %rax
               	subq	%r14, %r9
               	subq	%r10, %r9
               	movl	$0x1, %r11d
               	xorl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	%rcx, %r10
               	andq	$0x3f, %r10
               	movl	$0x3f, %ebx
               	subq	%r10, %rbx
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	movq	%r8, %r12
               	negq	%r12
               	movq	%r12, %r15
               	xorq	$-0x1, %r15
               	shlxq	%r10, %r11, %r8
               	shrxq	%rbx, %r11, %rbx
               	shrq	%rbx
               	movq	%r10, %r11
               	movq	0x48(%rsp), %r10
               	shlxq	%r11, %r10, %r10
               	orq	%rbx, %r10
               	movq	%r8, %r11
               	andq	%r15, %r11
               	andq	%r15, %r10
               	andq	%r12, %r8
               	orq	%r8, %r10
               	orq	%r11, %rdx
               	orq	%r10, %rsi
               	jmp	<addr>
               	movq	0x38(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movq	%r9, 0x8(%rcx)
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
               	leaq	(%rsp), %rax
               	movq	%rsi, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	(%rsp), %rcx
               	testq	%rsi, %rsi
               	jge	<addr>
               	testq	%rcx, %rcx
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdx
               	negq	%rdx
               	movq	%rsi, %rcx
               	negq	%rcx
               	subq	%rax, %rcx
               	leaq	0x40(%rsp), %rax
               	movq	%rdx, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	testq	%rdx, %rdx
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rdx
               	negq	%rcx
               	subq	%rsi, %rcx
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	leaq	0x20(%rsp), %r8
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
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %rsi
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rcx
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
               	negq	%rsi
               	subq	%rdi, %rsi
               	leaq	0x50(%rsp), %rcx
               	movq	%r8, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rsi, %rax
               	xorq	%rcx, %rdx
               	orq	%rdx, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %rsi
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rcx
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
               	negq	%rsi
               	subq	%rdi, %rsi
               	leaq	0x60(%rsp), %rcx
               	movq	%r8, 0x60(%rsp)
               	movq	%rsi, 0x68(%rsp)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rsi, %rax
               	xorq	%rcx, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
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
               	movq	$-0x1, %rdi
               	movl	$0xa, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movabsq	$-0x6666666666666667, %r11 # imm = 0x9999999999999999
               	xorq	%r11, %rax
               	movabsq	$0x1999999999999999, %rcx # imm = 0x1999999999999999
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rdi
               	movl	$0xa, %edx
               	movq	%rdi, %rsi
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
               	movq	$-0x2, %rsi
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rdi
               	movq	%rdi, %rdx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x2, %rsi
               	xorl	%ecx, %ecx
               	movq	$-0x1, %rdi
               	movq	%rdi, %rdx
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
               	movl	$0x5, %esi
               	xorl	%edx, %edx
               	movl	$0x7, %edi
               	movl	$0x1, %ecx
               	callq	<addr>
               	xorq	$0x5, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %esi
               	xorl	%edx, %edx
               	movl	$0x7, %edi
               	movl	$0x1, %ecx
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
               	movq	$-0x1, %rdi
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x2, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %rdx
               	movq	%rsi, %rcx
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
               	movl	$0x123, %esi            # imm = 0x123
               	xorl	%ecx, %ecx
               	movl	$0x456, %edi            # imm = 0x456
               	movl	$0x1, %edx
               	callq	<addr>
               	xorq	$0x456, %rax            # imm = 0x456
               	xorq	$0x123, %rdx            # imm = 0x123
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x123, %esi            # imm = 0x123
               	xorl	%ecx, %ecx
               	movl	$0x456, %edi            # imm = 0x456
               	movl	$0x1, %edx
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
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	nopl	(%rax)
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
               	movq	%r12, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	leaq	0x30(%rsp), %r8
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
               	movq	%r14, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %r8
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
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %r12
               	xorl	%r13d, %r13d
               	movq	%r12, %rdi
               	movq	%r13, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	movq	%r13, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	nop
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
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	nopl	(%rax)
               	cmpl	$0x13, %r15d
               	jl	<addr>
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	xorl	%esi, %esi
               	leaq	0x40(%r15), %rdx
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r8d
               	movq	%r8, %r9
               	subq	%rcx, %r9
               	movq	%rdx, %rdi
               	shrq	$0x6, %rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movq	%r10, %r11
               	xorq	$-0x1, %r11
               	shlxq	%rcx, %rax, %rdi
               	shrxq	%r9, %rax, %rbx
               	shrq	%rbx
               	shlxq	%rcx, %rsi, %r12
               	orq	%rbx, %r12
               	movq	%rdi, %rbx
               	andq	%r11, %rbx
               	andq	%r11, %r12
               	andq	%r10, %rdi
               	orq	%rdi, %r12
               	movabsq	$-0x6543210fedcba988, %r11 # imm = 0x9ABCDEF012345678
               	orq	%r11, %rbx
               	shrq	$0x6, %rdx
               	movq	%rdx, %rdi
               	negq	%rdi
               	movq	%rdi, %r10
               	xorq	$-0x1, %r10
               	shlxq	%rcx, %rax, %rdx
               	shrxq	%r9, %rax, %r9
               	shrq	%r9
               	shlxq	%rcx, %rsi, %rcx
               	orq	%r9, %rcx
               	movq	%rdx, %r13
               	andq	%r10, %r13
               	andq	%r10, %rcx
               	andq	%rdi, %rdx
               	orq	%rdx, %rcx
               	leaq	0x40(%r15), %rdi
               	movq	%rdi, %rdx
               	andq	$0x3f, %rdx
               	subq	%rdx, %r8
               	shrq	$0x6, %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	shlxq	%rdx, %rax, %rdi
               	shrxq	%r8, %rax, %rax
               	shrq	%rax
               	shlxq	%rdx, %rsi, %r14
               	orq	%rax, %r14
               	movq	%rdi, %rax
               	andq	%r10, %rax
               	andq	%r10, %r14
               	andq	%r9, %rdi
               	orq	%rdi, %r14
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	decq	%rax
               	subq	%rdx, %r14
               	orq	%rax, %r13
               	orq	%rcx, %r14
               	cmpq	$0x1, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%rbx), %rcx
               	movq	%r12, %rsi
               	subq	%rax, %rsi
               	movq	%rcx, 0x58(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rcx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	leaq	0x30(%rsp), %r8
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
               	nop
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	movq	%rcx, 0x58(%rsp)
               	movq	%rcx, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	leaq	0x30(%rsp), %r8
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
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %r8
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
               	movq	$-0x1, %r12
               	cmpq	%r13, %r12
               	setb	%al
               	movzbq	%al, %rax
               	movq	%r12, %rbx
               	subq	%r13, %rbx
               	subq	%r14, %r12
               	subq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	leaq	0x30(%rsp), %r8
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
               	xorl	%edx, %edx
               	movq	$-0x1, %rdi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rdi, %rsi
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	$-0x1, %rdi
               	xorl	%edx, %edx
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	xorl	%edx, %edx
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x1, %edx
               	movq	%rdi, %rsi
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	$-0x1, %rdi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x1, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x1, %edx
               	movq	%rdi, %rsi
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
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rdi, %rcx
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rdi, %rcx
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rdi, %rdx
               	movq	%rsi, %rcx
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
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movl	$0x2, %edx
               	movq	%rdi, %rcx
               	callq	<addr>
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rcx
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
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rdx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rdx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edx, %edx
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rdi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	callq	<addr>
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edx, %edx
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rdi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
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
               	movq	$-0x7, %rdi
               	movq	$-0x1, %rsi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	xorq	$-0x3, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x7, %rdi
               	movq	$-0x1, %rsi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	xorl	%esi, %esi
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rcx
               	callq	<addr>
               	xorq	$-0x3, %rax
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	xorl	%esi, %esi
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rcx
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
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movl	$0x3, %edx
               	movq	%rdi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	$-0x3, %rdx
               	movq	$-0x1, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rdi, %rdx
               	movq	%rdi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	$-0x1, %rdx
               	movq	%rdx, %rcx
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
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x1000000000, %rcx     # imm = 0x1000000000
               	movq	%rdi, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	$-0x1, %rdx
               	movq	$-0x2, %rcx
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
               	movl	$0xa, %esi
               	nop
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%r13d, %r13d
               	cmpq	$0xa, %rbx
               	jb	<addr>
               	movq	%rbx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %r13
               	shrq	%r13
               	imulq	$0xa, %r13, %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%r12, %rax
               	divq	%rsi
               	movq	%rax, %r15
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	xorq	%r15, %rax
               	xorq	%r13, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %ecx
               	testq	%rbx, %rbx
               	je	<addr>
               	nopw	(%rax,%rax)
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
               	movq	%rax, %rdx
               	imulq	%rcx, %rdx
               	movq	%r12, %rax
               	subq	%rdx, %rax
               	movq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b9aca07, %esi       # imm = 0x3B9ACA07
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%r13d, %r13d
               	cmpq	%rsi, %rbx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%rbx, %rax
               	mulq	%rcx
               	movq	%rdx, %r13
               	shrq	$0x1d, %r13
               	imulq	$0x3b9aca07, %r13, %rax # imm = 0x3B9ACA07
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	movq	%r12, %rax
               	divq	%rsi
               	movq	%rax, %r15
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	xorq	%r15, %rax
               	xorq	%r13, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3b9aca07, %ecx       # imm = 0x3B9ACA07
               	testq	%rbx, %rbx
               	je	<addr>
               	nopl	(%rax,%rax)
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
               	movq	%rax, %rdx
               	imulq	%rcx, %rdx
               	movq	%r12, %rax
               	subq	%rdx, %rax
               	movq	0x30(%rsp), %rcx
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
               	movq	%rax, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	imulq	%rsi, %rax
               	imulq	%rcx, %rdi
               	addq	%rax, %rdx
               	cmpq	%rdi, %r12
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%r12, %r9
               	subq	%rdi, %r9
               	movq	%rbx, %rax
               	subq	%rdx, %rax
               	subq	%r8, %rax
               	cmpq	$0x3, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x5, %r9
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	orq	%rax, %rdx
               	xorq	$0x1, %rdx
               	leaq	(%rcx,%rdx), %r13
               	movl	$0x5, %edx
               	movq	%r12, %rdi
               	movq	%rsi, %rcx
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	xorq	%r13, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %r8d
               	movl	$0x5, %edi
               	movq	%rbx, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %rcx # imm = 0xC000000000000001
               	movq	%rbx, %rdx
               	shrq	%rdx
               	movq	%r12, %rax
               	shrq	%rax
               	movq	%rbx, %rsi
               	shlq	$0x3f, %rsi
               	orq	%rsi, %rax
               	divq	%rcx
               	movq	%rax, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	imulq	%r8, %rax
               	imulq	%rdi, %rsi
               	addq	%rax, %rdx
               	cmpq	%rsi, %r12
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%r12, %rcx
               	subq	%rsi, %rcx
               	movq	%rbx, %rax
               	subq	%rdx, %rax
               	subq	%r9, %rax
               	cmpq	$0x3, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x3, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x5, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	%rdx, %rsi
               	xorq	$0x1, %rsi
               	movq	%rsi, %rdx
               	negq	%rdx
               	andq	%rdx, %rdi
               	andq	%rdx, %r8
               	cmpq	%rdi, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%rdi, %rcx
               	subq	%r8, %rax
               	subq	%rdx, %rax
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	xorq	%rdx, %rcx
               	xorq	%rsi, %rax
               	orq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	$-0x1, %rsi
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%ecx, %ecx
               	cmpq	$-0x1, %rbx
               	setae	%r15b
               	movzbq	%r15b, %r15
               	leaq	(%rbx,%r15), %rdx
               	cmpq	%rsi, %rbx
               	cmovbq	%rbx, %rdx
               	cmovbq	%rcx, %r15
               	movq	%r12, %rax
               	divq	%rsi
               	movq	%rax, %r13
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	movq	%rbx, %rsi
               	leaq	0x30(%rsp), %r8
               	callq	<addr>
               	xorq	%r13, %rax
               	xorq	%r15, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rcx
               	nopl	(%rax)
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
               	xorq	%rax, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	nop
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
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rcx # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%r12, %rax
               	mulq	%rcx
               	shrq	$0x2, %rdx
               	imulq	%rdi, %rdx
               	movq	%r12, %rcx
               	subq	%rdx, %rcx
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
               	shrq	$0x1d, %rdx
               	imulq	$0x3b9aca07, %rdx, %rcx # imm = 0x3B9ACA07
               	movq	%r12, %rax
               	subq	%rcx, %rax
               	jmp	<addr>
               	movq	%rbx, %rdx
               	nop
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%r12, %rax
               	mulq	%rcx
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
               	shrq	%rdx
               	imulq	$0xa, %rdx, %rcx
               	movq	%r12, %rax
               	subq	%rcx, %rax
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movq	%r12, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %r15
               	shrq	%r15
               	xorl	%eax, %eax
               	movq	%rax, %r13
               	nopl	(%rax)
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
               	movq	%rax, %rsi
               	shrq	$0x1d, %rsi
               	xorq	%rax, %rsi
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
               	movl	$0x3f, %edi
               	subq	%rax, %rdi
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r8
               	xorq	$-0x1, %r8
               	shrxq	%rax, %rcx, %r12
               	shlxq	%rdi, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rax, %rsi, %rbx
               	orq	%rcx, %rbx
               	andq	%r8, %rbx
               	andq	%r12, %rdx
               	orq	%rdx, %rbx
               	andq	%r8, %r12
               	movq	%rbx, %rax
               	orq	%r12, %rax
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	cmoveq	%rdx, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r13, %rsi
               	leaq	0x30(%rsp), %r8
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
               	subq	%rax, %rdx
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	shrxq	%rax, %r13, %rdi
               	shlxq	%rdx, %r13, %rdx
               	shlq	%rdx
               	shrxq	%rax, %r14, %r15
               	orq	%rdx, %r15
               	andq	%rsi, %r15
               	andq	%rdi, %rcx
               	orq	%rcx, %r15
               	movq	%rdi, %rcx
               	andq	%rsi, %rcx
               	movq	%rcx, 0x58(%rsp)
               	movq	%r15, %rdi
               	movq	%rcx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	leaq	0x30(%rsp), %r8
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
               	nopl	(%rax,%rax)
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
               	movq	%rcx, 0x58(%rsp)
               	movq	%rsi, 0x50(%rsp)
               	movq	%rdi, 0x48(%rsp)
               	movq	%rdi, %rdx
               	movq	%rcx, %rdi
               	movq	%rsi, %rcx
               	movq	%r15, %rsi
               	leaq	0x30(%rsp), %r8
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
               	nopl	(%rax)
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
               	movq	%rax, %rdi
               	negq	%rdi
               	movq	%rcx, %rsi
               	negq	%rsi
               	subq	%rdx, %rsi
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	%r13, %rsi
               	shrq	%rsi
               	movq	%r14, %rdi
               	shrq	%rdi
               	movq	%r13, %rax
               	shlq	$0x3f, %rax
               	orq	%rax, %rdi
               	movq	%r12, %rax
               	shrq	%rax
               	movq	%rbx, %rdx
               	shrq	%rdx
               	movq	%r12, %rcx
               	shlq	$0x3f, %rcx
               	orq	%rcx, %rdx
               	testq	%rdx, %rdx
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %r9
               	negq	%r9
               	movq	%rax, %rcx
               	negq	%rcx
               	subq	%r8, %rcx
               	cmpq	$0x1, %r9
               	setb	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rdx
               	subq	%rax, %rcx
               	callq	<addr>
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
